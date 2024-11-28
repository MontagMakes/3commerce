import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/model_view_screen/model_view_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';

class ModelButtonProductDetails extends StatelessWidget {
  const ModelButtonProductDetails({
    super.key,
    required this.productDetails,
  });

  final ProductModel productDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: productDetails.modelUrl == '' ? null : Utils.appBarGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        onPressed: productDetails.modelUrl == ''
            ? null
            : () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ModelViewScreen(
                    productDetails: productDetails,
                  );
                }));
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: const Text(
          "3D",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
