import 'package:trait_lens/core/utils/app_assets.dart';

class OnBoardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnBoardingModel> getOnboarding = [
    OnBoardingModel(
      title: 'Analyze Text Snippets',
      description:
          "Discover the hidden patterns in your writing — just a few sentences can reveal deep insights about your personality, communication style, and how you express yourself to the world.",
      imagePath: AppSvg.onBoarding1,
    ),
    OnBoardingModel(
      title: 'Voice Analysis',
      description:
          "Your voice holds more than words — we analyze your tone, pitch, and speech patterns to uncover the unique personality traits reflected in the way you speak and express emotion.",
      imagePath: AppSvg.onBoarding2,
    ),
    OnBoardingModel(
      title: 'Analyze photos to uncover personality insights',
      description:
          "Your face can tell a powerful story — through advanced analysis of your facial features and expressions, we explore the subtle cues that reflect your true personality.",
      imagePath: AppSvg.onBoarding3,
    ),
  ];
}
