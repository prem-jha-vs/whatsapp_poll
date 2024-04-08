import 'package:dio/dio.dart';

void main() {
  // Define your API endpoint

  String baseUrl =
      "https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev";

  final String summarizedApiUrl =
      "$baseUrl/events/summarized-response?question=2";

  // Define your headers
  Map<String, dynamic> headers = {
    'businessphone': '+918860825375',
    'eventid': 'E001',
  };

  // Initialize Dio with a BaseOptions instance containing your headers
  Dio dio = Dio(BaseOptions(headers: headers));

  // Define the request payload if needed
  Map<String, dynamic> requestData = {
    // Your request data here
  };

  // Make an API call
  dio.get(summarizedApiUrl).then((response) {
    // Handle success
    print('Response: ${response.data}');
  }).catchError((error) {
    // Handle error
    print('Error: $error');
  });
}
