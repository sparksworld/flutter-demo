package com.spark.spark_share.bean


class AppInfoBean {

    var appName: String = ""
    var downloadUrl: String = ""
    var optional = 0
    var packageName: String = ""
    var appId: String = ""
    var type = 0

     override fun toString(): String {
         return "AppInfoBean(appName='$appName',downloadUrl='$downloadUrl',optional=$optional,packageName='$packageName',appId='$appId',type=$type)"
     }

}