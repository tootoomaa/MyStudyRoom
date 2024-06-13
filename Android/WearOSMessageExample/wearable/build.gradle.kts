import org.jetbrains.kotlin.gradle.targets.js.nodejs.NodeJsRootPlugin.Companion.kotlinNpmResolutionManager

plugins {
   alias(libs.plugins.android.application)
   alias(libs.plugins.jetbrains.kotlin.android)
}

android {
   namespace = "com.example.wearable.sat014_aos"
   compileSdk = 34

   defaultConfig {
      applicationId = "com.example.wearable.sat014_aos"
      minSdk = 30
      targetSdk = 34
      versionCode = 1
      versionName = "1.0"
      vectorDrawables {
         useSupportLibrary = true
      }

   }

   buildTypes {
      release {
         isMinifyEnabled = false
         proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
         )
      }
   }
   compileOptions {
      sourceCompatibility = JavaVersion.VERSION_1_8
      targetCompatibility = JavaVersion.VERSION_1_8
   }
   kotlinOptions {
      jvmTarget = "1.8"
   }
   buildFeatures {
      compose = true
   }
   composeOptions {
      kotlinCompilerExtensionVersion = "1.5.1"
   }
   packaging {
      resources {
         excludes += "/META-INF/{AL2.0,LGPL2.1}"
      }
   }
}

dependencies {

   implementation(libs.play.services.wearable)
   implementation(platform(libs.androidx.compose.bom))
   implementation(libs.androidx.ui)
   implementation(libs.androidx.ui.tooling.preview)
   implementation(libs.androidx.compose.material)
   implementation(libs.androidx.compose.foundation)
   implementation(libs.androidx.activity.compose)
   implementation(libs.androidx.core.splashscreen)
   androidTestImplementation(platform(libs.androidx.compose.bom))
   androidTestImplementation(libs.androidx.ui.test.junit4)
   debugImplementation(libs.androidx.ui.tooling)
   debugImplementation(libs.androidx.ui.test.manifest)
   implementation("androidx.lifecycle:lifecycle-runtime-ktx")
   implementation("androidx.lifecycle:lifecycle-viewmodel-ktx")

   implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.21")
   implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.0-RC")
   implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.8.0-RC")

   implementation("org.jetbrains.kotlinx:kotlinx-coroutines-play-services:1.6.4")
   implementation("com.google.android.gms:play-services-wearable:18.0.0")
   implementation("com.google.android.gms:play-services-tasks:18.0.2")

}