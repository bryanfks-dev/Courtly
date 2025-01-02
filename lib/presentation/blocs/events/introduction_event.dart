/// [IntroductionEvent] is the abstract class that will be extended by the
/// events of the introduction bloc.
abstract class IntroductionEvent {}

/// [CheckIntroductionEvent] is the event to check the introduction.
/// This event will be used to check the introduction.
class CheckIntroductionEvent extends IntroductionEvent {}

/// [SetIntroductionDoneEvent] is the event to set the introduction as done.
/// This event will be used to set the introduction as done.
class SetIntroductionDoneEvent extends IntroductionEvent{}
