package usth.spark.share.usth_spark_share_example


import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import usth.spark.share.usth_spark_share.utils.ShareWeChatUtils

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.e("FlutterActivity","onCreate");

//        ShareWeChatUtils.shareWeChat(this, 1, "", "", "", "http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png");
        ShareWeChatUtils.sendText(this, 1, "12222222222")
    }
}
