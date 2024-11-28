import 'dart:io';

import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/create_product_screen/form_create_product/widgets/button_form_create_product.dart';
import 'package:e_commerce/screens/edit_product_screen/form_edit_product/widgets/category_form_create_product.dart';
import 'package:e_commerce/screens/edit_product_screen/form_edit_product/widgets/description_form_create_product.dart';
import 'package:e_commerce/screens/edit_product_screen/form_edit_product/widgets/price_form_create_product.dart';
import 'package:e_commerce/screens/edit_product_screen/form_edit_product/widgets/title_form_create_product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FormEditProduct extends StatefulWidget {
  final Function(bool) updateLoadingState;
  final ProductModel product;

  const FormEditProduct(
      {super.key, required this.updateLoadingState, required this.product});

  @override
  State<FormEditProduct> createState() => _FormEditProductState();
}

class _FormEditProductState extends State<FormEditProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool isImageLoaded = false;
  bool isModelLoaded = false;
  File? _imageFile;
  File? _modelFile;

  String? _selectedOption;

  void selectNewOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      isImageLoaded = false;
    });
  }

  void _removeModel() {
    setState(() {
      _modelFile = null;
      isModelLoaded = false;
    });
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        setState(() {
          _imageFile = File(result.files.single.path!);
          isImageLoaded = true;
        });
      } else {
        isImageLoaded = false;
        logger.e('FilesPicker did not work');
      }
    } catch (e) {
      logger.e('Error picking image: $e');
    }
  }

  Future<void> _pickModel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.single.extension.toString() == 'glb') {
      setState(() {
        _modelFile = File(result.files.single.path!);
        isModelLoaded = true;
      });
    } else {
      isImageLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child:
            // Form
            Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Title field
              TitleFormEditProduct(
                titleController: _titleController,
                title: widget.product.title,
              ),
              const SizedBox(height: 20),

              // Description Field
              DescriptionFormEditProduct(
                descriptionController: _descriptionController,
                description: widget.product.description,
              ),
              const SizedBox(height: 20),

              // Price Field
              PriceFormEditProduct(
                  priceController: _priceController,
                  price: widget.product.price),
              const SizedBox(height: 20),
              
              CategoryFormEditProduct(
                  selectedOption: widget.product.category,
                  selectNewOption: selectNewOption),

              const SizedBox(
                height: 20,
              ),

              // Image Field
              ElevatedButton(
                  onPressed: _pickImage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isImageLoaded == false
                          ? 'Pick Image'
                          : 'Image Selected'),
                      isImageLoaded == true
                          ? IconButton(
                              onPressed: _removeImage,
                              icon: const Icon(Icons.delete),
                            )
                          : const SizedBox(),
                    ],
                  )),

              const SizedBox(height: 10),

              // Model Field
              ElevatedButton(
                  onPressed: _pickModel,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isModelLoaded == false
                          ? 'Pick Model'
                          : 'Model Selected'),
                      isModelLoaded == true
                          ? IconButton(
                              onPressed: _removeModel,
                              icon: const Icon(Icons.delete),
                            )
                          : const SizedBox(),
                    ],
                  )),

              const SizedBox(height: 20),

              // SignUp button
              ButtonFormCreateProduct(
                updateLoadingState: widget.updateLoadingState,
                formKey: _formKey,
                titleController: _titleController,
                descriptionController: _descriptionController,
                priceController: _priceController,
                selectedOption: _selectedOption,
                imageFile: _imageFile,
                modelFile: _modelFile,
              ),
            ],
          ),
        ));
  }
}
