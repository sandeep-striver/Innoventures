import 'package:flutter/material.dart';
import 'postblood.dart';

class HospitalAdminDashboard extends StatefulWidget {
  const HospitalAdminDashboard({super.key});

  @override
  _HospitalAdminDashboardState createState() => _HospitalAdminDashboardState();
}

class _HospitalAdminDashboardState extends State<HospitalAdminDashboard> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            backgroundColor: Colors.pink.shade100,
            selectedIconTheme: IconThemeData(color: Colors.pink),
            unselectedIconTheme: IconThemeData(color: Colors.black54),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.warning_amber_outlined),
                label: Text('Emergency Requests'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory),
                label: Text('Inventory Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Donor Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text('Analytics & Logs'),
              ),
            ],
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(), // disable swipe
              children: [
                EmergencyRequestsPage(),
                InventoryManagementPage(),
                DonorManagementPage(),
                AnalyticsLogsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyRequestsPage extends StatelessWidget {
  const EmergencyRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Emergency Requests"),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostBloodRequestScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text('Post New Request', style: TextStyle(fontSize: 16)),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Blood Type")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("Patient")),
                  DataColumn(label: Text("Urgency")),
                  DataColumn(label: Text("Status")),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text("A-")),
                      DataCell(Text("2")),
                      DataCell(Text("John Doe")),
                      DataCell(Text("Emergency")),
                      DataCell(Text("Pending")),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text("B+")),
                      DataCell(Text("4")),
                      DataCell(Text("Jane Smith")),
                      DataCell(Text("Urgent")),
                      DataCell(Text("Completed")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryManagementPage extends StatelessWidget {
  final List<Map<String, dynamic>> bloodStock = [
    {"type": "A+", "units": 8},
    {"type": "A−", "units": 4},
    {"type": "B+", "units": 6},
  ];

  InventoryManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Inventory Management"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Blood Type")),
            DataColumn(label: Text("Units in Stock")),
          ],
          rows:
              bloodStock.map((stock) {
                return DataRow(
                  cells: [
                    DataCell(Text(stock['type'])),
                    DataCell(Text(stock['units'].toString())),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}

class DonorManagementPage extends StatelessWidget {
  final List<Map<String, String>> donors = [
    {"name": "Alice", "blood": "O+", "lastDonation": "Jan 15"},
    {"name": "Bob", "blood": "B+", "lastDonation": "Mar 3"},
  ];

  DonorManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Donor Management"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Blood Type")),
            DataColumn(label: Text("Last Donation")),
          ],
          rows:
              donors.map((donor) {
                return DataRow(
                  cells: [
                    DataCell(Text(donor['name']!)),
                    DataCell(Text(donor['blood']!)),
                    DataCell(Text(donor['lastDonation']!)),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}

class AnalyticsLogsPage extends StatelessWidget {
  const AnalyticsLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text("Analytics & Logs"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Text("Analytics & Logs will be available in future updates."),
      ),
    );
  }
}
