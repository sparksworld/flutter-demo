package usth.spark.share.usth_spark_share.utils

import android.util.Log
import io.flutter.BuildConfig


object LogUtils {
    private const val LOG_TAG = "USTH_SPARK"
    fun logE(msg: String) {
        if (BuildConfig.DEBUG) {
            Log.e(LOG_TAG, msg)
        }
    }
}