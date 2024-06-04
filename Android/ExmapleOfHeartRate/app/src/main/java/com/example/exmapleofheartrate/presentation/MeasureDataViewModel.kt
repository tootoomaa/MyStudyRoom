package com.example.exmapleofheartrate.presentation

import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.health.services.client.data.DataTypeAvailability
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.example.exmapleofheartrate.data.HealthServiceRepository
import com.example.exmapleofheartrate.data.MeasureMessage
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.takeWhile
import kotlinx.coroutines.launch

class MeasureDataViewModel(
   private val healthServiceRepository: HealthServiceRepository
) : ViewModel() {

   val enabled: MutableStateFlow<Boolean> = MutableStateFlow(false)
   val hr: MutableState<Double> = mutableStateOf(0.0)
   val availablity: MutableState<DataTypeAvailability> =
      mutableStateOf(DataTypeAvailability.UNKNOWN)

   val uiState: MutableState<UiState> = mutableStateOf(UiState.Startup)

   init {
      viewModelScope.launch {
         val supported = healthServiceRepository.hasHeartRateCapability()
         uiState.value = if (supported) {
            UiState.Supported
         } else {
            UiState.NotSupported
         }
      }

      viewModelScope.launch {
         enabled.collect {
            if (it) {
               healthServiceRepository.heartRateMeasureFlow()
                  .takeWhile { enabled.value }
                  .collect { measureMessage ->
                     when (measureMessage) {
                        is MeasureMessage.MeasureData -> {
                           hr.value = measureMessage.data.last().value
                        }
                        is MeasureMessage.MeasureAvailability -> {
                           availablity.value = measureMessage.availability
                        }
                     }
                  }
            }
         }
      }
   }

   fun toggleEnabled() {
      enabled.value = !enabled.value
      if (!enabled.value) {
         availablity.value = DataTypeAvailability.UNKNOWN
      }
   }
}

class MeasureDataViewModelFactory(
   private val healthServiceRepository: HealthServiceRepository
) : ViewModelProvider.Factory {
   override fun <T : ViewModel> create(modelClass: Class<T>): T {
      // MeasureDataViewModel 을 상속 받았는지 확인
      if (modelClass.isAssignableFrom(MeasureDataViewModel::class.java)) {
         // 컴파일러 경고를 억제, 강제 형변환으로 인항 경고를 억제
         @Suppress("UNCHECKED_CAST")
         // MeasureDataViewModel에 healthServiceRepository를 의존성 주입하여 생성
         return MeasureDataViewModel(healthServiceRepository = healthServiceRepository) as T
      }
      // 상속 받지 않았다면 오류 발생
      throw IllegalArgumentException("Unknown ViewModel class")
   }
}

sealed class UiState {
   object Startup : UiState()
   object NotSupported : UiState()
   object Supported : UiState()
}
