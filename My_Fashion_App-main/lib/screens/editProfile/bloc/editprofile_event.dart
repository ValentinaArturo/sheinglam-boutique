part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class ProfileEdited extends EditprofileEvent {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String phone;

  const ProfileEdited({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
  });
}

class AddressShown extends EditprofileEvent {
  final int id;

  const AddressShown({
    required this.id,
  });
}
