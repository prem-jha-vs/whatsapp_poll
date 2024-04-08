import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatelessWidget {
  final bool showAddEvent;
  final bool showEventList;
  final VoidCallback onCreateEventPressed;
  final VoidCallback onViewEventsPressed;

  // User information
  final String phoneNumber;
  final String userName; // Assuming you have a user name

  const Sidebar({
    Key? key,
    required this.showAddEvent,
    required this.showEventList,
    required this.onCreateEventPressed,
    required this.onViewEventsPressed,
    required this.phoneNumber,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'My Events',
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 50),
            SidebarButton(
              onPressed: onCreateEventPressed,
              text: 'Create Event',
              icon: Icons.add_circle_outline,
              isActive: showAddEvent,
            ),
            const SizedBox(height: 20),
            SidebarButton(
              onPressed: onViewEventsPressed,
              text: 'View Events',
              icon: Icons.event_note,
              isActive: showEventList,
            ),
            const SizedBox(height: 410),
            // User Information Card
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      // You can set the user's profile image here
                      child: Icon(
                        Icons.person_4,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(
            //   height: 50,
            // )
          ],
        ),
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool isActive;

  const SidebarButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blueAccent : Colors.grey[600],
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.blueAccent : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
