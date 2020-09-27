package com.spark.spark_share.utils

import java.security.MessageDigest

object MMessageUtils {
    fun getMessageDigest(paramArrayOfbyte: ByteArray): String? {
        var paramArrayOfbyte = paramArrayOfbyte
        val arrayOfChar = CharArray(16)
        arrayOfChar[0] = '0'
        arrayOfChar[1] = '1'
        arrayOfChar[2] = '2'
        arrayOfChar[3] = '3'
        arrayOfChar[4] = '4'
        arrayOfChar[5] = '5'
        arrayOfChar[6] = '6'
        arrayOfChar[7] = '7'
        arrayOfChar[8] = '8'
        arrayOfChar[9] = '9'
        arrayOfChar[10] = 'a'
        arrayOfChar[11] = 'b'
        arrayOfChar[12] = 'c'
        arrayOfChar[13] = 'd'
        arrayOfChar[14] = 'e'
        arrayOfChar[15] = 'f'
        return try {
            val messageDigest: MessageDigest = MessageDigest.getInstance("MD5")
            messageDigest.update(paramArrayOfbyte)
            paramArrayOfbyte = messageDigest.digest()
            val i = paramArrayOfbyte.size
            val arrayOfChar1 = CharArray(i * 2)
            var b: Byte = 0
            var j = 0
            while (b < i) {
                val b1 = paramArrayOfbyte[b.toInt()]
                val k = j + 1
                arrayOfChar1[j] = arrayOfChar[b1 ushr 4 and 0xF]
                j = k + 1
                arrayOfChar1[k] = arrayOfChar[b1 and 0xF]
                b++
            }
            String(arrayOfChar1)
        } catch (exception: Exception) {
            null
        }
    }

    fun signatures(paramString1: String?, paramString2: String?): ByteArray {
        val stringBuffer = StringBuffer()
        if (paramString1 != null) stringBuffer.append(paramString1)
        stringBuffer.append(603979778)
        stringBuffer.append(paramString2)
        stringBuffer.append("mMcShCsTr")
        return getMessageDigest(stringBuffer.toString().substring(1, 9).getBytes()).getBytes()
    }
}