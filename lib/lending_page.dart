import 'package:blood_link/notification.dart';
import 'package:flutter/material.dart';
import 'package:blood_link/appDrawer.dart';
import 'package:blood_link/donor_screen.dart';
import 'package:blood_link/recipient_screen.dart';

// This is the main widget for the UBlood home page, now a StatefulWidget.
class UBloodHomePage extends StatefulWidget {
  const UBloodHomePage({super.key});

  @override
  State<UBloodHomePage> createState() => _UBloodHomePageState();
}

class _UBloodHomePageState extends State<UBloodHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Index 0: The main home screen content.
    _HomePageBody(),
    // Index 1: The DonorScreen.
    DonorScreen(),
    // Index 2: The RecipientScreen.
    RecipientScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar at the top of the screen.
      appBar: AppBar(
        title: const Text(
          'BloodLink',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE55B5B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppDrawer()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      // Use the body based on the selected index.
      body: _widgetOptions.elementAt(_selectedIndex),
      // The side navigation drawer.
      drawer: const AppDrawer(),
      // The Bottom Navigation Bar for main app navigation.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Donate'),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'Request',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFE55B5B),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}

// A new widget to hold the original home page body content.
class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header section with user info and ID card.
          _buildHeader(context),
          const SizedBox(height: 16),
          // The "You are now a USAVER!" card.
          _buildUsaverCard(),
          const SizedBox(height: 16),
          // The "Request for Blood" and "Donate" buttons.
          _buildActionButtons(context),
          const SizedBox(height: 16),
          // The "Critical" request card.
          _buildCriticalRequestCard(),
          const SizedBox(height: 16),
          // The row of bottom icons.
          _buildBottomIcons(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // A method to build the header section with user details.
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE55B5B), Color(0xFFC04F4F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Welcome!!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Icon(Icons.help_outline, color: Colors.white),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RobinSaini22',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'USER ID',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'A-',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Blood Group',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
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

  // A method to build the "You are now a USAVER!" card.
  Widget _buildUsaverCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Thank you for registering with us.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Donate or Request',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'for Blood\nand find Donors in Real-time.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Image.asset('assets/images/newlogo.png', width: 100, height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // A method to build the action buttons.
  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _ActionButton(
            label: 'Request for Blood',
            icon: Icons.water_drop_outlined,
            onPressed: (BuildContext buttonContext) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecipientScreen(),
                ),
              );
              // This is now redundant since the bottom nav bar handles this.
            },
          ),
          const SizedBox(width: 16),
          _ActionButton(
            label: 'Donate',
            icon: Icons.volunteer_activism_outlined,
            onPressed: (BuildContext buttonContext) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DonorScreen()),
              );
              // This is now redundant since the bottom nav bar handles this.
            },
          ),
        ],
      ),
    );
  }

  // A method to build the critical request card.
  Widget _buildCriticalRequestCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mehar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Critical',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'INRA',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('6 Units (Blood)'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Nizamabad, Telangana, India',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey.shade600,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Monday, Aug 28',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A method to build the bottom icon row.
  Widget _buildBottomIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomIcon(
            label: 'Donors Nearby',
            icon: Icons.group_outlined,
            onPressed: () {},
          ),
          _BottomIcon(
            label: 'Beneficiaries',
            icon: Icons.person_add_alt_1_outlined,
            onPressed: () {},
          ),
          _BottomIcon(
            label: 'Contribute',
            icon: Icons.payments_outlined,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// Reusable widget for the main action buttons.
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function(BuildContext context) onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: InkWell(
          onTap: () {
            onPressed(context);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Icon(icon, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable widget for the bottom icons row.
class _BottomIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _BottomIcon({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.red.shade700),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
