import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bucket_list/page/bucket_list.dart';
import '../calculator/page/calculator.dart';
import '../hello_flutter/page/hello_flutter.dart';
import '../instagram/page/instagram.dart';
import '../number_quiz/number_quiz.dart';
import '../onboarding/page/onboarding.dart';
import '../todo/page/todo.dart';
import 'main_common.dart';

enum BuildType {
  helloFlutter,
  instagram,
  onboarding,
  bucketList,
  numberQuiz,
  calculator,
  todo;

  const BuildType();

  Widget build(BuildContext context) {
    switch (this) {
      case BuildType.helloFlutter:
        return HelloFlutter();
      case BuildType.instagram:
        return Instagram();
      case BuildType.onboarding:
        return Onboarding();
      case BuildType.bucketList:
        return BucketList();
      case BuildType.numberQuiz:
        return NumberQuiz();
      case BuildType.calculator:
        return Calculator();
      case BuildType.todo:
        return Todo();
      default:
        return Container();
    }
  }
}

enum SupportOrientation {
  landscape,
  portrait,
  orientation,
}

// Singleton 적용
class Environment {
  final BuildType _buildType;
  BuildType get buildType => _buildType;

  static Environment? _instance;
  static Environment get instance => _instance!;

  const Environment._internal(this._buildType);
  factory Environment.newInstance(BuildType buildType) {
    // factory를 사용함으로써 생성자에서 인스턴스 생성가능
    _instance ??= Environment._internal(buildType);
    return _instance!;
  }

  Future run() => mainCommon();

  // 앱에 따라서 설정을 한다.
  static SupportOrientation supportOrientation = SupportOrientation.orientation;

  static get supportedOrientation {
    if (supportOrientation == SupportOrientation.landscape) {
      if (kIsWeb || Platform.isWindows || Platform.isIOS) {
        // 저작툴 iOS 14 대응시까지...(저작툴로 인해서 한쪽 방향만 지원)
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      } else {
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      }
    } else if (supportOrientation == SupportOrientation.portrait) {
      return [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    } else {
      return [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    }
  }
}
