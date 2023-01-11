import 'package:ice_live_viewer/utils/linkparser.dart';

enum LiveStatus { live, offline, replay, unknown }

enum Platform { huya, bilibili, douyu, unknown }

class RoomInfo {
  String roomId;
  String link = '';
  String title = '';
  String nick = '';
  String avatar = '';
  String cover = '';
  String platform = 'UNKNOWN';
  LiveStatus liveStatus = LiveStatus.unknown;

  String areaName = '';

  int huyaDanmakuId = 0;
  Map<String, dynamic> cdnMultiLink = {};

  RoomInfo(this.roomId);

  RoomInfo.fromJson(Map<String, dynamic> json)
      : roomId = json['roomId'] ?? '',
        title = json['title'] ?? '',
        link = json['link'] ?? '',
        nick = json['nick'] ?? '',
        avatar = json['avatar'] ?? '',
        cover = json['cover'] ?? '',
        platform = json['platform'] ?? '',
        liveStatus = LiveStatus.values[json['liveStatus']];
  Map<String, dynamic> toJson() => <String, dynamic>{
        'roomId': roomId,
        'title': title,
        'nick': nick,
        'avatar': avatar,
        'cover': cover,
        'platform': platform,
        'liveStatus': liveStatus.index
      };

  RoomInfo.fromLink(String rawLink)
      : link = rawLink,
        platform = LinkParser.checkType(rawLink),
        roomId = LinkParser.getRoomId(rawLink);

  @override
  String toString() =>
      'roomId: $roomId, link: $link, title: $title, nick: $nick, liveStatus: $liveStatus, platform: $platform,';
}
