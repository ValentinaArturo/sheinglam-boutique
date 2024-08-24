import 'package:flutter/material.dart';

class ReturnsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> returns = [
    {'id': 1, 'amount': 100.0, 'status': 'Procesando'},
    {'id': 2, 'amount': 150.0, 'status': 'Completado'},
    {'id': 3, 'amount': 75.0, 'status': 'Rechazado'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Devoluciones'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: returns.length,
        itemBuilder: (context, index) {
          final returnItem = returns[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                'Devolución #${returnItem['id']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Monto: \$${returnItem['amount'].toStringAsFixed(2)}'),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Estado: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        returnItem['status'],
                        style: TextStyle(
                          color: _getStatusColor(returnItem['status']),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                // Implementar la navegación a la pantalla de detalles de la devolución
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completado':
        return Colors.green;
      case 'Procesando':
        return Colors.orange;
      case 'Rechazado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
