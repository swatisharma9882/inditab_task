class DataModel {
  final String title;
  final String date;
  final String description;

  DataModel({
    required this.title,
    required this.date,
    required this.description,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      date: json['date'],
      description: json['description'],
    );
  }
}
