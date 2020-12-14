import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tours_app/model/tour.dart';
import 'package:tours_app/providers/user_provider.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  final UserProvider userProvider = UserProvider();
  List<Tour> tours = [];

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UploadTourData) {
      yield* _handleUploadTourData(event.tour);
    } else if (event is DeleteTourData) {
      yield* _handleDeleteTour(event.uid);
    } else if (event is PushLoadingEvent) {
      yield LoadingUserState();
    } else {
      yield* _hanldeGetAllTours();
    }
  }

  Stream<UserState> _handleUploadTourData(Tour tour) async* {
    try {
      yield LoadingUserState();
      await userProvider.uploadTourData(tour);
      tours.add(tour);
      Get.back();
      yield ToursUserState(tours: tours);
    } catch (e) {
      yield ErrorUserState(err: e.message);
    }
  }

  Stream<UserState> _hanldeGetAllTours() async* {
    try {
      yield LoadingUserState();
      final tourS = await userProvider.getAllTours();
      tours = tourS;
      yield ToursUserState(tours: tours);
    } catch (e) {
      yield ErrorUserState(err: e.message);
    }
  }

  Stream<UserState> _handleDeleteTour(String uid) async* {
    try {
      yield LoadingUserState();
      await userProvider.removeTour(uid);
      tours.removeWhere((tour) => tour.uid == uid);
      yield ToursUserState(tours: tours);
    } catch (e) {
      yield ErrorUserState(err: e.message);
    }
  }
}
