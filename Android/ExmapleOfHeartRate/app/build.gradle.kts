plugins {
   alias(libs.plugins.android.application)
   alias(libs.plugins.jetbrains.kotlin.android)
}

android {
   namespace = "com.example.exmapleofheartrate"
   compileSdk = 34

   defaultConfig {
      applicationId = "com.example.exmapleofheartrate"
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
   implementation(platform(libs.compose.bom))
   implementation(libs.ui)
   implementation(libs.ui.tooling.preview)
   implementation(libs.compose.material)
   implementation(libs.compose.foundation)
   implementation(libs.activity.compose)
   implementation(libs.core.splashscreen)
   implementation(libs.testing)
   androidTestImplementation(platform(libs.compose.bom))
   androidTestImplementation(libs.ui.test.junit4)
   debugImplementation(libs.ui.tooling)
   debugImplementation(libs.ui.test.manifest)

   implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.8.0")
   implementation("androidx.health:health-services-client:1.1.0-alpha03")
   implementation("androidx.concurrent:concurrent-futures-ktx:1.1.0")
   implementation("com.google.guava:guava:33.2.0-android")
   implementation("com.google.accompanist:accompanist-permissions:0.34.0")
   implementation("androidx.compose.material:material-icons-extended:1.7.0-beta01")
}