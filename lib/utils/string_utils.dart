import 'dart:io';

import 'package:timeago/timeago.dart' as timeago;

class StringUtils {
  static String getTimeAgo(DateTime date) {
    try {
      final now = DateTime.now();
      return timeago.format(
        DateTime.now().subtract(
          Duration(
            milliseconds: now.difference(date).inMilliseconds,
          ),
        ),
      );
    } catch (e) {
      return '';
    }
  }

  static String getExtension(dynamic image) {
    try {
      if (image is File) {
        return image.path.split(Platform.pathSeparator).last.split('.').last;
      }
      return image.split(Platform.pathSeparator).last.split('.').last;
    } catch (e) {
      return "";
    }
  }
}
