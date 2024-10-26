part of 'editprofile_bloc.dart';

abstract class EditprofileState extends BaseState {}

class EditProfileInitial extends EditprofileState {}

class EditProfileInProgress extends EditprofileState {}

class ProfileSuccess extends EditprofileState {
  final PerfilModel userProfile;

  ProfileSuccess({
    required this.userProfile,
  });
}

class AddressSuccess extends EditprofileState {
  final AddressListModel addressModel;

  AddressSuccess({
    required this.addressModel,
  });
}

class EditProfileSuccess extends EditprofileState {}

class EditprofileError extends EditprofileState {
  final String message;

  EditprofileError({
    required this.message,
  });
}
