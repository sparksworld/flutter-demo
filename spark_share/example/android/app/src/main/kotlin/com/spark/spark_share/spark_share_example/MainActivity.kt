package com.spark.spark_share.spark_share_example

import android.os.Bundle
import com.spark.usth_share.ShareWeChatUtils
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ShareWeChatUtils
                .initShare("[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1},{\"appName\":\"qktx\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.yanhui.qktx\",\"appId\":\"wx1d2c2878b180942c\",\"type\":1}]");
        ShareWeChatUtils.sendText(this, 0, "11223333333");
    }
}
