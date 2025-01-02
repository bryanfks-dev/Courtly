/// [IntroductionState] is the abstract class that will be extended by the
/// [IntroductionBloc] to define the different states of the introduction screen.
abstract class IntroductionState {}

/// [IntroductionInitialState] is the initial state of the introduction screen.
/// This state is displayed when the introduction screen is first loaded.
class IntroductionInitialState extends IntroductionState {}

/// [IntroductionUndoneState] is the undone state of the introduction screen.
/// This state is displayed when the introduction screen is not done.
class IntroductionUndoneState extends IntroductionState {}

/// [IntroductionDoneState] is the done state of the introduction screen.
/// This state is displayed when the introduction screen is done.
class IntroductionDoneState extends IntroductionState {}
