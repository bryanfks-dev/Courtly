import 'package:courtly/core/errors/failure.dart';
import 'package:courtly/domain/usecases/advertisement_usecase.dart';
import 'package:courtly/domain/usecases/court_usecase.dart';
import 'package:courtly/domain/usecases/user_usecase.dart';
import 'package:courtly/presentation/blocs/states/home_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [HomeBloc] is a class that manages the state of the home screen.
class HomeBloc extends Cubit<HomeState> {
  /// [userUsecase] is the usecase for user related operations.
  final UserUsecase userUsecase;

  /// [advertisementUsecase] is the usecase for advertisement related operations.
  final AdvertisementUsecase advertisementUsecase;

  /// [courtUsecase] is the usecase for court related operations.
  final CourtUsecase courtUsecase;

  HomeBloc(
      {required this.userUsecase,
      required this.advertisementUsecase,
      required this.courtUsecase})
      : super(HomeInitialState());

  /// [getForGuest] is a method that get the datas for the guest user.
  /// This method is used when the user is not logged in.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///
  /// Returns a [Future] of [void].
  Future<void> getForGuest({String? courtType, String? vendorName}) async {
    emit(HomeLoadingState());

    // Fetch datas
    final List<Either> res = await Future.wait([
      advertisementUsecase.getAdvertisements(),
      courtUsecase.getCourts(courtType: courtType, vendorName: vendorName),
    ]);

    // Check if the advertisements are fetched successfully.
    if (res[0].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[0].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    // Check if the courts are fetched successfully.
    if (res[1].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[1].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    emit(HomeLoadedState(
        ads: res[0].getOrElse(() => throw 'No Advertisements Response'),
        courts: res[1].getOrElse(() => throw 'No Courts Response')));
  }

  /// [getForLoggedUser] is a method that get the datas for the logged user.
  /// This method is used when the user is logged in.
  ///
  /// Parameters:
  ///   - [courtType] is the type of the court.
  ///   - [vendorName] is the name of the vendor.
  ///
  /// Returns a [Future] of [void].
  Future<void> getForLoggedUser({String? courtType, String? vendorName}) async {
    emit(HomeLoadingState());

    // Fetch the user and courts.
    final List<Either> res = await Future.wait([
      userUsecase.getCurrentUser(),
      advertisementUsecase.getAdvertisements(),
      courtUsecase.getCourts(courtType: courtType, vendorName: vendorName),
    ]);

    // Check if the user is fetched successfully.
    if (res[0].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[0].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    // Check if the advertisements are fetched successfully.
    if (res[1].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[1].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    // Check if the courts are fetched successfully.
    if (res[2].isLeft()) {
      emit(HomeErrorState(
          errorMessage: res[2].fold((l) => (l as Failure).errorMessage,
              (r) => UnknownFailure("Unknown error").errorMessage)));

      return;
    }

    emit(HomeLoadedState(
        user: res[0].getOrElse(() => throw 'No User Response'),
        ads: res[1].getOrElse(() => throw 'No Advertisements Response'),
        courts: res[2].getOrElse(() => throw 'No Courts Response')));
  }
}
