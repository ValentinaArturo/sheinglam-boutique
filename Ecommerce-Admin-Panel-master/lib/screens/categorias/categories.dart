import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/common/dialog/custom_state_dialog.dart';
import 'package:ecommerce_admin_panel/common/loader/loader.dart';
import 'package:ecommerce_admin_panel/common/menu_drawer.dart';
import 'package:ecommerce_admin_panel/screens/categorias/bloc/categoria_bloc.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriaPage extends StatelessWidget {
  const CategoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriaBloc(),
      child: const CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController nombreController = TextEditingController();

  late List<CategoriaListModel> categorias = [];
  late List<CategoriaListModel> filteredCategorias = [];

  bool _isLoading = false;
  late int? _idCategoria;

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Carga las categorías al iniciar
  }

  // Función para cargar las categorías desde el backend
  Future<void> _fetchCategories() async {
    context.read<CategoriaBloc>().add(
          CategoriaShown(),
        );
  }

  void _agregarCategoria() {
    context.read<CategoriaBloc>().add(
          CategoriaSaved(
            nombre: nombreController.text,
          ),
        );
  }

  void _editarCategoria() {
    context.read<CategoriaBloc>().add(
          CategoriaEdited(
            nombre: nombreController.text,
            id: _idCategoria!,
          ),
        );
  }

  void _eliminarCategoria({required int id}) {
    context.read<CategoriaBloc>().add(
          CategoriaDeleted(
            id: id,
          ),
        );
  }

  void _filterCategorias(String query) {
    setState(() {
      filteredCategorias = categorias.where((categoria) {
        final nombreLower = categoria.nombre.toLowerCase();
        final queryLower = query.toLowerCase();
        return nombreLower.contains(queryLower);
      }).toList();
    });
  }

  void _showdeleteModal({required int id}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Categoria'),
          content: const Text(
            'Confirma que desas eliminar esta categoria, todos los datos se perderán.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _eliminarCategoria(id: id);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _showCategoryModal([bool isEdit = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Agregar Categoría' : 'Editar Categoría'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Nombre'),
            controller: nombreController,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (isEdit) {
                  _editarCategoria();
                } else {
                  _agregarCategoria();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lista de Categorías'),
        actions: [
          TextButton.icon(
            onPressed: () {
              nombreController.clear();
              _showCategoryModal();
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Agregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<CategoriaBloc, BaseState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case const (CategoriaInProgress):
              setState(() => _isLoading = true);
              break;
            case const (CategoriaSuccess):
              final loadedState = state as CategoriaSuccess;
              setState(() {
                _isLoading = false;
                categorias = loadedState.categorias;
                filteredCategorias = loadedState.categorias;
              });
              break;
            case const (CategoriaCreatedSuccess):
              _fetchCategories();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Categorias',
                description: "Categoria creada correctamente",
              );
              break;
            case const (CategoriaEditedSuccess):
              _fetchCategories();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Categorias',
                description: "Categoria editada correctamente",
              );
              break;
            case const (CategoriaDeletedSuccess):
              _fetchCategories();
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Categorias',
                description: "Categoria borrada correctamente",
              );
              break;
            case const (CategoriaError):
              final stateError = state as CategoriaError;
              setState(() => _isLoading = false);
              CustomStateDialog.showAlertDialog(
                context,
                title: 'Categorias',
                description: stateError.message,
                isError: true,
              );
              break;
            case const (ServerClientError):
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
            Positioned.fill(
              child: Image.asset(
                'assets/images/fondo_agua.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar categorías...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: _filterCategorias,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(color: Colors.grey),
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                            1: FixedColumnWidth(100),
                            2: FixedColumnWidth(100),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Nombre',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Editar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Eliminar',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            ...filteredCategorias.map((categoria) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(categoria.nombre),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      onPressed: () {
                                        _idCategoria = categoria.idCategoria;
                                        nombreController.text =
                                            categoria.nombre;
                                        _showCategoryModal(true);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () => _showdeleteModal(
                                        id: categoria.idCategoria,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
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
}
