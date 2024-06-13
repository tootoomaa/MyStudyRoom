package com.example.wearable.sat014_aos

import android.util.Log
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.CapabilityInfo
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.MessageEvent
import kotlinx.coroutines.flow.MutableStateFlow
import java.time.Duration

class ClientDataViewModel:
   ViewModel(),
   MessageClient.OnMessageReceivedListener,
   CapabilityClient.OnCapabilityChangedListener {

   private val _event = mutableStateOf<Event>(Event("Ready...", "Ready..."))
   var event: Event = _event.value

   val count = mutableIntStateOf(0)
//    var count: Int = _count

   override fun onCapabilityChanged(capabilityInfo: CapabilityInfo) {
      Log.d(TAG, "onCapabilityChanged: ${capabilityInfo.name}")
      event = Event(
         title = "Capability Changed",
         text = capabilityInfo.name
      )
   }

   override fun onMessageReceived(messageEvent: MessageEvent) {
      Log.d(TAG, "onMessageReceived: ${messageEvent.path}")
      // 메시지 수신 처리
      if (messageEvent.path == START_ACTIVITY_PATH) {
         val message = String(messageEvent.data)

         when (message) {
            "plus" -> {
               count.value = count.value.inc()
               Log.d("MainActivity", "Count Value ++ ${count.value}")
            }
            "minus" -> {
               count.value = count.value.dec()
               Log.d("MainActivity", "Count Value -- ${count.value}")
            }
         }

         Log.d("MainActivity", "Message received: $message")
      }
   }

   enum class Controller {
      PLUS, MUINUS
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

