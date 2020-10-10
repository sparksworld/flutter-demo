package usth.spark.share.usth_spark_share;

import android.app.Activity;
import android.content.Context;
import android.widget.Toast;

import com.lpp.share.presenter.ShareFragmentPresenter;

/**
 * 分享工具类
 */
public class ShareUtils {
    private static String json = "{\"shareApplist\":[\n" +
            "            {\"shareAppKey\":\"wxf0a80d0ac2e82aa7\",\n" +
            "          \"shareAppPackAge\":\"com.tencent.mobileqq\",\n" +
            "            \"downLoadUrl\":\"\",\n" +
            "            \"isDefault\":0\n" +
            "            }\n" +
            "          ]}";

    public static boolean usthWxFriendShare(Activity activity, String title, String subTitle, String image, String url) {
        Toast.makeText(activity, "分享微信好友", Toast.LENGTH_SHORT).show();
        ShareFragmentPresenter shareFragmentPresenter = new ShareFragmentPresenter();
        shareFragmentPresenter.throughSdkShareWXFriends(activity, title, subTitle, image, url, 0, json);
        return  true;
    }


    public static boolean usthWxCircleOfFriendsShare(Activity activity, String title, String subTitle, String image, String url) {
        Toast.makeText(activity, "分享朋友圈", Toast.LENGTH_SHORT).show();
        ShareFragmentPresenter shareFragmentPresenter = new ShareFragmentPresenter();
        shareFragmentPresenter.throughSdkShareWXFriends(activity, title, subTitle, image, url, 1, json);
        return  true;
    }
}
