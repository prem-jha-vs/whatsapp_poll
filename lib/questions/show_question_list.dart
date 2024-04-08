import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void showQuestionListDialog(BuildContext context, String eventId) {
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
              content: const Text('Failed to fetch questions'),
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
            List<dynamic> questions = snapshot.data!.data['data'];

            if (questions.isEmpty) {
              return AlertDialog(
                title: const Text("Go and add the question first"),
                content: const Text('No Questions'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }

            return AlertDialog(
              title: const Text('Questions'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questions.map((question) {
                    return ListTile(
                      title: Text(question['text']),
                      subtitle: Text(
                          'Question Number: ${question['question_number']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue[400],
                            ),
                            onPressed: () {
                              // Add edit functionality here
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ),
                            onPressed: () {
                              // Add delete functionality here
                            },
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Present',
                                style: TextStyle(color: Colors.green[400]),
                              ))
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}
