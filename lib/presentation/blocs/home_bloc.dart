import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/entities/court.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/states/home_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [HomeBloc] is a class that manages the state of the home screen.
class HomeBloc extends Cubit<HomeState> {
  /// [userUsecase] is the usecase for user related operations.
  final UserUsecase userUsecase;

  /// [courtUsecase] is the usecase for court related operations.
  final CourtUsecase courtUsecase;

  HomeBloc({required this.userUsecase, required this.courtUsecase})
      : super(HomeInitialState());

  /// [fetchCourtsOnly] is a method that fetches the courts only.
  /// This method is used when the user is not logged in.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [void].
  Future<void> fetchCourtsOnly({String? courtType, String? vendorName}) async {
    emit(HomeLoadingState());

    // Fetch the courts.
    final Either<Failure, List<Court>> res = await courtUsecase.getCourts(
        courtType: courtType, vendorName: vendorName);

    res.fold((l) => emit(HomeErrorState(errorMessage: l.errorMessage)),
        (r) => emit(HomeLoadedState(courts: r)));
  }

  /// [fetch] is a method that fetches the user and courts.
  ///
  /// Returns a [Future] of [void].
  Future<void> fetch() async {
    emit(HomeLoadingState());

    // Fetch the user and courts.
    final List<Either> res = await Future.wait([
      userUsecase.getCurrentUser(),
      courtUsecase.getCourts(),
    ]);

    // Check if the user is fetched successfully.
    if (res[0].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[0].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    // Check if the courts is fetched successfully.
    if (res[1].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[1].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    emit(HomeLoadedState(
        user: res[0].getOrElse(() => throw 'No User Response'),
        courts: res[1].getOrElse(() => throw 'No Courts Response')));
  }
}
