// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NekathModel {
  final String title; // Nekath name
  final DateTime time;
  final String description;
  final String? shortDate;
  final String? fullDate;
  final String? direction;
  final int? directionNo;
  NekathModel({
    required this.title,
    required this.time,
    required this.description,
    this.shortDate,
    this.fullDate,
    this.direction,
    this.directionNo,
  });

  NekathModel copyWith({
    String? title,
    DateTime? time,
    String? description,
    String? shortDate,
    String? fullDate,
    String? direction,
    int? directionNo,
  }) {
    return NekathModel(
      title: title ?? this.title,
      time: time ?? this.time,
      description: description ?? this.description,
      shortDate: shortDate ?? this.shortDate,
      fullDate: fullDate ?? this.fullDate,
      direction: direction ?? this.direction,
      directionNo: directionNo ?? this.directionNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'time': time.millisecondsSinceEpoch,
      'description': description,
      'shortDate': shortDate,
      'fullDate': fullDate,
      'direction': direction,
      'directionNo': directionNo,
    };
  }

  factory NekathModel.fromMap(Map<String, dynamic> map) {
    return NekathModel(
      title: map['title'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      description: map['description'] as String,
      shortDate: map['shortDate'] != null ? map['shortDate'] as String : null,
      fullDate: map['fullDate'] != null ? map['fullDate'] as String : null,
      direction: map['direction'] != null ? map['direction'] as String : null,
      directionNo: map['directionNo'] != null ? map['directionNo'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NekathModel.fromJson(String source) =>
      NekathModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NekathModel(title: $title, time: $time, description: $description, shortDate: $shortDate, fullDate: $fullDate, direction: $direction, directionNo: $directionNo)';
  }

  @override
  bool operator ==(covariant NekathModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.time == time &&
        other.description == description &&
        other.shortDate == shortDate &&
        other.fullDate == fullDate &&
        other.direction == direction &&
        other.directionNo == directionNo;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        time.hashCode ^
        description.hashCode ^
        shortDate.hashCode ^
        fullDate.hashCode ^
        direction.hashCode ^
        directionNo.hashCode;
  }
}
