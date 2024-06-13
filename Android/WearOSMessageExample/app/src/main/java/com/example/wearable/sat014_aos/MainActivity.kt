package com.example.wearable.sat014_aos

import android.annotation.SuppressLint
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.sat014_aos.ui.theme.SAT014_AOSTheme
import com.google.android.gms.tasks.Task
import com.google.android.gms.tasks.Tasks
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.Wearable
import java.time.Duration

class MainActivity : ComponentActivity() {
   //   private val dataClient by lazy { Wearable.getDataClient(this) }
   val messageClient by lazy { Wearable.getMessageClient(this) }
   val capabilityClient by lazy { Wearable.getCapabilityClient(this) }

   private val clientDataViewModel by viewModels<ClientDataViewModel>()

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      enableEdgeToEdge()

      Log.d("MainActivity", "onCreate")

      setContent {
         SAT014_AOSTheme {
            MainAppView(
               vm = clientDataViewModel,
               modifier = Modifier
                  .fillMaxSize()
            )
         }
      }
   }

   override fun onDestroy() {
      super.onDestroy()
      Log.d("MainActivity", "onDestroy")
   }

   override fun onResume() {
      super.onResume()

      Log.d("MainActivity", "onResume")

      messageClient.addListener(clientDataViewModel)
      capabilityClient.addListener(
         clientDataViewModel,
         Uri.parse("wear://"),
         CapabilityClient.FILTER_REACHABLE
      )
   }

   override fun onPause() {
      super.onPause()
      messageClient.removeListener(clientDataViewModel)
      capabilityClient.removeListener(clientDataViewModel)
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

@Composable
fun MainAppView(vm: ClientDataViewModel, modifier: Modifier) {
   Column(
      modifier = modifier,
      horizontalAlignment = Alignment.CenterHorizontally,
      verticalArrangement = Arrangement.Center
   ) {
      Text(
         fontSize = 50.sp,
         text = "count: ${vm.count.value}"
      )
      Text(modifier = Modifier.padding(top = 10.dp), text = vm.event.title)
      Text(text = vm.event.text)
   }

}

data class Event(
   val title: String,
   val text: String
)