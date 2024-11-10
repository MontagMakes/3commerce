import 'dart:io';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/providers/provider_product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _imageController = TextEditingController();
  final bool _isLoading = false;
  bool isImageLoaded = false;
  bool isModelLoaded = false;
  late File _imageFile;
  late File _modelFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
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
  }

  Future<void> _pickModel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
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
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Product'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF4081), Color(0xFFFF7043)],
          ),
        ),

        // if the screen is loading, show loadingIndicator else show screen
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
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
                                if (value == null) {
                                  return 'Please enter a price';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter the Price',
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Image Field
                            ElevatedButton(
                                onPressed: _pickImage,
                                child: Text(isImageLoaded == false
                                    ? 'Pick Image'
                                    : 'Image Selected')),

                            const SizedBox(height: 30),

                            // Model Field
                            ElevatedButton(
                                onPressed: _pickModel,
                                child: Text(isModelLoaded == false
                                    ? 'Pick Model'
                                    : 'Model Selected')),

                            // SignUp button
                            Consumer<ProviderProduct>(
                              builder: (context, product, child) => SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      product.addProduct(
                                          _titleController.text,
                                          _descriptionController.text,
                                          int.parse(_priceController.text),
                                          _imageFile,
                                          _modelFile);
                                    },
                                    child: const Text(
                                      'SignUp',
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
      ),
    );
  }
}
