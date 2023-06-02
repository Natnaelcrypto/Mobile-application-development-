class Farm {
  late String userID;
  late String farmName;
  late String expirationDate;
  late String itemName;
  late String dosage;
  late String instructions;
  late String id_;
  late String brand;
  late String type;
  late bool isfeed;
  late bool ismedication;
  late String quantity;

  Farm({
    required this.userID,
    required this.farmName,
    required this.id_,
    required this.expirationDate,
    required this.itemName,
    required this.dosage,
    required this.instructions,
    required this.isfeed,
    required this.ismedication,
    required this.quantity,
    required this.brand,
    required this.type,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
        userID: json['userID'],
        farmName: json['farmName'],
        expirationDate: json['expirationDate'],
        itemName: json['itemName'],
        dosage: json['dosage'],
        instructions: json['instructions'],
        isfeed: json['isfeed'],
        ismedication: json['ismedication'],
        quantity: json['quantity'],
        brand: json['brand'],
        type: json['type'],
        id_: json['_id']);
  }

  Map<String, dynamic> toMap() => {
        'userID': userID,
        'farmName': farmName,
        'expirationDate': expirationDate,
        'itemName': itemName,
        'dosage': dosage,
        'instructions': instructions,
        'FarmId': id_,
        'brand': brand,
        'type': type,
        'isfeed': isfeed ? 1 : 0,
        'ismedication': ismedication ? 1 : 0,
        'quantity': quantity,
      };
}
