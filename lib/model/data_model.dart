class DataModel {
  final String img;

  const DataModel({
    required this.img,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      img: json["img"],
    );
  }
//
}

class TitleData {
  final String title;
  final String subtitle;

  const TitleData({
    required this.title,
    required this.subtitle,
  });

  factory TitleData.fromJson(Map<String, dynamic> json) {
    return TitleData(
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }
}
