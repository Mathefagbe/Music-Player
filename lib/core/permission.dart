import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Permission {
  Permission._();

  //single tone class
  static final Permission on = Permission._();

  final OnAudioQuery _audioQuery = OnAudioQuery();

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
  }
}
