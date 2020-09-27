package com.spark.spark_share.utils

import android.util.Log
import io.flutter.BuildConfig


object LogUtils {
    private const val LOG_TAG = "HLQ_Struggle"
    fun logE(msg: String) {
        if (BuildConfig.DEBUG) {
            Log.e(LOG_TAG, msg)
        }
    }
}