import 'package:e_commerce/models/model_product.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ScreenModelView extends StatefulWidget {
  static const routeName = "/productDetails";
  const ScreenModelView({super.key});

  @override
  State<ScreenModelView> createState() => _ScreenModelViewState();
}

class _ScreenModelViewState extends State<ScreenModelView> {
  String? chosenAnimation;
  String? chosenTexture;

  @override
  Widget build(BuildContext context) {
    ProductModel productDetails =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(productDetails.title),
        centerTitle: true,
        backgroundColor: Colors.white,
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
