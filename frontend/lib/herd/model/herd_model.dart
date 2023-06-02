class Herd {
  final String farmname;
  final String herdID;
  final String age;
  final String bread;
  final List health_history;
  final List vaccination;
  final List medication;
  final List pregnancy;
  final String gender;
  final String id;

  Herd(
      {required this.farmname,
      required this.herdID,
      required this.age,
      required this.bread,
      // ignore: non_constant_identifier_names
      required this.health_history,
      required this.vaccination,
      required this.medication,
      required this.pregnancy,
      required this.gender,
      required this.id});

  factory Herd.fromJson(Map<String, dynamic> json) {
    return Herd(
        farmname: json['farmname'],
        herdID: json['herdID'],
        age: json['age'],
        bread: json['bread'],
        health_history: json['health_history'].toList(),
        vaccination: json['vaccination'].toList(),
        medication: json['medication'].toList(),
        pregnancy: json['pregnancy'].toList(),
        gender: json['gender'],
        id: json['_id']);
  }
  Map<String, dynamic> toMap() {
    return {
      "farmname": farmname,
      "herdID": herdID,
      "age": age,
      "bread": bread,
      "gender": gender,
      "Herdids": id,
    };
  }
}
