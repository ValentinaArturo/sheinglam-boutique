part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class ProfileShown extends EditprofileEvent {
  final int id;

  const ProfileShown({
    required this.id,
  });
}

class AddressShown extends EditprofileEvent {
  final int id;

  const AddressShown({
    required this.id,
  });
}

class ProfileEdited extends EditprofileEvent {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String address;
  final String phone;
  final String direccionEnvio;
  final String codigoPostal;
  final int idCiudad;
  final int idPais;

  const ProfileEdited({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
    required this.direccionEnvio,
    required this.codigoPostal,
    required this.idCiudad,
    required this.idPais,
  });
}
