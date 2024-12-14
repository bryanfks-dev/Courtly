import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/user.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/events/profile_event.dart';
import 'package:courtly/presentation/blocs/states/profile_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [ProfileBloc] is the BLoC for profile data.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// [userUsecase] is the usecase for user data.
  final UserUsecase userUsecase;

  ProfileBloc({required this.userUsecase}) : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_onFetchProfileEvent);
  }

  /// [_onFetchProfileEvent] is the function to fetch the profile data.
  ///
  /// Parameters:
  ///   - [event] is the event to fetch the profile data.
  ///   - [emit] is the emitter to emit the state.
  ///
  /// Returns [Future] of [void]
  Future<void> _onFetchProfileEvent(ProfileEvent event, Emitter emit) async {
    emit(ProfileLoadingState());

    // Get current user data
    final Either<Failure, User> res = await userUsecase.getCurrentUser();

    res.fold(
      (l) => emit(ProfileErrorState(errorMessage: l.errorMessage)),
      (r) => emit(ProfileLoadedState(user: r)),
    );
  }
}
