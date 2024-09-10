import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/services/shipment_service.dart';
import 'package:flutter/material.dart';

class ShipmentsScreen extends StatefulWidget {
  @override
  _ShipmentsScreenState createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  final ShipmentService _envioService = ShipmentService();
  List<Map<String, dynamic>> _envios = [];
  late List<Map<String, dynamic>> _filteredEnvios;

  @override
  void initState() {
    super.initState();
    _loadEnvios();
  }

  Future<void> _loadEnvios() async {
    try {
      final envios = await _envioService.getEnvios();
      setState(() {
        _envios = envios;
        _filteredEnvios = _envios;
      });
    } catch (e) {
      // Manejo de errores
      print('Error loading envíos: $e');
    }
  }

  Future<void> _agregarEnvio(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EnvioDialog(),
    );

    if (result != null) {
      try {
        await _envioService.createEnvio(result);
        _loadEnvios(); // Recargar envíos después de agregar
      } catch (e) {
        // Manejo de errores
        print('Error adding envío: $e');
      }
    }
  }

  Future<void> _editarEnvio(BuildContext context, int index) async {
    final envio = _filteredEnvios[index];
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EnvioDialog(envio: envio),
    );

    if (result != null) {
      try {
        await _envioService.updateEnvio(envio['idEnvio'], result);
        _loadEnvios(); // Recargar envíos después de editar
      } catch (e) {
        // Manejo de errores
        print('Error updating envío: $e');
      }
    }
  }

  void _eliminarEnvio(int index) async {
    try {
      final envioId = _filteredEnvios[index]['idEnvio'];
      await _envioService.deleteEnvio(envioId);
      setState(() {
        _filteredEnvios.removeAt(index);
      });
    } catch (e) {
      // Manejo de errores
      print('Error deleting envío: $e');
    }
  }

  void _filterEnvios(String query) {
    setState(() {
      _filteredEnvios = _envios.where((envio) {
        final nombreLower = envio['nombre'].toLowerCase();
        final departamentoLower = envio['departamento'].toLowerCase();
        final queryLower = query.toLowerCase();

        return nombreLower.contains(queryLower) ||
            departamentoLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Lista de Envíos'),
        actions: [
          TextButton.icon(
            onPressed: () => _agregarEnvio(context),
            icon: Icon(Icons.add, color: Colors.black),
            label: Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo_agua.jpg', // Ruta de tu imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar envíos...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: _filterEnvios,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FixedColumnWidth(100),
                          4: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Nombre',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Departamento',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Precio',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Editar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ..._filteredEnvios.map((envio) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(envio['nombre']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(envio['departamento']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${envio['precio']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () => _editarEnvio(context,
                                        _filteredEnvios.indexOf(envio)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.delete, color: Colors.black),
                                    onPressed: () => _eliminarEnvio(
                                        _filteredEnvios.indexOf(envio)),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvioDialog extends StatefulWidget {
  final Map<String, dynamic>? envio;

  _EnvioDialog({this.envio});

  @override
  __EnvioDialogState createState() => __EnvioDialogState();
}

class __EnvioDialogState extends State<_EnvioDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _departamentoController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.envio?['nombre'] ?? '');
    _departamentoController =
        TextEditingController(text: widget.envio?['departamento'] ?? '');
    _precioController =
        TextEditingController(text: widget.envio?['precio']?.toString() ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _departamentoController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.envio == null ? 'Agregar Envío' : 'Editar Envío'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) =>
                  value!.isEmpty ? 'El nombre es obligatorio' : null,
            ),
            TextFormField(
              controller: _departamentoController,
              decoration: InputDecoration(labelText: 'Departamento'),
              validator: (value) =>
                  value!.isEmpty ? 'El departamento es obligatorio' : null,
            ),
            TextFormField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? 'El precio es obligatorio' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'nombre': _nombreController.text,
                'departamento': _departamentoController.text,
                'precio': double.parse(_precioController.text),
              });
            }
          },
          child: Text(widget.envio == null ? 'Agregar' : 'Actualizar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}
