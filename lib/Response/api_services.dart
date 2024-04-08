import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> addEvent(
    String eventId,
    String eventName,
    String startsAt,
    String endsAt,
    BuildContext context,
  ) async {
    TextEditingController eventIdController = TextEditingController();
    TextEditingController eventNameController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    Dio dio = Dio();
    Map<String, dynamic> requestBody = {
      "eventID": eventId,
      "eventName": eventName,
      "startsAt": startsAt,
      "endsAt": endsAt,
    };
    print(requestBody);

    try {
      Response response = await dio.post(
        'https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev/events',
        data: requestBody,
        options: Options(
          headers: {
            'business_phone': '+918860825375',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // getEvents();

        eventIdController.clear();
        eventNameController.clear();
        startDateController.clear();
        endDateController.clear();
      } else {
        throw Exception('Failed to add event');
      }
    } catch (e) {
      print('Error adding event: $e');
      // Show an error message if the request fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add event. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
