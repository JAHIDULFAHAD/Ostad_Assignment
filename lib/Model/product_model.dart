class ProductModel{
  late String id;
  late String productName;
  late int productCode;
  late String img;
  late int qty;
  late int unitPrice;
  late int totalPrice;

  ProductModel.fromJson(Map<String, dynamic> productJson){
    id = productJson['_id'];
    productName = productJson['ProductName'];
    productCode = productJson['ProductCode'];
    img = productJson['Img'];
    qty = productJson['Qty'];
    unitPrice = productJson['UnitPrice'];
    totalPrice = productJson['TotalPrice'];
  }
}