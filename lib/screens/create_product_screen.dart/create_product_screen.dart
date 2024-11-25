import 'dart:io';
import 'package:e_commerce/globals.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/main_screen/main_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedOption;
  bool _isLoading = false;
  bool isImageLoaded = false;
  bool isModelLoaded = false;
  File? _imageFile;
  File? _modelFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void isLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void selectedOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  Future<void> _pickImage() async {
    isLoading(true);
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
    isLoading(false);
  }

  Future<void> _pickModel() async {
    isLoading(true);
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
    isLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),

                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          // Title field
                          TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the title';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Enter title',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Description Field
                          TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the description';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Enter Description',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Price Field
                          TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a price';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Enter the Price',
                            ),
                          ),
                          const SizedBox(height: 20),

                          DropdownButtonFormField(
                            items: Globals.categories.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? value) =>
                                selectedOption(value!),
                            value: _selectedOption,
                            decoration: const InputDecoration(
                                labelText: 'Select Category'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // Image Field
                          ElevatedButton(
                              onPressed: _pickImage,
                              child: Text(isImageLoaded == false
                                  ? 'Pick Image'
                                  : 'Image Selected')),

                          const SizedBox(height: 10),

                          // Model Field
                          ElevatedButton(
                              onPressed: _pickModel,
                              child: Text(isModelLoaded == false
                                  ? 'Pick Model'
                                  : 'Model Selected')),

                          const SizedBox(height: 20),

                          // SignUp button
                          Consumer<ProductProvider>(
                            builder: (context, product, child) => SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (_imageFile == null ||
                                          _modelFile == null) {
                                        Fluttertoast.showToast(
                                          msg:
                                              'Please Select Both Image file and model File to continue.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0,
                                        );
                                        return;
                                      } else {
                                        isLoading(true);
                                        logger.d('Product Creating');
                                        try {
                                          await product.createProduct(
                                              _titleController.text,
                                              _descriptionController.text,
                                              int.parse(_priceController.text),
                                              _selectedOption.toString(),
                                              _imageFile!,
                                              _modelFile!);

                                          Navigator.pushReplacement(
                                              Globals
                                                  .scaffoldKey.currentContext!,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainScreen(),
                                              ));
                                          logger.d('Product Created');
                                          isLoading(false);
                                        } catch (e) {
                                          logger.e(e);
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
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
