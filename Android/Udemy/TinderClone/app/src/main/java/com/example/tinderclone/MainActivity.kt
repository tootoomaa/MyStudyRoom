package com.example.tinderclone

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.tinderclone.swipeableCard.SwipeCards
import com.example.tinderclone.ui.theme.TinderCloneTheme
import com.example.tinderclone.view.ChatListScreen
import com.example.tinderclone.view.LoginScreen
import com.example.tinderclone.view.ProfileScreen
import com.example.tinderclone.view.SignupScreen
import com.example.tinderclone.view.SingleChatScreen
import dagger.hilt.android.AndroidEntryPoint

sealed class DestinationScreen(val route: String) {
    object Singup: DestinationScreen(route = "signup")
    object Login: DestinationScreen(route = "login")
    object Profile: DestinationScreen(route = "profile")
    object Swipe: DestinationScreen(route = "Swipe")
    object ChatList: DestinationScreen(route = "ChatList")
    object SingleChat: DestinationScreen(route = "SingleChat")

    fun createRoute(id: String) = "singleChat/$id"
}


@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @SuppressLint("UnusedMaterial3ScaffoldPaddingParameter")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TinderCloneTheme {
                SwipeAppNavigation()
            }
        }
    }
}


@Composable
fun SwipeAppNavigation(modifier: Modifier = Modifier) {
    val navController = rememberNavController()
    val vm = hiltViewModel<TCViewModel>()

    NavHost(
        navController = navController,
        startDestination = DestinationScreen.Singup.route,
        modifier = modifier
    ) {
        composable(DestinationScreen.Singup.route) {
            SignupScreen(navController, vm)
        }

        composable(DestinationScreen.Login.route) {
            LoginScreen()
        }

        composable(DestinationScreen.Swipe.route) {
            SwipeCards(navController)
        }

        composable(DestinationScreen.Profile.route) {
            ProfileScreen(navController)
        }

        composable(DestinationScreen.ChatList.route) {
            ChatListScreen(navController)
        }

        composable(DestinationScreen.SingleChat.route) {
            SingleChatScreen()
        }
    }
}