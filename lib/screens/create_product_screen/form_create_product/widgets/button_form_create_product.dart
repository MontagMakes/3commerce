import 'dart:io';

import 'package:e_commerce/globals.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:e_commerce/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonFormCreateProduct extends StatelessWidget {
  const ButtonFormCreateProduct(
      {super.key,
      required this.updateLoadingState,
      required this.formKey,
      required this.titleController,
      required this.descriptionController,
      required this.priceController,
      required this.selectedOption,
      required this.imageFile,
      required this.modelFile});

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final String? selectedOption;
  final File? imageFile;
  final File? modelFile;

  final GlobalKey<FormState> formKey;
  final Function(bool) updateLoadingState;

  @override
  Widget build(BuildContext context) {
    ProductProvider product = Provider.of<ProductProvider>(context);
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (imageFile == null) {
                Utils.showToast('Please Select Image File to continue.');
                return;
              } else {
                updateLoadingState(true);
                logger.d('Product Creating');
                try {
                  await product.createProduct(
                      titleController.text,
                      descriptionController.text,
                      int.parse(priceController.text),
                      selectedOption.toString(),
                      imageFile!,
                      modelFile);

                  Navigator.pushReplacement(
                      Globals.scaffoldKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ));

                  Utils.showToast('Product Created Successfully');
                  logger.d('Product Created');
                } catch (e) {
                  logger.e(e);
                  Utils.showToast('Product Creation failed: $e');
                } finally {
                  updateLoadingState(false);
                }
              }
            }
          },
          child: const Text(
            'Create Product',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ));
  }
}
