import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/common/dialog/custom_state_dialog.dart';
import 'package:my_fashion_app/common/loader/loader.dart';
import 'package:my_fashion_app/repository/user_repository.dart';
import 'package:my_fashion_app/screens/profile/bloc/profile_bloc.dart';
import 'package:my_fashion_app/screens/profile/model/profile_mode.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRepository _userRepository = UserRepository();

  late int _userId;

  late ProfileListModel userProfile = ProfileListModel();
  bool _isLoading = false;

  @override
  void initState() {
    _getLocalUserId();
    super.initState();
  }

  void _getLocalUserId() async {
    _userId = int.parse(await _userRepository.getUserId()) - 1;
    _getUserProfile();
  }

  void _getUserProfile() {
    context.read<ProfileBloc>().add(
          ProfileShown(id: _userId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.shopping_cart_outlined),
            label: 'Carrito',
            onTap: () => Navigator.pushNamed(
              context,
              '/cart',
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.list_alt),
            label: 'Pedidos',
            onTap: () => Navigator.pushNamed(
              context,
              '/orders',
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Perfil',
            onTap: () => Navigator.pushNamed(
              context,
              '/profile',
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
      ),
      body: BlocListener<ProfileBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ProfileInProgress:
              setState(() => _isLoading = true);
              break;
            case ProfileSuccess:
              final loadedData = state as ProfileSuccess;
              setState(() {
                _isLoading = false;
                userProfile = loadedData.perfil;
              });
              break;
            case ProfileError:
              final stateError = state as ProfileError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Perfil',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '${userProfile.usuario?.nombre}' ?? '',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      '${userProfile.usuario?.correoElectronico}' ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  _buildProfileInfoRow(
                    icon: Icons.location_on,
                    label: 'Dirección:',
                    value: '${userProfile.direccion}' ?? '',
                  ),
                  _buildProfileInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono:',
                    value: '${userProfile.telefono}' ?? '',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/returns');
                    },
                    icon: const Icon(
                      Icons.assignment_return,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Ver Devoluciones',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAB9144),
                      // Color dorado para el botón
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Editar Perfil',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAB9144),
                      // Color dorado para el botón
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Bordes redondeados
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final String userEmail =
                            await UserRepository().getUserEmail();
                        final String rememberUser =
                            await UserRepository().getRememberUser();

                        await UserRepository().clear();
                        await UserRepository().setUserIsSession('false');
                        if (rememberUser == 'true') {
                          await UserRepository().setUserEmail(userEmail);
                          await UserRepository().setRememberUser('true');
                        }
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
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

  Widget _buildProfileInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
