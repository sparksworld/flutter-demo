package usth.spark.share.usth_spark_share

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import usth.spark.share.usth_spark_share.utils.LogUtils
import usth.spark.share.usth_spark_share.utils.ShareWeChatUtils.Companion.initShare
import usth.spark.share.usth_spark_share.utils.ShareWeChatUtils.Companion.checkAppInstalled
import usth.spark.share.usth_spark_share.utils.ShareWeChatUtils.Companion.shareWeChat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** UsthSparkSharePlugin */
public class UsthSparkSharePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "usth_spark_share")
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.applicationContext
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "usth_spark_share")
            channel.setMethodCallHandler(UsthSparkSharePlugin())
        }
    }
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> { // 获取命中 App 数量
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "initShare" -> { // 获取命中 App 数量
                result?.success(initShare((call.arguments<String>())!!))
            }
            "checkAppInstalled" -> {
                result?.success(checkAppInstalled(activity))
            }
            "usthWxFriendShare" -> {  // 分享微信
                result?.success(shareWeChat(
                        context, 0,
                        call.argument<String>("shareUrl")!!,
                        call.argument<String>("shareTitle")!!,
                        call.argument<String>("shareDesc")!!,
                        call.argument<String>("shareThumbnail")!!, ""))
            }
            "usthWxCircleOfFriendsShare" -> {
                result?.success(shareWeChat(
                        context, 1,
                        call.argument<String>("shareUrl")!!,
                        call.argument<String>("shareTitle")!!,
                        call.argument<String>("shareDesc")!!,
                        call.argument<String>("shareThumbnail")!!, ""))
            }
            else -> {
                result?.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
