import 'package:json_annotation/json_annotation.dart';


part 'list_item.g.dart';

@JsonSerializable()
class ListItem {
      ListItem();

  int taskId;
  int passId;
  String tTitle;
  String tDesc;
  String tImage;
  String tUrl;
  int weight;
  int urlType;
  int totalClickCount;
  int currentClickCount;
  int clickPoints;
  int maxPoints;
  String tType;
  int status;
  int ctime;
  String memo;
  int tCate;
  String tKey;
  int tReadCount;
  int tReadLimit;
  int tTime;
  String pageUrl;
  String tAuthImg;
  String tAuthName;
  int targetType;
  int articleType;
  int lastModifyTime;
  int isHot;
  int isRalation;
  int hotSort;
  int cateSort;
  int forApp;
  int isAd;
  int isTecentStyle;
  int customerAdvertId;
  int showTime;
  String videoUrl;
  int videoSecond;
  int videoSize;
  int isConn;
  int commentCount;
  int favoriteCount;
  int shareCount;
  int tuId;
  String type;
  String tuName;
  String taskUrl;
  int stickId;
  int stickLabelStatus;
  dynamic stickLabel;
  dynamic stickLabelJson;
  int isMoney;
  int isOpenFull;
  int isCollect;
  int isForward;
  int isReading;
  int isComment;
  int isCommentCount;
  int isSource;
  int isReadCount;
  int isShield;
  int sort;
  dynamic taskContent;
  dynamic advert;
  String strStatus;
  String strShortCtime;
  List<dynamic> strImages;
  String strCtime;
  String shortTitle;
  String smallImage;
  String strArticleTime;
  String strTReadCount;
  String clickMoney;
  double surplusMoney;
  String strHotSort;
  int isHightPrice;

  factory ListItem.fromJson(Map<String,dynamic> json) => _$ListItemFromJson(json);
  Map<String, dynamic> toJson() => _$ListItemToJson(this);
}
