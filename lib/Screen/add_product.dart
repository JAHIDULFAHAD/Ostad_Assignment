import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Utils/urls.dart';
import '../Widget/snackbar_massege.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _addProductInProgress = false;
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
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Product Name";
                  }
                  return null;
                }),
              SizedBox(height: 8,),
              TextFormField(
                controller: _codeController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Code',
                  hintText: 'Enter Code',
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Code";
                  }
                  return null;
                },
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
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Quantity";
                  }
                  return null;
                },
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
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Unit Price";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'Image Url',
                  hintText: 'Enter Image Url',
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Image Url";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              Visibility(
                  visible: _addProductInProgress==false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(onPressed: onTapAddProductButton, child: Text('Add Product')))
            ]
          ),
        )),
      ),
    );
  }
  Future<void> onTapAddProductButton() async {
    if(_formKey.currentState!.validate()==false){
      return;
    }
    _addProductInProgress=true;
    setState(() {});

    Uri url = Uri.parse(Urls.addProductUrl);
    int totalPrice = int.parse(_unitPriceController.text )* int.parse(_quantityController.text);
    Map<String, dynamic> requestBody = {
      "ProductName": _productNameController.text.trim(),
      "ProductCode": _codeController.text.trim(),
      "Img": _imageUrlController.text.trim(),
      "Qty": _quantityController.text.trim(),
      "UnitPrice": _unitPriceController.text.trim(),
      "TotalPrice": totalPrice,
    };
    Response response =await post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      final decodedJson = jsonDecode(response.body);
      if(decodedJson['status']== 'success'){
        _ClearTextFields();
        ShowSnackbarMessage(context, 'Product Added Successfully');
      }else{
        String errorMessage = decodedJson['data'];
        ShowSnackbarMessage(context, (errorMessage));
      }
    }
    _addProductInProgress=false;
    setState(() {});
  }

  void  _ClearTextFields(){
    _productNameController.clear();
    _codeController.clear();
    _quantityController.clear();
    _unitPriceController.clear();
    _imageUrlController.clear();
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

