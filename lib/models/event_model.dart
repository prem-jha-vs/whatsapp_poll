class EventsModel {
  int offset;
  int limit;
  String message;
  String responseTime;
  int totalRecords;
  List<Datum> data;

  EventsModel({
    required this.offset,
    required this.limit,
    required this.message,
    required this.responseTime,
    required this.totalRecords,
    required this.data,
  });
}

class Datum {
  String id;
  String eventId;
  String businessPhone;
  String status;
  int currentQues;
  DateTime start;
  DateTime end;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.eventId,
    required this.businessPhone,
    required this.status,
    required this.currentQues,
    required this.start,
    required this.end,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
