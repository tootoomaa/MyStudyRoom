/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter and
 * https://github.com/android/wear-os-samples/tree/main/ComposeAdvanced to find the most up to date
 * changes to the libraries and their usages.
 */

package com.example.exmapleofheartrate

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material.TimeText
import com.example.exmapleofheartrate.data.HealthServiceRepository
import com.example.exmapleofheartrate.presentation.MeasureDataScreen
import com.example.exmapleofheartrate.presentation.MeasureDataViewModel
import com.example.exmapleofheartrate.presentation.MeasureDataViewModelFactory
import com.example.exmapleofheartrate.presentation.NotSupportedScreen
import com.example.exmapleofheartrate.presentation.UiState
import com.example.exmapleofheartrate.theme.ExmapleOfHeartRateTheme
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.rememberPermissionState

@ExperimentalPermissionsApi
class MainActivity : ComponentActivity() {

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      val healthServiceRepository = (application as MainApplication).healthServiceRepository

      setContent {
         ExmapleOfHeartRateTheme {
            Scaffold(
               modifier = Modifier.fillMaxSize(),
               timeText = { TimeText() }
            ) {
               ShowHeartRate(healthServiceRepository)
            }
         }
      }
   }
}

@ExperimentalPermissionsApi
@Composable
fun ShowHeartRate(healthServicesRepository: HealthServiceRepository) {
   Column(
      modifier = Modifier
         .fillMaxSize()
         .background(Color.Black),
      verticalArrangement = Arrangement.Center
   ) {
      val viewModel: MeasureDataViewModel = viewModel(
         factory = MeasureDataViewModelFactory(healthServicesRepository)
      )

      val enabled by viewModel.enabled.collectAsState()
      val hr by viewModel.hr
      val availability by viewModel.availablity
      val uiState by viewModel.uiState

      if (uiState == UiState.Supported) {
         val permissionState = rememberPermissionState(
            permission = PERMISSION,
            onPermissionResult = { granted ->
               if (granted) viewModel.toggleEnabled()
            }
         )
         MeasureDataScreen(
            hr = hr,
            availability = availability,
            enabled = enabled,
            onButtonClick = { viewModel.toggleEnabled() },
            permissionState = permissionState
         )
      } else if (uiState == UiState.NotSupported) {
         NotSupportedScreen()
      }

   }
}