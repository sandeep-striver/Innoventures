import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final String profileName = "Robin Singh Saini";
  final String profileId = "BL123456";
  final String phoneNumber = "+91 9876543210";
  final String bloodGroup = "O+";
  final List<String> donationHistory = [
    "01 Jan 2024 - PGI Chandigarh",
    "15 June 2024 - GMCH Sector 32",
  ];
  final int rewardPoints = 120;
  final String address = "123, Sector 17, Chandigarh";

  MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 16),
            Text(
              profileName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("ID: $profileId"),
            SizedBox(height: 8),
            Text("Phone: $phoneNumber"),
            SizedBox(height: 8),
            Text("Blood Group: $bloodGroup"),
            SizedBox(height: 8),
            Text("Reward Points: $rewardPoints"),
            SizedBox(height: 8),
            Text("Address: $address"),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Donation History:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: donationHistory.length,
                itemBuilder:
                    (context, index) => ListTile(
                      leading: Icon(Icons.bloodtype),
                      title: Text(donationHistory[index]),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
