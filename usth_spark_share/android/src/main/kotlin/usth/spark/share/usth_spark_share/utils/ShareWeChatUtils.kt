package usth.spark.share.usth_spark_share.utils

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.os.Bundle
import com.bumptech.glide.Glide
import com.bumptech.glide.annotation.GlideModule
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.module.AppGlideModule
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.target.Target
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.tencent.mm.opensdk.modelmsg.*
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage.IMediaObject
import usth.spark.share.usth_spark_share.bean.AppInfoBean
import java.io.ByteArrayOutputStream
import java.io.IOException


@GlideModule
class ShareWeChatUtils : AppGlideModule() {
    companion object {
        var appInfoJson: ArrayList<AppInfoBean> = ArrayList()


        fun initShare(appInfoJson: String?): String {
            this.appInfoJson = Gson().fromJson(
                    appInfoJson,
                    object : TypeToken<ArrayList<AppInfoBean?>>() {}.type
            )
            return this.appInfoJson.toString()
        }

        private fun getLocalAppCache(): ArrayList<AppInfoBean> {
            return this.appInfoJson
        }

        /**
         * 检测用户设备安装 App 信息
         */
        fun checkAppInstalled(context: Context): Int {
            var tempCount = 0
            // 获取本地宿主 App 信息
            val appInfoList = getLocalAppCache()
            // 获取用户设备已安装 App 信息
            val packageManager = context.packageManager
            val installPackageList = packageManager.getInstalledPackages(0)
            if (installPackageList.isEmpty()) {
                return 0
            }
            for (packageInfo in installPackageList) {
                for (appInfo in appInfoList) {
                    if (packageInfo.packageName == appInfo.packageName) {
                        tempCount++
                    }
                }
            }
            return tempCount
        }

        /**
         * 命中已安装 App
         */
        private fun hitInstalledApp(context: Context): AppInfoBean? {
            // 获取本地宿主 App 信息
            val appInfoList = getLocalAppCache()
            // 获取用户设备已安装 App 信息
            val packageManager = context.packageManager
            // 能进入方法说明本地已存在命中 App，使用时还需要预防
            val installPackageList = packageManager.getInstalledPackages(0)
            for (packageInfo in installPackageList) {
                for (appInfo in appInfoList) {
                    if (packageInfo.packageName == appInfo.packageName) {
                        return appInfo
                    }
                }
            }
            return null
        }

        /**
         * 分享微信
         */
        fun shareWeChat(
                context: Context,
                shareType: Int,
                url: String,
                title: String,
                text: String,
                paramString4: String?
        ): Boolean {
            if (this.appInfoJson.size == 0) {
                this.appInfoJson = Gson().fromJson(
                        "[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1}]",
                        object : TypeToken<ArrayList<AppInfoBean?>>() {}.type
                )
            }
            Glide.with(context).asBitmap().load(paramString4)
                    .listener(object : RequestListener<Bitmap?> {
                        override fun onLoadFailed(
                                param1GlideException: GlideException?,
                                param1Object: Any,
                                param1Target: Target<Bitmap?>,
                                param1Boolean: Boolean
                        ): Boolean {
                            LogUtils.logE(" ---> Load Image Failed")
                            return false
                        }

                        override fun onResourceReady(
                                param1Bitmap: Bitmap?,
                                param1Object: Any,
                                param1Target: Target<Bitmap?>,
                                param1DataSource: DataSource,
                                param1Boolean: Boolean
                        ): Boolean {
                            LogUtils.logE(" ---> Load Image Ready")

                            if (url == "" && title == "" && text == "" && param1Bitmap != null) {
                                sendImage(
                                        context,
                                        shareType,
                                        param1Bitmap
                                )
                            } else {
                                send(
                                        context,
                                        shareType,
                                        url,
                                        title,
                                        text,
                                        param1Bitmap
                                )
                            }
//                            val stringBuilder = StringBuilder()
//                            stringBuilder.append("send index: ")
//                            stringBuilder.append(i)
//                            LogUtils.logE(" ---> Ready stringBuilder.toString() :$stringBuilder")

//                            if(shareType) {
//                                WXBitmapShare()
//                            }
                            return false
                        }
                    }).preload(200, 200);

            return false;
        }

        /**
         * 微信文字分享
         */
        fun sendText(paramContext: Context, paramInt: Int, text: String): Int {
//            if (this.appInfoJson.size == 0) {
//                this.appInfoJson = Gson().fromJson(
//                        "[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1}]",
//                        object : TypeToken<ArrayList<AppInfoBean?>>() {}.type
//                )
//            }
            //初始化一个WXImageObject对象和WXMediaMessage对象
            val textObject = WXTextObject()
            textObject.text = text
            val msg = WXMediaMessage()

            msg.mediaObject = textObject
            msg.description = text

            val req = SendMessageToWX.Req()
            req.message = msg
            req.scene = paramInt

            /**
             * paramInt
             * 0: 好友
             * 1: 朋友圈
             * 2: 收藏
             */
            val bundle = Bundle()
            req.toBundle(bundle)

            return sendToWx(
                    paramContext,
                    "weixin://sendreq?appid=wxd930ea5d5a258f4f",
                    bundle
            )
        }


        /**
         * 微信分享图片
         */

        private fun sendImage(paramContext: Context, paramInt: Int, bitmap: Bitmap): Int {
            //初始化一个WXImageObject对象和WXMediaMessage对象
            val imgObj = WXImageObject(bitmap)
            val msg = WXMediaMessage()
            msg.mediaObject = imgObj

            //设置缩略图
            val thumbBmp = Bitmap.createScaledBitmap(bitmap, 100, 100, true)
//            bitmap.recycle()
            //        msg.thumbData = ConvertUtil.ConvertBitmapToBytes(thumbBmp,true);
            msg.thumbData = bmpToByteArray(paramContext, thumbBmp, true);
            //构造一个Req
            val req = SendMessageToWX.Req()
            req.transaction = buildTransaction("img") //transaction字段用于唯一标识一个请求
            req.message = msg
            req.scene = paramInt
            //分享到朋友圈：req.scene = SendMessageToWX.Req.WXSceneTimeline;
            //分享到好友会话：req.scene = SendMessageToWX.Req.WXSceneSession;
            //添加到微信收藏：req.scene = SendMessageToWX.Req.WXSceneFavorite;
            val bundle = Bundle()
            req.toBundle(bundle)
            return sendToWx(
                    paramContext,
                    "weixin://sendreq?appid=wxd930ea5d5a258f4f",
                    bundle
            )
        }

        /**
         * 微信webPage分享
         */
        private fun send(
                paramContext: Context,
                paramInt: Int,
                paramString1: String,
                paramString2: String,
                paramString3: String,
                paramBitmap: Bitmap?
        ): Int {
            val stringBuilder = StringBuilder()
            stringBuilder.append("share url: ")
            stringBuilder.append(paramString1)
            LogUtils.logE(" ---> send :$stringBuilder")
            val wXWebpageObject = WXWebpageObject()
            wXWebpageObject.webpageUrl = paramString1
            val wXMediaMessage = WXMediaMessage(wXWebpageObject as IMediaObject)
            wXMediaMessage.title = paramString2
            wXMediaMessage.description = paramString3
            wXMediaMessage.thumbData =
                    bmpToByteArray(
                            paramContext,
                            Bitmap.createScaledBitmap(paramBitmap!!, 150, 150, true),
                            true
                    )
//            paramBitmap.recycle()
            val req = SendMessageToWX.Req()
            req.transaction =
                    buildTransaction(
                            "webpage"
                    )
            req.message = wXMediaMessage
            req.scene = paramInt
            val bundle = Bundle()
            req.toBundle(bundle)
            return sendToWx(
                    paramContext,
                    "weixin://sendreq?appid=wxd930ea5d5a258f4f",
                    bundle
            )
        }

        private fun buildTransaction(paramString: String): String {
            var paramString: String? = paramString
            paramString = if (paramString == null) {
                System.currentTimeMillis().toString()
            } else {
                val stringBuilder = StringBuilder()
                stringBuilder.append(paramString)
                stringBuilder.append(System.currentTimeMillis())
                stringBuilder.toString()
            }
            return paramString
        }

        private fun bmpToByteArray(
                paramContext: Context?,
                paramBitmap: Bitmap,
                paramBoolean: Boolean
        ): ByteArray? {
            val byteArrayOutputStream =
                    ByteArrayOutputStream()
            try {
                paramBitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
                if (paramBoolean) paramBitmap.recycle()
                val arrayOfByte = byteArrayOutputStream.toByteArray()
                byteArrayOutputStream.close()
                return arrayOfByte
            } catch (iOException: IOException) {
                iOException.printStackTrace()
            }
            return null
        }

        private fun sendToWx(
                paramContext: Context?,
                paramString: String?,
                paramBundle: Bundle?
        ): Int {
            return send(
                    paramContext,
                    "com.tencent.mm",
                    "com.tencent.mm.plugin.base.stub.WXEntryActivity",
                    paramString,
                    paramBundle
            )
        }

        @SuppressLint("WrongConstant")
        private fun send(
                paramContext: Context?,
                packageName: String?,
                className: String?,
                paramString3: String?,
                paramBundle: Bundle?
        ): Int {
            if (paramContext == null || packageName == null || packageName.isEmpty() || className == null || className.isEmpty()) {
                LogUtils.logE(" ---> send fail, invalid arguments")
                return -1
            }
            val appInfoBean = hitInstalledApp(paramContext)
            val intent = Intent()
            intent.setClassName(packageName, className)
            if (paramBundle != null) intent.putExtras(paramBundle)
            intent.putExtra("_mmessage_sdkVersion", 603979778)
            intent.putExtra("_mmessage_appPackage", appInfoBean?.packageName)
            val stringBuilder = StringBuilder()
            stringBuilder.append("weixin://sendreq?appid=")
            stringBuilder.append(appInfoBean?.appId)
            intent.putExtra("_mmessage_content", stringBuilder.toString())
            intent.putExtra(
                    "_mmessage_checksum",
                    MMessageUtils.signatures(paramString3, paramContext.packageName)
            )
            intent.addFlags(268435456).addFlags(134217728)
            return try {
                paramContext.startActivity(intent)
                val sb = StringBuilder()
                sb.append("send mm message, intent=")
                sb.append(intent)
                LogUtils.logE(" ---> sb :$sb")
                0
            } catch (exception: Exception) {
                exception.printStackTrace()
                LogUtils.logE(" --->  send fail, target ActivityNotFound")
                -1
            }
        }
    }
}