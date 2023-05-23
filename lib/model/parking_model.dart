class ParkingModel {
  final String name;
  final String ?id;
  final int ?count;
  final List cars;

  const ParkingModel({this.id,
    required this.name,
    required this.count,
    required this.cars,
  });

  factory ParkingModel.fromJson(Map<String, dynamic> json,String id) {
    return ParkingModel(
      name: json["name"],
      id:id,
      count: int.tryParse(json["count"].toString()),
      cars: List.of(json["cars"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
    );
  }
//
}
