// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListItem _$ListItemFromJson(Map<String, dynamic> json) {
  return ListItem()
    ..taskId = json['taskId'] as int
    ..passId = json['passId'] as int
    ..tTitle = json['tTitle'] as String
    ..tDesc = json['tDesc'] as String
    ..tImage = json['tImage'] as String
    ..tUrl = json['tUrl'] as String
    ..weight = json['weight'] as int
    ..urlType = json['urlType'] as int
    ..totalClickCount = json['totalClickCount'] as int
    ..currentClickCount = json['currentClickCount'] as int
    ..clickPoints = json['clickPoints'] as int
    ..maxPoints = json['maxPoints'] as int
    ..tType = json['tType'] as String
    ..status = json['status'] as int
    ..ctime = json['ctime'] as int
    ..memo = json['memo'] as String
    ..tCate = json['tCate'] as int
    ..tKey = json['tKey'] as String
    ..tReadCount = json['tReadCount'] as int
    ..tReadLimit = json['tReadLimit'] as int
    ..tTime = json['tTime'] as int
    ..pageUrl = json['pageUrl'] as String
    ..tAuthImg = json['tAuthImg'] as String
    ..tAuthName = json['tAuthName'] as String
    ..targetType = json['targetType'] as int
    ..articleType = json['articleType'] as int
    ..lastModifyTime = json['lastModifyTime'] as int
    ..isHot = json['isHot'] as int
    ..isRalation = json['isRalation'] as int
    ..hotSort = json['hotSort'] as int
    ..cateSort = json['cateSort'] as int
    ..forApp = json['forApp'] as int
    ..isAd = json['isAd'] as int
    ..isTecentStyle = json['isTecentStyle'] as int
    ..customerAdvertId = json['customerAdvertId'] as int
    ..showTime = json['showTime'] as int
    ..videoUrl = json['videoUrl'] as String
    ..videoSecond = json['videoSecond'] as int
    ..videoSize = json['videoSize'] as int
    ..isConn = json['isConn'] as int
    ..commentCount = json['commentCount'] as int
    ..favoriteCount = json['favoriteCount'] as int
    ..shareCount = json['shareCount'] as int
    ..tuId = json['tuId'] as int
    ..type = json['type'] as String
    ..tuName = json['tuName'] as String
    ..taskUrl = json['taskUrl'] as String
    ..stickId = json['stickId'] as int
    ..stickLabelStatus = json['stickLabelStatus'] as int
    ..stickLabel = json['stickLabel']
    ..stickLabelJson = json['stickLabelJson']
    ..isMoney = json['isMoney'] as int
    ..isOpenFull = json['isOpenFull'] as int
    ..isCollect = json['isCollect'] as int
    ..isForward = json['isForward'] as int
    ..isReading = json['isReading'] as int
    ..isComment = json['isComment'] as int
    ..isCommentCount = json['isCommentCount'] as int
    ..isSource = json['isSource'] as int
    ..isReadCount = json['isReadCount'] as int
    ..isShield = json['isShield'] as int
    ..sort = json['sort'] as int
    ..taskContent = json['taskContent']
    ..advert = json['advert']
    ..strStatus = json['strStatus'] as String
    ..strShortCtime = json['strShortCtime'] as String
    ..strImages = json['strImages'] as List
    ..strCtime = json['strCtime'] as String
    ..shortTitle = json['shortTitle'] as String
    ..smallImage = json['smallImage'] as String
    ..strArticleTime = json['strArticleTime'] as String
    ..strTReadCount = json['strTReadCount'] as String
    ..clickMoney = json['clickMoney'] as String
    ..surplusMoney = (json['surplusMoney'] as num)?.toDouble()
    ..strHotSort = json['strHotSort'] as String
    ..isHightPrice = json['isHightPrice'] as int;
}

Map<String, dynamic> _$ListItemToJson(ListItem instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'passId': instance.passId,
      'tTitle': instance.tTitle,
      'tDesc': instance.tDesc,
      'tImage': instance.tImage,
      'tUrl': instance.tUrl,
      'weight': instance.weight,
      'urlType': instance.urlType,
      'totalClickCount': instance.totalClickCount,
      'currentClickCount': instance.currentClickCount,
      'clickPoints': instance.clickPoints,
      'maxPoints': instance.maxPoints,
      'tType': instance.tType,
      'status': instance.status,
      'ctime': instance.ctime,
      'memo': instance.memo,
      'tCate': instance.tCate,
      'tKey': instance.tKey,
      'tReadCount': instance.tReadCount,
      'tReadLimit': instance.tReadLimit,
      'tTime': instance.tTime,
      'pageUrl': instance.pageUrl,
      'tAuthImg': instance.tAuthImg,
      'tAuthName': instance.tAuthName,
      'targetType': instance.targetType,
      'articleType': instance.articleType,
      'lastModifyTime': instance.lastModifyTime,
      'isHot': instance.isHot,
      'isRalation': instance.isRalation,
      'hotSort': instance.hotSort,
      'cateSort': instance.cateSort,
      'forApp': instance.forApp,
      'isAd': instance.isAd,
      'isTecentStyle': instance.isTecentStyle,
      'customerAdvertId': instance.customerAdvertId,
      'showTime': instance.showTime,
      'videoUrl': instance.videoUrl,
      'videoSecond': instance.videoSecond,
      'videoSize': instance.videoSize,
      'isConn': instance.isConn,
      'commentCount': instance.commentCount,
      'favoriteCount': instance.favoriteCount,
      'shareCount': instance.shareCount,
      'tuId': instance.tuId,
      'type': instance.type,
      'tuName': instance.tuName,
      'taskUrl': instance.taskUrl,
      'stickId': instance.stickId,
      'stickLabelStatus': instance.stickLabelStatus,
      'stickLabel': instance.stickLabel,
      'stickLabelJson': instance.stickLabelJson,
      'isMoney': instance.isMoney,
      'isOpenFull': instance.isOpenFull,
      'isCollect': instance.isCollect,
      'isForward': instance.isForward,
      'isReading': instance.isReading,
      'isComment': instance.isComment,
      'isCommentCount': instance.isCommentCount,
      'isSource': instance.isSource,
      'isReadCount': instance.isReadCount,
      'isShield': instance.isShield,
      'sort': instance.sort,
      'taskContent': instance.taskContent,
      'advert': instance.advert,
      'strStatus': instance.strStatus,
      'strShortCtime': instance.strShortCtime,
      'strImages': instance.strImages,
      'strCtime': instance.strCtime,
      'shortTitle': instance.shortTitle,
      'smallImage': instance.smallImage,
      'strArticleTime': instance.strArticleTime,
      'strTReadCount': instance.strTReadCount,
      'clickMoney': instance.clickMoney,
      'surplusMoney': instance.surplusMoney,
      'strHotSort': instance.strHotSort,
      'isHightPrice': instance.isHightPrice,
    };
