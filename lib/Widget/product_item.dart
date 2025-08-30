import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Model/product_model.dart';
import '../Screen/update_product.dart';
import '../Utils/urls.dart';

class ProductItem extends StatefulWidget {

  const ProductItem({
    super.key, required this.product, required this.refershProductlist,
  });
  final ProductModel product;
  final VoidCallback refershProductlist;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _deleteProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(
          width: 40,
          widget.product.img,errorBuilder: (_, __, ___){
            return Icon(Icons.error,size: 30,);
          },),
        title: Text(widget.product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Code: ${widget.product.productCode}"),
            Row(
              children: [
                Text('Quantity: ${widget.product.qty}'),
                SizedBox(width: 15,),
                Text('Unit Price: ${widget.product.unitPrice}')
              ],
            )
          ],
        ),
        trailing: Visibility(
          visible: _deleteProductInProgress==false,
          replacement:  CircularProgressIndicator(),
          child: PopupMenuButton<ProductOptions>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: ProductOptions.update,
                    child: Text('Update'),
                  ),
                  PopupMenuItem(
                    value: ProductOptions.delete,
                    child: Text('Delete'),
                  )
                ];
              },
              onSelected: (value) {
                if (value == ProductOptions.update) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateProduct( product: widget.product)));
                } else if (value == ProductOptions.delete) {
                  _deleteProductList();
                }
              }
          ),
        )
    );
  }
  Future<void> _deleteProductList() async {
    _deleteProductInProgress = true;
    setState(() {});
    Uri url = Uri.parse(Urls.deleteProductUrl(widget.product.id));
    Response response = await get(url);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if(response.statusCode==200){
      widget.refershProductlist();
    }
    _deleteProductInProgress = false;
    setState(() {
    });

  }
}

enum ProductOptions { update, delete }