package com.example.web_app

import android.app.Dialog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){

    private val CHANNEL = "DIALOG"

    override  fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        val messanger = flutterEngine.dartExecutor.binaryMessenger
        MethodChannel(messanger, CHANNEL).setMethodCallHandler { call, result ->

            if(call.method == "showDialog"){
                val arguments = call.arguments
                val dialog = Dialog(activity)
                dialog.setTitle(arguments.toString())
                dialog.show()
            }
        }


        }
    }
