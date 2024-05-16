package com.example.plusminuscount.mainview

import android.util.Log
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider


class MainViewModel: ViewModel() {

    private val _counter = mutableStateOf(0)
    val counter: State<Int> = _counter

    init {
        Log.d("테스트", "MainView Model inir")
    }

    fun increase() {
        Log.d("테스트", "Tap Increase Button")
        _counter.value += 1
    }

    fun decrease() {
        Log.d("테스트", "Tap Decrease Button")
        _counter.value -= 1
    }
}