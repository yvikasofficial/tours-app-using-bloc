part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UploadTourData extends UserEvent {
  final Tour tour;
  UploadTourData({@required this.tour});
}

class DeleteTourData extends UserEvent {
  final String uid;
  DeleteTourData({@required this.uid});
}

class FetchAllTours extends UserEvent {}
