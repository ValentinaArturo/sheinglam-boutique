import 'package:ecommerce_admin_panel/model/category.dart';
import 'package:ecommerce_admin_panel/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late List<Category> categorias = [];
  late List<Category> filteredCategorias = [];
  final CategoryService categoryService =
      CategoryService(); // Inicializa el servicio

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Carga las categorías al iniciar
  }

  // Función para cargar las categorías desde el backend
  Future<void> _fetchCategories() async {
    try {
      List<Category> categoriasFromApi = await categoryService.getCategories();
      setState(() {
        categorias = categoriasFromApi;
        filteredCategorias = categorias;
      });
    } catch (e) {
      print('Error al cargar las categorías: $e');
    }
  }

  void _agregarCategoria(BuildContext context) {
    _showCategoryModal(context);
  }

  void _editarCategoria(BuildContext context, int index) {
    _showCategoryModal(context,
        categoria: filteredCategorias[index], index: index);
  }

  void _eliminarCategoria(int index) async {
    try {
      await categoryService.deleteCategory(filteredCategorias[index].id);
      setState(() {
        filteredCategorias.removeAt(index);
        categorias = filteredCategorias;
      });
    } catch (e) {
      print('Error al eliminar la categoría: $e');
    }
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

  void _showCategoryModal(BuildContext context,
      {Category? categoria, int? index}) {
    String nombre = categoria?.nombre ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              categoria == null ? 'Agregar Categoría' : 'Editar Categoría'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Nombre'),
            controller: TextEditingController(text: nombre),
            onChanged: (value) {
              nombre = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (categoria == null) {
                  // Agregar nueva categoría
                  Category nuevaCategoria = Category(id: 0, nombre: nombre);
                  try {
                    await categoryService.addCategory(nuevaCategoria);
                    _fetchCategories(); // Refresca la lista de categorías
                  } catch (e) {
                    print('Error al agregar la categoría: $e');
                  }
                } else {
                  // Editar categoría existente
                  Category updatedCategoria =
                      Category(id: categoria.id, nombre: nombre);
                  try {
                    await categoryService.updateCategory(
                        categoria.id, updatedCategoria);
                    _fetchCategories(); // Refresca la lista de categorías
                  } catch (e) {
                    print('Error al actualizar la categoría: $e');
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
        actions: [
          TextButton.icon(
            onPressed: () => _agregarCategoria(context),
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo_agua.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar categorías...',
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
                    onChanged: _filterCategorias,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FixedColumnWidth(100),
                          2: FixedColumnWidth(100),
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
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () => _editarCategoria(context,
                                        filteredCategorias.indexOf(categoria)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.delete, color: Colors.black),
                                    onPressed: () => _eliminarCategoria(
                                        filteredCategorias.indexOf(categoria)),
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
