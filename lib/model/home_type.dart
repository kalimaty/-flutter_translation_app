import 'package:ai_assistant/screen/feature/translation_frist_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/feature/translator_feature.dart';

enum HomeType { translatorApp, aiTranslator }

extension MyHomeType on HomeType {
  //title      HomeType get title =>    HomeType.translatorApp;
  String get title => switch (this) {
        HomeType.translatorApp => 'Frist AI Translator',
        HomeType.aiTranslator => 'Second AI Translator',
      };

  //lottie
  String get lottie => switch (this) {
        HomeType.translatorApp => 'ai_play.json',
        HomeType.aiTranslator => 'ai_ask_me.json',
      };

  //for alignment
  bool get leftAlign => switch (this) {
        HomeType.translatorApp => false,
        HomeType.aiTranslator => true,
      };

  //for padding
  EdgeInsets get padding => switch (this) {
        // HomeType.aiChatBot => EdgeInsets.zero,
        HomeType.translatorApp => const EdgeInsets.all(20),
        HomeType.aiTranslator => EdgeInsets.zero,
      };

  //for navigation
  VoidCallback get onTap => switch (this) {
        HomeType.translatorApp => () =>
            Get.to(() => const TranslatorAppFrist()),
        HomeType.aiTranslator => () => Get.to(() => const TranslatorFeature()),
      };
}
