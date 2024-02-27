import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    }

    if (Platform.isAndroid) {
      return 'ca-app-pub-7533750599105635/4463229234';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7533750599105635/5700768214';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}