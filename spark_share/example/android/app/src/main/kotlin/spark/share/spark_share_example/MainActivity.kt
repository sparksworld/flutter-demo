package spark.share.spark_share_example

import android.os.Bundle
import android.os.PersistableBundle
import com.spark.usth_spark.ShareWeChatUtils
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        ShareWeChatUtils.initShare("[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1},{\"appName\":\"qktx\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.yanhui.qktx\",\"appId\":\"wx1d2c2878b180942c\",\"type\":1}]");
        ShareWeChatUtils.sendText(this, 0, "11223333333");
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ShareWeChatUtils.initShare("[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1},{\"appName\":\"qktx\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.yanhui.qktx\",\"appId\":\"wx1d2c2878b180942c\",\"type\":1}]");
        ShareWeChatUtils.sendText(this, 0, "11223333333");
    }
}