import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewScreen extends StatelessWidget {
  const ModelViewScreen({super.key, required this.productDetails});

  final ProductModel productDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(productDetails.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ModelViewer(
          backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: productDetails.modelUrl,
          alt: productDetails.title,
          cameraControls: true,
          cameraTarget: "[0.0, 0.0, 0.0]",
          autoRotate: true,
          fieldOfView: "auto",
          environmentImage: "neutral",
          disableZoom: false,
        ),
      ),
    );
  }
}
