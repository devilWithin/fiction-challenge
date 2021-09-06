import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
   String? name;
   String? description;
   String? image;
   double? price;
   double? salePrice;
   int? stock;
  String? id;


  ProductModel({
     this.name,
     this.description,
    this.image = '',
     this.price,
     this.salePrice,
     this.stock,
    this.id,
  });

  ProductModel.fromJson(DocumentSnapshot doc) {
    final json = doc.data()! as Map;
    name = json['name'];
    description = json['description'] ;
    image = json['image'];
    price = json['price'];
    salePrice = json['salePrice'];
    stock = json['stock'];
    id = doc.id;
  }

  Map<String, dynamic> toMap() {
    return {
      if(name != null) 'name' : name,
      if(description != null) 'description' : description,
      if(image != null) 'image' : image,
      if(price != null) 'price' : price,
      if(salePrice != null) 'salePrice' : salePrice,
      if(stock != null) 'stock' : stock,
    };
  }
}
