import 'dart:typed_data';

import 'package:ar_core/ar_core.dart';
import 'package:flutter/material.dart';

class AugmentedReality extends StatefulWidget {
  const AugmentedReality({
    Key? key,
  }) : super(key: key);

  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments) as Uint8List;
    return Scaffold(
      appBar: AppBar(
        title: Text("Realidad Aumentada"),
      ),
      body: Augmented(
        args, // URL de la imagen
      ),
    );
  }
}
