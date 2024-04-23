class NewCarzModel {
  NewCarzModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.others,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
  });

  final int id;
  final String name;
  final String icon;
  final dynamic description;
  final dynamic others;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Category> categories;

  factory NewCarzModel.fromJson(Map<String, dynamic> json) {
    return NewCarzModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      icon: json["icon"] ?? "",
      description: json["description"],
      others: json["others"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "description": description,
        "others": others,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "categories": categories.map((x) => x?.toJson()).toList(),
      };
}

class Model {
  Model({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.others,
    required this.createdAt,
    required this.updatedAt,
    required this.years,
    required this.category,
  });

  final int id;
  final String categoryId;
  final String name;
  final dynamic others;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic years;
  final List<Category> category;

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json["id"] ?? 0,
      categoryId: json["category_id"] ?? "",
      name: json["name"] ?? "",
      others: json["others"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      years: json["years"],
      category: json["category"] == null
          ? []
          : List<Category>.from(
              json["category"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "others": others,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "years": years,
        "category": category.map((x) => x?.toJson()).toList(),
      };
}

class Category {
  Category({
    required this.id,
    required this.carId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.models,
  });

  final int id;
  final String carId;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Model> models;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? 0,
      carId: json["car_id"] ?? "",
      name: json["name"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      models: json["models"] == null
          ? []
          : List<Model>.from(json["models"]!.map((x) => Model.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_id": carId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "models": models.map((x) => x?.toJson()).toList(),
      };
}

class Year {
  Year({
    required this.id,
    required this.modelId,
    required this.year,
    required this.engine,
    required this.gearbox,
    required this.cylinder,
    required this.segment,
    required this.fuelCapacity,
    required this.driveType,
    required this.acceleration,
    required this.topSpeed,
    required this.tyreSize,
    required this.others,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String modelId;
  final String year;
  final String engine;
  final String gearbox;
  final String cylinder;
  final String segment;
  final String fuelCapacity;
  final String driveType;
  final dynamic acceleration;
  final dynamic topSpeed;
  final dynamic tyreSize;
  final dynamic others;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Year.fromJson(Map<String, dynamic> json) {
    return Year(
      id: json["id"] ?? 0,
      modelId: json["model_id"] ?? "",
      year: json["year"] ?? "",
      engine: json["engine"] ?? "",
      gearbox: json["gearbox"] ?? "",
      cylinder: json["cylinder"] ?? "",
      segment: json["segment"] ?? "",
      fuelCapacity: json["fuel_capacity"] ?? "",
      driveType: json["drive_type"] ?? "",
      acceleration: json["acceleration"],
      topSpeed: json["top_speed"],
      tyreSize: json["tyre_size"],
      others: json["others"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_id": modelId,
        "year": year,
        "engine": engine,
        "gearbox": gearbox,
        "cylinder": cylinder,
        "segment": segment,
        "fuel_capacity": fuelCapacity,
        "drive_type": driveType,
        "acceleration": acceleration,
        "top_speed": topSpeed,
        "tyre_size": tyreSize,
        "others": others,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
