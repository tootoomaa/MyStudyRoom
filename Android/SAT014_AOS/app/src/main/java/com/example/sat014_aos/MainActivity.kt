package com.example.sat014_aos

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.sp
import com.example.sat014_aos.ui.theme.SAT014_AOSTheme
import com.google.android.gms.wearable.DataClient
import com.google.android.gms.wearable.PutDataMapRequest
import com.google.android.gms.wearable.Wearable
import java.time.Duration
import kotlin.coroutines.cancellation.CancellationException

class MainActivity : ComponentActivity() {

   private val dataClient by lazy { Wearable.getDataClient(this) }
//   val messageClient by lazy { Wearable.getMessageClient(this) }
//   val capabilityClient by lazy { Wearable.getCapabilityClient(this) }

   private val clientDataViewModel by viewModels<ClientDataViewModel>()

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      enableEdgeToEdge()

      setContent {
         SAT014_AOSTheme {
            Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
               MainAppView(
                  count = clientDataViewModel.count,
                  modifier = Modifier.padding(innerPadding),
                  sendAction = { this.sendCount(clientDataViewModel.count) }
               )
            }
         }
      }
   }

   private fun sendCount(count: Int) {
      try {
         val request = PutDataMapRequest.create(COUNT_PATH).apply {
            dataMap.putInt(COUNT_KEY, count)
         }
            .asPutDataRequest()
            .setUrgent()

         val result = dataClient.putDataItem(request)

         Log.d(TAG, "DataItem saved: $result")
      } catch (cancellationException: CancellationException) {
         throw cancellationException
      } catch (exception: Exception) {
         Log.d(TAG, "Saving DataItem failed: $exception")
      }
   }

   companion object {
      private const val TAG = "MainActivity"

      private const val START_ACTIVITY_PATH = "/start-activity"
      private const val COUNT_PATH = "/count"
      private const val IMAGE_PATH = "/image"
      private const val IMAGE_KEY = "photo"
      private const val TIME_KEY = "time"
      private const val COUNT_KEY = "count"
      private const val CAMERA_CAPABILITY = "camera"
      private const val WEAR_CAPABILITY = "wear"

      private val countInterval = Duration.ofSeconds(5)
   }
}
