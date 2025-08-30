import 'dart:convert';
import 'package:crud_api/Screen/update_product.dart';
import 'package:crud_api/Utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Model/product_model.dart';
import '../Widget/product_item.dart';
import 'add_product.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _getProductListInProgress = false;
  List<ProductModel> _productList=[];
  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    _productList.clear();
    Uri url = Uri.parse(Urls.getProductUrl);
    Response response = await get(url);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if(response.statusCode==200){
      final decodedJson = jsonDecode(response.body);
      for(Map<String,dynamic> productjsonn in decodedJson['data']){
        ProductModel product = ProductModel.fromJson(productjsonn);
        _productList.add(product);
      }
    }
    _getProductListInProgress = false;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: const Text('Product List'),
        actions: [IconButton(onPressed: _getProductList, icon: Icon(Icons.refresh))],
        centerTitle: true,
      ),
      body: Visibility(
        visible: _getProductListInProgress==false,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.separated(
          separatorBuilder: (context,index){
            return Divider(
              indent: 70,
            );
          },
          itemCount: _productList.length,
            itemBuilder: (context,index){
              return ProductItem(product: _productList[index], refershProductlist: _getProductList,);
            }),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}

