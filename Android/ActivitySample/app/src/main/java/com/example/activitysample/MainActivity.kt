package com.example.activitysample

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.activitysample.ui.theme.ActivitySampleTheme
import kotlinx.coroutines.flow.flow
import java.util.concurrent.Flow

enum class Destination {
   HOME, SUB
}

class MainActivity : ComponentActivity() {
   // Activity가 첫 생성될때 한번만 실행됨

   fun getCount() : Flow<Int> = flow {
      emit(0)
   }

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      enableEdgeToEdge()
      println("onCreate...")
      setContent {
         ActivitySampleTheme {
            Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
               MainView(Modifier.padding(innerPadding))
            }
         }
      }
   }

   @Composable
   fun MainView(modifier: Modifier) {

      val navHost = rememberNavController()

      NavHost(navController = navHost, startDestination = Destination.HOME.name) {
         composable(Destination.HOME.name) {
            Column(
               modifier = Modifier.fillMaxSize(),
               verticalArrangement = Arrangement.Center,
            ) {
               Greeting(
                  name = "Android"
               )

               Button(onClick = {
                  navHost.navigate(Destination.SUB.name)
               }) {
                  Text(text = "Go Sub")
               }
            }
         }

         composable(Destination.SUB.name) {
            Column(
               modifier = Modifier.fillMaxSize(),
               verticalArrangement = Arrangement.Center,
            ) {
               Greeting(
                  name = "Android"
               )

               Button(onClick = {
                  navHost.navigate(Destination.HOME.name)
               }) {
                  Text(text = "Go Home")
               }
            }
         }
      }

   }


   override fun onStart() {   // 사용자에게 화면이 보여질 때마다 실행됨
      super.onStart()
      println("onStart...")
   }

   override fun onPause() {   // 백그라운드로 진입 한뒤 1st step
      super.onPause()
      println("onPause...")
   }

   override fun onStop() { // 백그라운드로 진입 한뒤 2st step
      super.onStop()
      println("onStop...")
   }

   override fun onResume() {  // 사용자가 앱과 다시 인터렉션을 수행할떄
      super.onResume()
      println("onResume....")
   }

   override fun onRestart() { // 멈추었던 앱이 다시 실행될때
      super.onRestart()
      println("onRestart...")
   }

   override fun onDestroy() { // 해당 화면이 메모리에서 완전히 사라질때ㅖㅖㅖ
      super.onDestroy()
      println("onDestroy...")
   }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
   Text(
      text = "Hello $name!",
      modifier = modifier
   )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
   ActivitySampleTheme {
      Greeting("Android")
   }
}