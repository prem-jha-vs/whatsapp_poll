import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fun_app/widgets/text_fied.dart';

void addQuestionDialog(
  BuildContext context,
  String eventName,
  String eventId,
) {
  TextEditingController questionController = TextEditingController();
  Dio dio = Dio();
  showDialog(
    context: context,
    builder: (context) {
      return FutureBuilder(
        future: dio.get(
          'https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev/events/questions/$eventId',
        ),
        builder: (context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to fetch existing questions'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          } else {
            List<dynamic> existingQuestions = snapshot.data!.data['data'];
            int nextQuestionNumber = existingQuestions.length + 1;

            return AlertDialog(
              title: Text('Add Question for $eventName:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: questionController,
                    hintText: 'Enter your question here',
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String questionText = questionController.text.trim();
                    if (questionText.isNotEmpty) {
                      try {
                        Map<String, dynamic> requestBody = {
                          'business_phone': '+918860825375',
                          'event_id': eventId,
                          'questions': [
                            {
                              'question_number': nextQuestionNumber,
                              'text': questionText,
                            }
                          ]
                        };

                        Response response = await dio.post(
                          'https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev/events/questions/$eventId',
                          data: requestBody,
                          options: Options(
                            contentType: 'application/json',
                          ),
                        );

                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Question added successfully'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.of(context).pop();
                        } else {
                          print(
                            'Failed to save question: ${response.statusCode}',
                          );
                        }
                      } catch (e) {
                        print('Dio error: $e');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter the question'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}
