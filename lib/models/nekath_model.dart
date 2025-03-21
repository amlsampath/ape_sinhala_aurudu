class NekathModel {
  final String title; // Nekath name
  final DateTime time;
  final String description;
  final String? shortDate;
  final String? fullDate;

  NekathModel({
    required this.title,
    required this.time,
    required this.description,
    this.shortDate,
    this.fullDate,
  });
}
