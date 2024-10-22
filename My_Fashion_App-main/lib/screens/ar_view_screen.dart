import 'package:ar_core/ar_core.dart';
import 'package:flutter/material.dart';

class AugmentedReality extends StatefulWidget {
  const AugmentedReality({Key? key}) : super(key: key);

  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realidad Aumentada"),
      ),
      body: Augmented(
         'assets/images/vestido_rojo.png', // URL de la imagen
      ),
    );
  }
}