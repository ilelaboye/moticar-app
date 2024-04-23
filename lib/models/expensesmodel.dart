class GetExpenses {
  GetExpenses({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.technicianId,
    required this.amount,
    required this.total,
    required this.methodOfPayment,
    required this.imageProof,
    required this.carpart,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.carparts,
  });

  final int? id;
  final int? userId;
  final String? category;
  final String? title;
  final String? description;
  final int? technicianId;
  final int? amount;
  final int? total;
  final String? methodOfPayment;
  final dynamic imageProof;
  final int? carpart;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Carpart> carparts;

  factory GetExpenses.fromJson(Map<String, dynamic> json) {
    return GetExpenses(
      id: json["id"],
      userId: json["user_id"],
      category: json["category"],
      title: json["title"],
      description: json["description"] ?? '',
      technicianId: json["technician_id"],
      amount: json["amount"],
      total: json["total"],
      methodOfPayment: json["method_of_payment"],
      imageProof: json["image_proof"],
      carpart: json["carpart"],
      date: DateTime.tryParse(json["date"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      carparts: json["carparts"] == null
          ? []
          : List<Carpart>.from(
              json["carparts"]!.map((x) => Carpart.fromJson(x))),
    );
  }
}

class Carpart {
  Carpart({
    required this.id,
    required this.expenseId,
    required this.category,
    required this.productName,
    required this.description,
    required this.brand,
    required this.condition,
    required this.unitOfMeasurement,
    required this.price,
    required this.quantity,
    required this.total,
    required this.image,
    required this.generatedImage,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? expenseId;
  final String? category;
  final String? productName;
  final dynamic description;
  final String? brand;
  final String? condition;
  final String? unitOfMeasurement;
  final int? price;
  final String? quantity;
  final int? total;
  final dynamic image;
  final dynamic generatedImage;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Carpart.fromJson(Map<String, dynamic> json) {
    return Carpart(
      id: json["id"],
      expenseId: json["expense_id"],
      category: json["category"],
      productName: json["product_name"],
      description: json["description"] ?? "",
      brand: json["brand"],
      condition: json["condition"],
      unitOfMeasurement: json["unit_of_measurement"],
      price: json["price"],
      quantity: json["quantity"],
      total: json["total"],
      image: json["image"],
      generatedImage: json["generated_image"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
}

//technicinas

class GetTechies {
  GetTechies({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.preferredName,
    required this.phone,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final dynamic email;
  final String? preferredName;
  final String? phone;
  final String? category;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetTechies.fromJson(Map<String, dynamic> json) {
    return GetTechies(
      id: json["id"],
      userId: json["user_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      preferredName: json["preferred_name"],
      phone: json["phone"],
      category: json["category"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class GetCarz {
  GetCarz({
    required this.id,
    required this.userId,
    required this.carYearId,
    required this.plateNumber,
    required this.mileage,
    required this.chasisNumber,
    required this.engineNumber,
    required this.dateOfPurchase,
    required this.vehicleLicense,
    required this.roadWorthiness,
    required this.thirdPartyInsurance,
    required this.hackneyPermit,
    required this.ogHut,
    required this.stateCarriagePermit,
    required this.heavyDutyPermit,
    required this.truckTrailerPermit,
    required this.localGovtPermit,
    required this.midYearPermit,
    required this.extra,
    required this.createdAt,
    required this.updatedAt,
    required this.details,
    required this.model,
    required this.category,
    required this.car,
  });

  final int id;
  final String userId;
  final String carYearId;
  final dynamic plateNumber;
  final dynamic mileage;
  final String chasisNumber;
  final String engineNumber;
  final DateTime? dateOfPurchase;
  final dynamic vehicleLicense;
  final dynamic roadWorthiness;
  final dynamic thirdPartyInsurance;
  final dynamic hackneyPermit;
  final dynamic ogHut;
  final dynamic stateCarriagePermit;
  final dynamic heavyDutyPermit;
  final dynamic truckTrailerPermit;
  final dynamic localGovtPermit;
  final dynamic midYearPermit;
  final dynamic extra;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Details? details;
  final Model? model;
  final CategoryCar? category;
  final Car? car;

  factory GetCarz.fromJson(Map<String, dynamic> json) {
    return GetCarz(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? "",
      carYearId: json["car_year_id"] ?? "",
      plateNumber: json["plate_number"],
      mileage: json["mileage"],
      chasisNumber: json["chasis_number"] ?? "",
      engineNumber: json["engine_number"] ?? "",
      dateOfPurchase: DateTime.tryParse(json["date_of_purchase"] ?? ""),
      vehicleLicense: json["vehicle_license"],
      roadWorthiness: json["road_worthiness"],
      thirdPartyInsurance: json["third_party_insurance"],
      hackneyPermit: json["hackney_permit"],
      ogHut: json["og_hut"],
      stateCarriagePermit: json["state_carriage_permit"],
      heavyDutyPermit: json["heavy_duty_permit"],
      truckTrailerPermit: json["truck_trailer_permit"],
      localGovtPermit: json["local_govt_permit"],
      midYearPermit: json["mid_year_permit"],
      extra: json["extra"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      details:
          json["details"] == null ? null : Details.fromJson(json["details"]),
      model: json["model"] == null ? null : Model.fromJson(json["model"]),
      category: json["category"] == null
          ? null
          : CategoryCar.fromJson(json["category"]),
      car: json["car"] == null ? null : Car.fromJson(json["car"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "car_year_id": carYearId,
        "plate_number": plateNumber,
        "mileage": mileage,
        "chasis_number": chasisNumber,
        "engine_number": engineNumber,
        "date_of_purchase": dateOfPurchase?.toIso8601String(),
        "vehicle_license": vehicleLicense,
        "road_worthiness": roadWorthiness,
        "third_party_insurance": thirdPartyInsurance,
        "hackney_permit": hackneyPermit,
        "og_hut": ogHut,
        "state_carriage_permit": stateCarriagePermit,
        "heavy_duty_permit": heavyDutyPermit,
        "truck_trailer_permit": truckTrailerPermit,
        "local_govt_permit": localGovtPermit,
        "mid_year_permit": midYearPermit,
        "extra": extra,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "details": details?.toJson(),
        "model": model?.toJson(),
        "category": category?.toJson(),
        "car": car?.toJson(),
      };
}

class Car {
  Car({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.others,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String icon;
  final dynamic description;
  final dynamic others;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      icon: json["icon"] ?? "",
      description: json["description"],
      others: json["others"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
      };
}

class CategoryCar {
  CategoryCar({
    required this.id,
    required this.carId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String carId;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CategoryCar.fromJson(Map<String, dynamic> json) {
    return CategoryCar(
      id: json["id"] ?? "",
      carId: json["car_id"] ?? "",
      name: json["name"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_id": carId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Details {
  Details({
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

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
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

class Model {
  Model({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.others,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String categoryId;
  final String name;
  final dynamic others;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json["id"] ?? "",
      categoryId: json["category_id"] ?? "",
      name: json["name"] ?? "",
      others: json["others"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "others": others,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class GetProfileModel {
  GetProfileModel({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.preferredName,
    required this.phone,
    required this.email,
    required this.image,
    required this.stage,
    required this.emailVerifiedAt,
    required this.dob,
    required this.gender,
    required this.address1,
    required this.address2,
    required this.country,
    required this.state,
    required this.lga,
    required this.landmark,
    required this.postalcode,
    required this.currency,
    required this.resetToken,
    required this.verificationTokenCreatedAt,
    required this.resetTokenCreatedAt,
    required this.referralCode,
    required this.offersUpdate,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? uuid;
  final String? firstName;
  final String? lastName;
  final String? preferredName;
  final String? phone;
  final String? email;
  final String? image;
  final int? stage;
  final DateTime? emailVerifiedAt;
  final dynamic dob;
  final dynamic gender;
  final dynamic address1;
  final dynamic address2;
  final dynamic country;
  final dynamic state;
  final dynamic lga;
  final dynamic landmark;
  final dynamic postalcode;
  final String? currency;
  final String? resetToken;
  final DateTime? verificationTokenCreatedAt;
  final DateTime? resetTokenCreatedAt;
  final String? referralCode;
  final int? offersUpdate;
  final dynamic rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      uuid: json["uuid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      preferredName: json["preferred_name"],
      phone: json["phone"],
      email: json["email"],
      image: json["image"],
      stage: json["stage"],
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      dob: json["dob"],
      gender: json["gender"],
      address1: json["address1"],
      address2: json["address2"],
      country: json["country"],
      state: json["state"],
      lga: json["lga"],
      landmark: json["landmark"],
      postalcode: json["postalcode"],
      currency: json["currency"],
      resetToken: json["reset_token"],
      verificationTokenCreatedAt:
          DateTime.tryParse(json["verification_token_created_at"] ?? ""),
      resetTokenCreatedAt:
          DateTime.tryParse(json["reset_token_created_at"] ?? ""),
      referralCode: json["referral_code"],
      offersUpdate: json["offers_update"],
      rememberToken: json["remember_token"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
