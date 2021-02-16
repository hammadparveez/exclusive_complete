package com.u6amtech.sixvalley_ui_kit

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
//https://stackoverflow.com/questions/59984162/firebase-messaging-handle-background-message-in-kotlin/60634673#60634673
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}


/*
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {


}
*/
