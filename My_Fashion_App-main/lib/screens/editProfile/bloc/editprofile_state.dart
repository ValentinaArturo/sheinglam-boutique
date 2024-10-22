part of 'editprofile_bloc.dart';

abstract class EditprofileState extends BaseState {}

class EditprofileInitial extends EditprofileState {}

class EditprofileInProgress extends EditprofileState {}

class EditprofileSuccess extends EditprofileState {}

class EditprofileAddressSuccess extends EditprofileState {
  final AddressListModel addressModel;

  EditprofileAddressSuccess({
    required this.addressModel,
  });
}

class EditprofileError extends EditprofileState {
  final String message;

  EditprofileError({
    required this.message,
  });
}
