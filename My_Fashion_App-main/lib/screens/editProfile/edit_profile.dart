import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/repository/user_repository.dart';
import 'package:my_fashion_app/screens/editProfile/bloc/editprofile_bloc.dart';
import 'package:my_fashion_app/screens/editProfile/model/edit_profile_model.dart';
import 'package:my_fashion_app/screens/editProfile/model/profile_model.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditprofileBloc(),
      child: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos del formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final UserRepository _userRepository = UserRepository();

  late int? _userId;
  late int? _cityId;
  late int? _countryId;

  AddressListModel addressModel = AddressListModel();
  PerfilModel userProfile = PerfilModel();

  bool _isLoading = false;

  @override
  void initState() {
    _userId = null;
    _cityId = null;
    _countryId = null;
    _getLocalUserId();
    super.initState();
  }

  void _getLocalUserId() async {
    _userId = int.parse(await _userRepository.getUserId()) - 1;
    _getAddressUser();
    _getUserProfile();
  }

  void _getAddressUser() {
    context.read<EditprofileBloc>().add(
          AddressShown(id: _userId!),
        );
  }

  void _getUserProfile() {
    context.read<EditprofileBloc>().add(
          ProfileShown(id: _userId!),
        );
  }

  void _editUserProfile() {
    context.read<EditprofileBloc>().add(
          ProfileEdited(
            id: _userId!,
            name: _nameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            address: _addressController.text,
            phone: _phoneController.text,
            direccionEnvio: _shippingAddressController.text,
            codigoPostal: _postalCodeController.text,
            idCiudad: _cityId!,
            idPais: _countryId!,
          ),
        );
  }

  void _setDataToFields() {
    setState(() {
      _nameController.text = '${userProfile.usuario?.nombre}';
      _lastNameController.text = '${userProfile.usuario?.apellido}';
      _emailController.text = '${userProfile.usuario?.correoElectronico}';
      _passwordController.text = '${userProfile.usuario?.contrasea}';
      _addressController.text = '${userProfile.direccion}';
      _phoneController.text = '${userProfile.telefono}';
    });
  }

  void _setAddressToFields() {
    setState(() {
      _shippingAddressController.text = '${addressModel.direccion}';
      _postalCodeController.text = '${addressModel.codigoPostal}';
      _cityId = addressModel.ciudad!.idCiudad;
      _countryId = addressModel.pais!.idPais;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: BlocListener<EditprofileBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case EditProfileInProgress:
              setState(() => _isLoading = true);
              break;
            case ProfileSuccess:
              final loadedData = state as ProfileSuccess;
              setState(() {
                _isLoading = false;
                userProfile = loadedData.userProfile;
              });
              _setDataToFields();
              break;
            case AddressSuccess:
              final loadedData = state as AddressSuccess;
              setState(() {
                _isLoading = false;
                addressModel = loadedData.addressModel;
                _setAddressToFields();
              });
              break;
            case EditProfileSuccess:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Editar perfil',
                description: 'Perefil editado correctamente.',
              );
              break;
            case EditprofileError:
              final stateError = state as EditprofileError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Editar perfil',
                description: stateError.message,
                isError: true,
              );
              break;
            case ServerClientError:
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Error',
                description: 'En este momento no podemos atender tu solicitud.',
                isError: true,
              );
              break;
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        label: 'Nombre',
                        controller: _nameController,
                        icon: Icons.person),
                    _buildTextField(
                        label: 'Apellido',
                        controller: _lastNameController,
                        icon: Icons.person),
                    _buildTextField(
                        label: 'Correo Electrónico',
                        controller: _emailController,
                        icon: Icons.email),
                    _buildTextField(
                        label: 'Contraseña',
                        controller: _passwordController,
                        icon: Icons.person),
                    _buildTextField(
                        label: 'Dirección',
                        controller: _addressController,
                        icon: Icons.location_on),
                    _buildTextField(
                        label: 'Teléfono',
                        controller: _phoneController,
                        icon: Icons.phone),
                    _buildTextField(
                        label: 'Direccion de envio',
                        controller: _shippingAddressController,
                        icon: Icons.person),
                    _buildTextField(
                        label: 'Codig Postal',
                        controller: _postalCodeController,
                        icon: Icons.person),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _editUserProfile();
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Guardar Cambios',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAB9144),
                          // Color dorado para el botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) {
                if (_isLoading) {
                  return const Loader();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa tu $label';
          }
          return null;
        },
      ),
    );
  }
}
