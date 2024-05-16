package com.example.plusminuscount.mainview

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.plusminuscount.content.CounterGreeting
import com.example.plusminuscount.ui.theme.PlusMinusCountTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            PlusMinusCountTheme {
                InitialStart(modifier = Modifier.fillMaxSize())
            }
        }
    }
}

enum class ViewMove {
    HOME, COUNTER
}

@Composable
fun InitialStart(modifier: Modifier = Modifier) {

    val navHost = rememberNavController()

    NavHost(
        navController = navHost,
        startDestination = ViewMove.HOME.name
    ) {

        composable(route = ViewMove.HOME.name) {
            Column(
                modifier = modifier,
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {

                Text(text = "Initial View")

                Button(
                    modifier = Modifier
                        .widthIn(max = 200.dp)
                        .heightIn(max = 80.dp),
                    onClick = { navHost.navigate(ViewMove.COUNTER.name) }
                ) {
                    Text(text = "Go Next View")
                }
            }
        }

        composable(route = ViewMove.COUNTER.name) {
            val mainViewModel = MainViewModel()

            CounterGreeting(
                modifier = modifier,
                viewModel = mainViewModel,
                onCancel = { navHost.popBackStack() }
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    PlusMinusCountTheme {
        InitialStart(modifier = Modifier.fillMaxWidth())
    }
}