import 'package:crud_api/Screen/update_product.dart';
import 'package:flutter/material.dart'
;

import 'add_product.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context,index){
          return Divider(
            indent: 70,
          );
        },
        itemCount: 10,
          itemBuilder: (context,index){
            return ListTile(
              leading: CircleAvatar(),
              title: Text("Product Name: Apple"),
              subtitle:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Code: 1234"),
                  Row(
                    children: [
                      Text('Quantity: 200'),
                      SizedBox(width: 15,),
                      Text('Unit Price: 1000')
                    ],
                  )
                ],
              ),
              trailing: PopupMenuButton<ProductOptions>(
                itemBuilder: (context){
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
                onSelected: (value){
                  if(value==ProductOptions.update){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProduct()));
                  }else if(value==ProductOptions.delete){
                    print('Delete');
                  }
                }
              )
            );
          }),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
enum ProductOptions { update, delete }
