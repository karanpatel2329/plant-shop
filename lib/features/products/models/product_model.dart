// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    int? categoryId;
    String? imageUrl;
    String? name;
    double? rating;
    int? displaySize;
    List<int>? availableSize;
    String? unit;
    String? price;
    String? priceUnit;
    String? description;

    Product({
        this.id,
        this.categoryId,
        this.imageUrl,
        this.name,
        this.rating,
        this.displaySize,
        this.availableSize,
        this.unit,
        this.price,
        this.priceUnit,
        this.description,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        name: json["name"],
        rating: double.tryParse((json["rating"]??'0').toString()),
        displaySize: json["display_size"],
        availableSize: json["available_size"] == null ? [] : List<int>.from(json["available_size"]!.map((x) => x)),
        unit: json["unit"],
        price: json["price"],
        priceUnit: json["price_unit"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "image_url": imageUrl,
        "name": name,
        "rating": rating,
        "display_size": displaySize,
        "available_size": availableSize == null ? [] : List<dynamic>.from(availableSize!.map((x) => x)),
        "unit": unit,
        "price": price,
        "price_unit": priceUnit,
        "description": description,
    };
}
