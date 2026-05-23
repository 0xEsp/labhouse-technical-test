import 'package:lab_house/core/api/prompt/ranking.prompt.dart';

enum Prompts {
  rankings;

  String get instruction => switch (this) {
    Prompts.rankings => rankingInstructionPrompt,
  };
}
