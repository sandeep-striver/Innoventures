import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Blood Donation Camp',
      'body':
          'Join us for a blood donation camp on 15th June at City Hospital.',
    },
    {
      'title': 'Urgent Blood Requirement',
      'body':
          'A+ blood required urgently at Apollo Clinic. Contact: 9876543210',
    },
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.red),
              title: Text(notification['title'] ?? ''),
              subtitle: Text(notification['body'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
