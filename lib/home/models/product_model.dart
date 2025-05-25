
class ProductModel {
  int? id;
  String? image;
  String? name;
  String? price;
  String? selling_price;
  bool? is_active;
  String? distance;
  num? duration;
  String? duration_type;
  String? description;
  String? user;
  String? createdAt;
  String? updatedAt;
  List<SizesAndAddons>? sizes;
  List<SizesAndAddons>? addons;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.price,
    this.duration,
    this.selling_price,
    this.is_active,
    this.distance,
    this.duration_type,
    this.description,
    this.user,
    this.sizes,
    this.addons,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to parse from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      user: json['user'],
      price: json['price'],
      is_active: json['is_active'],
      duration: json['duration'],
      selling_price: json['selling_price'],
      distance: json['distance'],
      description: json['description'],
      duration_type: json['duration_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sizes:json['sizes'] != null? List<SizesAndAddons>.from(
          json['sizes'].map((x) => SizesAndAddons.fromJson(x))):null,
      addons:json['addons'] != null? List<SizesAndAddons>.from(
          json['addons'].map((x) => SizesAndAddons.fromJson(x))):null,

    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'is_active': is_active,
      'duration': duration,
      'distance': distance,
      'description': description,
      'duration_type': duration_type,
      'user': user,
      // 'sizes': sizes,
      'addons': addons,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}


//////////////////////////////////////////////////

class SizesAndAddons {
  int? id;
  String? name;
  String? price;
  String? selling_price;


  SizesAndAddons({
    this.id,
    this.name,
    this.price,
    this.selling_price,

  });

  // Factory method to parse from JSON
  factory SizesAndAddons.fromJson(Map<String, dynamic> json) {
    return SizesAndAddons(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      selling_price: json['selling_price'],



    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'selling_price': selling_price,

    };
  }
}
