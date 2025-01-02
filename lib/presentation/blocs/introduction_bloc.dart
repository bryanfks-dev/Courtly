import 'package:courtly/presentation/blocs/events/introduction_event.dart';
import 'package:courtly/presentation/blocs/states/introduction_state.dart';
import 'package:courtly/presentation/providers/introduction_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [IntroductionBloc] is the bloc for introduction.
class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  /// [introductionProvider] is the provider for introduction.
  final IntroductionProvider introductionProvider;

  IntroductionBloc({required this.introductionProvider})
      : super(IntroductionInitialState()) {
    on<CheckIntroductionEvent>(_onCheckIntroduction);

    on<SetIntroductionDoneEvent>(_onSetIntroductionDone);
  }

  /// [_onCheckIntroduction] is a function to handle the [CheckIntroductionEvent].
  ///
  /// Parameters:
  ///   - [event] is the event.
  ///   - [emit] is the emitter.
  ///
  /// Returns [Future] of [void]
  Future<void> _onCheckIntroduction(
      CheckIntroductionEvent event, Emitter<IntroductionState> emit) async {
    // Check if the introduction is done
    final bool introductionDone =
        await introductionProvider.getIntroductionStatus();

    // Check if the introduction is done
    if (introductionDone) {
      emit(IntroductionDoneState());

      return;
    }

    emit(IntroductionUndoneState());
  }

  /// [_onSetIntroductionDone] is a function to handle the [SetIntroductionDoneEvent].
  ///
  /// Parameters:
  ///   - [event] is the event.
  ///   - [emit] is the emitter.
  ///
  /// Returns [Future] of [void]
  Future<void> _onSetIntroductionDone(
      SetIntroductionDoneEvent event, Emitter<IntroductionState> emit) async {
    // Set the introduction as done
    introductionProvider.setIntroductionDone();

    emit(IntroductionDoneState());
  }
}
