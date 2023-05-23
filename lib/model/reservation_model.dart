// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReservationModel {
  final String? id;
  final String userId;
  final String parkingId;
  final String carType;
  final String parkingArea;
  final String numberOfHours;
  final String location;
  final String endTime;
  final String startTime;
  final bool isReserved;
  ReservationModel({
    required this.userId,
    required this.parkingId,
    this.id,
    required this.carType,
    required this.parkingArea,
    required this.numberOfHours,
    required this.isReserved,
    required this.location,
    required this.endTime,
    required this.startTime,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'carType': carType,
      'parkingArea': parkingArea,
      'numberOfHours': numberOfHours,
      'isReserved': isReserved.toString(),
      'location': location,
      'endTime': endTime,
      'startTime': startTime,
      'parkingId': parkingId,
    };
  }

  factory ReservationModel.fromJson(Map<String, dynamic> map, String id) {
    return ReservationModel(
      userId: map['userId'] as String,
      id: id,
      carType: map['carType'] as String,
      parkingArea: map['parkingArea'] as String,
      numberOfHours: map['numberOfHours'] as String,
      location: map['location'] as String,
      endTime: map['endTime'] as String,
      startTime: map['startTime'] as String,
      parkingId: map['parkingId'] as String,
      isReserved: (map['isReserved'] as String) == 'true' ? true : false,
    );
  }
}
