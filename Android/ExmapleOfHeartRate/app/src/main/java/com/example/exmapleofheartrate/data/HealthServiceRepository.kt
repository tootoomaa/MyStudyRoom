package com.example.exmapleofheartrate.data

import android.content.Context
import android.util.Log
import androidx.concurrent.futures.await
import androidx.health.services.client.HealthServices
import androidx.health.services.client.HealthServicesClient
import androidx.health.services.client.MeasureCallback
import androidx.health.services.client.MeasureClient
import androidx.health.services.client.data.Availability
import androidx.health.services.client.data.DataPointContainer
import androidx.health.services.client.data.DataType
import androidx.health.services.client.data.DataTypeAvailability
import androidx.health.services.client.data.DeltaDataType
import androidx.health.services.client.data.SampleDataPoint
import com.example.exmapleofheartrate.MainApplication
import com.google.assistant.appactions.testing.aatl.parser.values.Capability
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.runBlocking
import com.example.exmapleofheartrate.TAG

class HealthServiceRepository(context: Context) {

   private val healthServiceClient = HealthServices.getClient(context)
   private val measureClient = healthServiceClient.measureClient


   suspend fun hasHeartRateCapability(): Boolean {
      val capabilities = measureClient.getCapabilitiesAsync().await()
      return (DataType.HEART_RATE_BPM in capabilities.supportedDataTypesMeasure)
   }

   fun heartRateMeasureFlow() = callbackFlow {
      val callback = object : MeasureCallback {
         override fun onAvailabilityChanged(
            dataType: DeltaDataType<*, *>,
            availability: Availability
         ) {
            // Only send back DataTypeAvailability (not LocationAvailability)
            if (availability is DataTypeAvailability) {
               trySendBlocking(MeasureMessage.MeasureAvailability(availability))
            }
         }

         override fun onDataReceived(data: DataPointContainer) {
            val heartRateBpm = data.getData(DataType.HEART_RATE_BPM)
            trySendBlocking(MeasureMessage.MeasureData(heartRateBpm))
         }
      }

      Log.d(TAG, "Registering for data")
      measureClient.registerMeasureCallback(DataType.HEART_RATE_BPM, callback)

      awaitClose {
         Log.d(TAG, "Unregistering for data")
         runBlocking {
            measureClient.unregisterMeasureCallbackAsync(DataType.HEART_RATE_BPM, callback)
               .await()
         }
      }
   }
}

sealed class MeasureMessage {
   class MeasureAvailability(val availability: DataTypeAvailability) : MeasureMessage()
   class MeasureData(val data: List<SampleDataPoint<Double>>) : MeasureMessage()
}
