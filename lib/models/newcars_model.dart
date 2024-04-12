 
class NewCarzModel {
    NewCarzModel({
        required this.id,
        required this.name,
        required this.icon,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.categories,
    });

    final int id;
    final String name;
    final dynamic icon;
    final dynamic description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Category> categories;

    factory NewCarzModel.fromJson(Map<String, dynamic> json){ 
        return NewCarzModel(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            icon: json["icon"] ?? '',
            description: json["description"] ?? '',
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "categories": categories.map((x) => x?.toJson()).toList(),
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
    final int carId;
    final String name;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Model> models;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["id"] ?? 0,
            carId: json["car_id"] ?? 0,
            name: json["name"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            models: json["models"] == null ? [] : List<Model>.from(json["models"]!.map((x) => Model.fromJson(x))),
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

class Model {
    Model({
        required this.id,
        required this.categoryId,
        required this.name,
        required this.others,
        required this.createdAt,
        required this.updatedAt,
        required this.engines,
        required this.gearboxies,
    });

    final int id;
    final int categoryId;
    final String name;
    final dynamic others;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Engine> engines;
    final List<Engine> gearboxies;

    factory Model.fromJson(Map<String, dynamic> json){ 
        return Model(
            id: json["id"] ?? 0,
            categoryId: json["category_id"] ?? 0,
            name: json["name"] ?? "",
            others: json["others"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            engines: json["engines"] == null ? [] : List<Engine>.from(json["engines"]!.map((x) => Engine.fromJson(x))),
            gearboxies: json["gearboxies"] == null ? [] : List<Engine>.from(json["gearboxies"]!.map((x) => Engine.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "others": others,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "engines": engines.map((x) => x?.toJson()).toList(),
        "gearboxies": gearboxies.map((x) => x?.toJson()).toList(),
    };

}

class Engine {
    Engine({
        required this.id,
        required this.modelsId,
        required this.name,
        required this.others,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final int modelsId;
    final String name;
    final dynamic others;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory Engine.fromJson(Map<String, dynamic> json){ 
        return Engine(
            id: json["id"] ?? 0,
            modelsId: json["models_id"] ?? 0,
            name: json["name"] ?? "",
            others: json["others"] ?? '',
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "models_id": modelsId,
        "name": name,
        "others": others,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
