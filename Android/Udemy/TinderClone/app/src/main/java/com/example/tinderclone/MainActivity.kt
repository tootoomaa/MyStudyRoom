package com.example.tinderclone

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.tinderclone.swipeableCard.SwipeCards
import com.example.tinderclone.ui.theme.TinderCloneTheme

sealed class DestinationScreen(val route: String) {
    object Singup: DestinationScreen(route = "signup")
    object Login: DestinationScreen(route = "login")
    object Profile: DestinationScreen(route = "profile")
    object Swipe: DestinationScreen(route = "Swipe")
    object ChatList: DestinationScreen(route = "ChatList")
    object SingleChat: DestinationScreen(route = "SingleChat")

    fun createRoute(id: String) = "singleChat/$id"
}


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TinderCloneTheme {
                Scaffold(
                    modifier = Modifier.fillMaxSize(),
//                    color = MaterialTheme.colorScheme.background
                ) {
                    SwipeAppNavigation()
                }
            }
        }
    }
}


@Composable
fun SwipeAppNavigation() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = DestinationScreen.Swipe.route
    ) {
        composable(DestinationScreen.Singup.route) {
            SignupScreen()
        }

        composable(DestinationScreen.Login.route) {
            LoginScreen()
        }

        composable(DestinationScreen.Swipe.route) {
            SwipeCards()
        }

        composable(DestinationScreen.Profile.route) {
            ProfileScreen()
        }

        composable(DestinationScreen.ChatList.route) {
            ChatListScreen()
        }

        composable(DestinationScreen.SingleChat.route) {
            SingleChatScreen()
        }
    }
}