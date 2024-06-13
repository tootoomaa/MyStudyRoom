/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter and
 * https://github.com/android/wear-os-samples/tree/main/ComposeAdvanced to find the most up to date
 * changes to the libraries and their usages.
 */

package com.example.wearable.sat014_aos

import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.StrokeCap.Companion.Butt
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.lifecycle.lifecycleScope
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.Text
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.CapabilityInfo
import com.google.android.gms.wearable.DataClient
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.Node
import com.google.android.gms.wearable.Wearable
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import java.time.Duration
import kotlin.coroutines.cancellation.CancellationException
class MainActivity : ComponentActivity(), CapabilityClient.OnCapabilityChangedListener {

   private lateinit var dataClient: DataClient
   private val messageClient by lazy { Wearable.getMessageClient(this) }
   private val capabilityClient by lazy { Wearable.getCapabilityClient(this) }
   private val event = MutableStateFlow(Event("Capability Ready...", "Ready..."))
   private var node: Node? = null

   //   private val clientDataViewModel by viewModel<DataLayerListenerService>()
   override fun onCreate(savedInstanceState: Bundle?) {
      installSplashScreen()

      super.onCreate(savedInstanceState)
      setTheme(android.R.style.Theme_DeviceDefault)

      setContent {
         DisplayCountFromApp(count = 0, onPlusClick = {
            Log.d(TAG, "Plus BT TAP")
            sendMessage("plus")
         }, onMinusClick = {
            Log.d(TAG, "Minus BT TAP")
            sendMessage("minus")
         }, onCheckClick = {
            Log.d(TAG, "Check BT TAP")
            checkNodes()
         }, event = event.value
         )
      }
   }

   private fun checkNodes() {
      Log.d(TAG, "Start Check Nodes")

      lifecycleScope.launch {
         try {
            val nodes =
               capabilityClient.getCapability("wear_capabilities", CapabilityClient.FILTER_REACHABLE)
                  .await()
                  .nodes

            Log.d(TAG, "Find Nodes Compelete")

            node = nodes.firstOrNull { it.isNearby }

            if (node != null) {
               Log.d(TAG, "Selected Node : ${node?.id}, ${node?.displayName}, ${node?.isNearby}")
            }

            Toast.makeText(this@MainActivity, "Nodes: ${nodes.count()}", Toast.LENGTH_SHORT).show()

         } catch (cancellationException: CancellationException) {
            throw cancellationException
         } catch (exception: Exception) {
            Log.d(TAG, "Starting activity failed: $exception")
         }
      }
   }

   private fun sendMessage(message: String) {

      Log.d(TAG, "TAp Send Messages")

      lifecycleScope.launch {
         try {
            val nodes =
               capabilityClient.getCapability("wear_capabilities", CapabilityClient.FILTER_REACHABLE)
                  .await().nodes

            Log.d(TAG, "Find Nodes Compelete")

            nodes.map { node ->
               async {
                  messageClient.sendMessage(node.id, START_ACTIVITY_PATH, message.toByteArray())
                     .await()
               }
//               Log.d(TAG, "Send Message to nodes")
            }.awaitAll()

            Toast.makeText(this@MainActivity, "Send Message", Toast.LENGTH_SHORT).show()

         } catch (cancellationException: CancellationException) {
            throw cancellationException
         } catch (exception: Exception) {
            Log.d(TAG, "Starting activity failed: $exception")
         }
      }
   }

   override fun onResume() {
      super.onResume()
      Log.d(TAG, "")
      capabilityClient.addListener(
         this, Uri.parse("wear://"), CapabilityClient.FILTER_REACHABLE
      )
   }

   override fun onPause() {
      super.onPause()
      capabilityClient.removeListener(this)
   }

   override fun onCapabilityChanged(capabilityInfo: CapabilityInfo) {
      event.value = Event(
         title = "Capability Changed", text = capabilityInfo.toString()
      )
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
fun DisplayCountFromApp(
   count: Int,
   onPlusClick: () -> Unit,
   onMinusClick: () -> Unit,
   onCheckClick: () -> Unit,
   event: Event
) {
   Column(
      modifier = Modifier.fillMaxSize(),
      verticalArrangement = Arrangement.Center,
      horizontalAlignment = Alignment.CenterHorizontally
   ) {
      Row(
         modifier = Modifier.fillMaxWidth(),
         horizontalArrangement = Arrangement.SpaceAround,
         verticalAlignment = Alignment.CenterVertically
      ) {
         Button(onClick = { onMinusClick.invoke() }) {
            Text(fontSize = 30.sp, text = "-")
         }

         Button(onClick = { onPlusClick.invoke() }) {
            Text(fontSize = 30.sp, text = "+")
         }
      }
      Text(modifier = Modifier.padding(top = 10.dp), text = event.title)
      Text(text = event.text)

      Button(onClick = { onCheckClick.invoke() }) {
         Text(text = "Check")
      }
   }
}

data class Event(
   val title: String, val text: String
)

@Preview(showBackground = true)
@Composable
fun DefaultPreview(messageClient: MessageClient) {
   DisplayCountFromApp(count = 0, onPlusClick = {

   }, onMinusClick = {

   }, onCheckClick = {

   }, event = Event("Test", "Test")
   )
}