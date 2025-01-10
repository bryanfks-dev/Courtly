import 'package:courtly/data/repository/local/introduction_repository.dart';

/// [IntroductionProvider] is a provider class that contains the introduction
/// data for the app.
/// It is used to manage the introduction data of the app.
class IntroductionProvider {
  /// [introductionRepository] is the repository for introduction related
  /// operations.
  final IntroductionRepository introductionRepository;

  IntroductionProvider({required this.introductionRepository});

  /// [setIntroductionDone] is a method that sets the introduction status.
  ///
  /// Returns [void]
  void setIntroductionDone() async {
    await introductionRepository.setIntroductionStatus(true);
  }

  /// [getIntroductionStatus] is a method that returns the introduction status.
  ///
  /// Returns [Future] of [bool]
  Future<bool> getIntroductionStatus() async {
    return await introductionRepository.getIntroductionStatus() ?? false;
  }
}
