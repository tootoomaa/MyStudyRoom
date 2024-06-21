package com.example.myrecipeapp

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET


private val retrofit = Retrofit.Builder().baseUrl("https://www.themealdb.com/api/json/v1/1/")    // 기본 URL을 정의
    .addConverterFactory(GsonConverterFactory.create())
    .build()

val recipeService = retrofit.create(ApiService::class.java)

interface ApiService {

    @GET("categories.php")
    suspend fun getCategories(): CategoriesResponse

}