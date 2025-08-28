import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                children: [
                  TextFormField(
                    controller: _productNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      hintText: 'Enter Product Name',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _codeController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Code',
                      hintText: 'Enter Code',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _quantityController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: 'Enter Quantity',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _unitPriceController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Unit Price',
                      hintText: 'Enter Unit Price',
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                      hintText: 'Enter Image Url',
                    ),
                  ),
                  SizedBox(height: 12,),
                  FilledButton(onPressed: (){}, child: Text('Update Product'))

                ]
            ),
          )),
    );
  }
  void dispose() {
    _productNameController.dispose();
    _codeController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}

