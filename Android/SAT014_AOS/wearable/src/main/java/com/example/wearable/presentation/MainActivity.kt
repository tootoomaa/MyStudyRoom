/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter and
 * https://github.com/android/wear-os-samples/tree/main/ComposeAdvanced to find the most up to date
 * changes to the libraries and their usages.
 */

package com.example.wearable.presentation

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.google.android.gms.wearable.DataClient
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.Wearable

class MainActivity : ComponentActivity(),  DataClient.OnDataChangedListener {

   private lateinit var dataClient: DataClient
   private val messageClient by lazy { Wearable.getMessageClient(this) }
   private val capabilityClient by lazy { Wearable.getCapabilityClient(this) }


   override fun onCreate(savedInstanceState: Bundle?) {
      installSplashScreen()

      super.onCreate(savedInstanceState)

      dataClient = Wearable.getDataClient(this)
      dataClient.addListener(this)

      setTheme(android.R.style.Theme_DeviceDefault)

      setContent {
         DisplayCountFromApp(0, onQueryOtherDevicesClicked = {})
      }
   }


   override fun onDataChanged(dataEvents: DataEventBuffer) {
      for (event in dataEvents) {
         if (event.type == DataEvent.TYPE_CHANGED) {
            val dataItem = event.dataItem
            if (dataItem.uri.path == "/example_path") {
               val dataMap = DataMapItem.fromDataItem(dataItem).dataMap
               val message = dataMap.getString("message")
               Log.d("WearActivity", "Message received: $message")
            }
         }
      }
   }
}
