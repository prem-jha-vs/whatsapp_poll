import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_app/Response/api_services.dart';
import 'package:fun_app/questions/add_question.dart';
import 'package:fun_app/questions/show_question_list.dart';
import 'package:fun_app/widgets/button.dart';
import 'package:fun_app/widgets/custome_popup_menu.dart';
import 'package:fun_app/widgets/dashboad_sidebar.dart';
import 'package:fun_app/widgets/date_picker.dart';
import 'package:fun_app/widgets/text_fied.dart';
import 'package:intl/intl.dart';

class HostDashboard extends StatefulWidget {
  const HostDashboard({Key? key}) : super(key: key);

  @override
  State<HostDashboard> createState() => _HostDashboardState();
}

class _HostDashboardState extends State<HostDashboard> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventIdController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  bool showEventList = false;
  bool showAddEvent = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true; // Initialize as true to show loading initially
  Dio dio = Dio();
  late Map<String, dynamic> data = {};
  DateTime? selectedDateTime;
  DateTime? selectedEndDateTime;
  ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  void handleCreateEventPressed() {
    setState(() {
      showAddEvent = true;
      showEventList = false;
    });
  }

  void handleViewEventsPressed() {
    setState(() {
      showEventList = true;
      showAddEvent = false;
    });
  }

  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  Future<void> getEvents() async {
    try {
      Response response = await dio.get(
        'https://hq8p5sgghg.execute-api.ap-south-1.amazonaws.com/dev/events?limit=20&offset=0',
        options: Options(
          headers: {
            'business_phone': '+918860825375',
          },
        ),
      );

      if (response.statusCode == 200) {
        //print(response.data['data']);
        setState(() {
          data = jsonDecode(response.toString());
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load QR code data');
      }
    } catch (e) {
      print('Error adding event: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.blue[200]),
        child: Row(
          children: <Widget>[
            Sidebar(
              showAddEvent: showAddEvent,
              showEventList: showEventList,
              onCreateEventPressed: handleCreateEventPressed,
              onViewEventsPressed: handleViewEventsPressed,
              phoneNumber: '+918860825375',
              userName: 'Host',
            ),
            //main Content
            Expanded(
              child: Container(
                color: Colors.blue[200],
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(color: Colors.blue[50]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  // You can set the user's profile image here
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'WhatsApp Poll',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.event,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'totalRecords', // Text to show total events
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                DropdownButton<String>(
                                  value:
                                      'All Events', // Initial value for dropdown
                                  onChanged: (String? newValue) {
                                    // Handle dropdown value change
                                  },
                                  items: <String>[
                                    'All Events',
                                    'Event 1',
                                    'Event 2',
                                    'Event 3'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Visibility(
                            visible: showEventList,
                            child: Container(
                              alignment: Alignment.topRight,
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              decoration:
                                  BoxDecoration(color: Colors.blue[150]),
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : data.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: data['data'].length,
                                          itemBuilder: (context, index) {
                                            final eventData =
                                                data['data'][index];
                                            final status =
                                                eventData['status'] == 'STARTED'
                                                    ? 'Active Now'
                                                    : 'Pending';
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue[250]),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Card(
                                                    elevation: 2,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 2),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16,
                                                                  right: 16,
                                                                  top: 8,
                                                                  bottom: 2),
                                                          child: Container(
                                                            constraints: BoxConstraints(
                                                                maxWidth: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      '${eventData['event_name'].substring(0, 1).toUpperCase()}${eventData['event_name'].substring(1)} (${eventData['_id']})',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .indigo,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 12),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      size: 12,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                      'Start: ${_formatDate(eventData['start'])}', // Format the date
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey[600],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      size: 12,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                      'End: ${_formatDate(eventData['end'])}', // Format the date
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey[600],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            // Add your publish event logic here
                                                                          },
                                                                          style:
                                                                              ButtonStyle(
                                                                            shape:
                                                                                WidgetStateProperty.all(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                side: const BorderSide(
                                                                                  color: Color.fromARGB(128, 249, 248, 248), // Border color
                                                                                  width: 2, // Border width
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            overlayColor:
                                                                                WidgetStateProperty.resolveWith<Color>(
                                                                              (Set<WidgetState> states) {
                                                                                if (states.contains(WidgetState.pressed)) {
                                                                                  return Colors.blue.withOpacity(0.3); // Color when pressed
                                                                                }
                                                                                return const Color.fromARGB(128, 249, 248, 248); // No overlay color when not pressed
                                                                              },
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            'Present',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue, // Text color
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          eventData['status'] == 'STARTED'
                                                                              ? Icons.check_circle
                                                                              : Icons.schedule,
                                                                          color: eventData['status'] == 'STARTED'
                                                                              ? Colors.green
                                                                              : Colors.orange,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 77,
                                                          right: 40,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: eventData[
                                                                          'status'] ==
                                                                      'STARTED'
                                                                  ? Colors.green
                                                                      .withOpacity(
                                                                          0.9)
                                                                  : Colors
                                                                      .orange
                                                                      .withOpacity(
                                                                          0.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Text(
                                                              status,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 8,
                                                          right: 8,
                                                          child:
                                                              PopupMenuButton<
                                                                  Widget>(
                                                            tooltip: 'menu',
                                                            offset:
                                                                const Offset(
                                                                    110, 10),
                                                            itemBuilder:
                                                                (BuildContext
                                                                    context) {
                                                              return <CustomPopupMenuItem<
                                                                  Widget>>[
                                                                CustomPopupMenuItem(
                                                                  onTap: () {
                                                                    addQuestionDialog(
                                                                        context,
                                                                        eventData[
                                                                            'event_name'],
                                                                        eventData[
                                                                            '_id']);
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                        Text(
                                                                          'Add question',
                                                                          style:
                                                                              TextStyle(color: Colors.black54),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                CustomPopupMenuItem(
                                                                  onTap: () {
                                                                    showQuestionListDialog(
                                                                        context,
                                                                        eventData[
                                                                            '_id']);
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .remove_red_eye,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                        Text(
                                                                            'View questions')
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                CustomPopupMenuItem(
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .dangerous,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                                CustomPopupMenuItem(
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                CustomPopupMenuItem(
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .stop,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ];
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text('No data available')),
                            ),
                          ),
                          Visibility(
                            visible: showAddEvent,
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 62.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                      ),
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        width: 300,
                                        child: CustomTextField(
                                          controller: eventNameController,
                                          hintText: 'Add Event Name',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Event Name is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: CustomTextField(
                                          controller: eventIdController,
                                          hintText: 'Add Event Id',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Event Id is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: DateTimePickerField(
                                          controller: startDateController,
                                          hintText:
                                              'Select Start Date and Time',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Date is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: DateTimePickerField(
                                          controller: startDateController,
                                          hintText: 'Select End Date and Time',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Date is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomFlatButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String eventId =
                                                eventIdController.text;
                                            String eventName =
                                                eventNameController.text;
                                            String startsAt =
                                                startDateController.text;
                                            String endsAt =
                                                endDateController.text;
                                            apiService.addEvent(
                                                eventId,
                                                eventName,
                                                startsAt,
                                                endsAt,
                                                context);
                                          }
                                        },
                                        text: 'Add Event',
                                        color: Colors.blue,
                                        textColor: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Visibility(
                          //     visible: true,
                          //     child: Align(
                          //       alignment: Alignment.lerp(Alignment.centerRight,
                          //           Alignment.center, 0.4)!,
                          //       child: const AdvancedAnimatedWidget(),
                          //     ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
