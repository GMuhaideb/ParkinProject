// ignore_for_file: public_member_api_docs, sort_constructors_first
class ParkingAreaModel {
  final String id;
  final String name;
  final int number;
  final String location;
  ParkingAreaModel({
    required this.id,
    required this.name,
    required this.number,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'number': number,
      'location': location,
    };
  }

  factory ParkingAreaModel.fromJson(Map<String, dynamic> map) {
    return ParkingAreaModel(
      id: map['id'] as String,
      name: map['name'] as String,
      number: map['number'] as int,
      location: map['location'] as String,
    );
  }

  @override
  bool operator ==(covariant ParkingAreaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.number == number &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ number.hashCode ^ location.hashCode;
  }
}
