import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Model/product_model.dart';
import '../Utils/urls.dart';
import '../Widget/snackbar_massege.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct ({super.key, required this.product});
  final ProductModel product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  bool _updateProductInProgress = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void initState() {
    super.initState();

    _productNameController.text = widget.product.productName;
    _codeController.text = widget.product.productCode.toString();
    _quantityController.text = widget.product.qty.toString();
    _unitPriceController.text = widget.product.unitPrice.toString();
    _imageUrlController.text = widget.product.img;
  }

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
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Please Enter Product Name";
                      }
                      return null;
                    },

                  ),
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
                      visible: _updateProductInProgress==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(onPressed: _updateProductButton, child: Text('Update Product')))

                ]
            ),
          )),
    );
  }
  Future<void> _updateProductButton() async {
    if(_formKey.currentState!.validate()==false){
      return;
    }
    _updateProductInProgress=true;
    setState(() {});

    Uri url = Uri.parse(Urls.updateProductUrl(widget.product.id));
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
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if(response.statusCode==200){
      final decodedJson = jsonDecode(response.body);
      if(decodedJson['status']== 'success'){
        ShowSnackbarMessage(context, 'Product Update Successfully');
      }else{
        String errorMessage = decodedJson['data'];
        ShowSnackbarMessage(context, (errorMessage));
      }
    }
    _updateProductInProgress=false;
    setState(() {});

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

