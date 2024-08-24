import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos del formulario
  TextEditingController _nameController =
      TextEditingController(text: 'Juan Pérez');
  TextEditingController _emailController =
      TextEditingController(text: 'juan.perez@example.com');
  TextEditingController _addressController =
      TextEditingController(text: 'Calle Falsa 123');
  TextEditingController _phoneController =
      TextEditingController(text: '+1 234 567 890');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  label: 'Nombre Completo',
                  controller: _nameController,
                  icon: Icons.person),
              _buildTextField(
                  label: 'Correo Electrónico',
                  controller: _emailController,
                  icon: Icons.email),
              _buildTextField(
                  label: 'Dirección',
                  controller: _addressController,
                  icon: Icons.location_on),
              _buildTextField(
                  label: 'Teléfono',
                  controller: _phoneController,
                  icon: Icons.phone),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Implementar lógica de actualización de perfil
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Perfil actualizado')),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Guardar Cambios',
                    style: TextStyle(color: Colors.white),

                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAB9144),
                    // Color dorado para el botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Bordes redondeados
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
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
            borderSide: BorderSide(color: Colors.blue),
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
