import 'dart:convert';

class QrCodeModel {
  int offset;
  int limit;
  String message;
  String responseTime;
  int totalRecords;
  String data;

  QrCodeModel({
    required this.offset,
    required this.limit,
    required this.message,
    required this.responseTime,
    required this.totalRecords,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'limit': limit,
      'message': message,
      'responseTime': responseTime,
      'totalRecords': totalRecords,
      'data': data,
    };
  }

  factory QrCodeModel.fromJson(Map<String, dynamic> json) {
    return QrCodeModel(
      offset: json['offset'] as int,
      limit: json['limit'] as int,
      message: json['message'] as String,
      responseTime: json['responseTime'] as String,
      totalRecords: json['totalRecords'] as int,
      data: json['data'] is String
          ? json['data'] as String
          : jsonEncode(json['data']),
    );
  }

  String toJson() => json.encode(toMap());
}
