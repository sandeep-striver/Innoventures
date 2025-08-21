import 'package:blood_link/appdrawer/my_profile.dart';
import 'package:blood_link/appdrawer/refer_friends.dart';
import 'package:flutter/material.dart';

// This widget represents the side navigation drawer of the UBlood app.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF8F8F8),
        child: Column(
          children: <Widget>[
            // The header of the drawer, with an improved, simplified design.
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 40,
              ), // Adjusting padding to be uniform
              color: Colors.white,
              child: Stack(
                children: [
                  // Closing arrow at the top left corner.
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black54,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // Centered logo in the header.
                  Center(
                    child: Image.asset('assets/images/newlogo.png', height: 80),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.black12),

            // The list of navigation items.
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildDrawerItem(Icons.home, 'Home', () {
                    Navigator.pop(context);
                  }, isSelected: true),
                  _buildDrawerItem(Icons.group_outlined, 'Donors NearBy', () {
                    Navigator.pop(context);
                  }),
                  _buildDrawerItem(Icons.person_outline, 'My Profile', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage()),
                    );
                  }),
                  _buildDrawerItem(Icons.list_alt, 'Requests', () {
                    Navigator.pop(context);
                  }),
                  _buildDrawerItem(Icons.share_outlined, 'Refer Friend', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReferFriendsPage(),
                      ),
                    );
                  }),
                  _buildDrawerItem(
                    Icons.history_toggle_off,
                    'Donate History',
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    Icons.local_hospital_outlined,
                    'Hospital Services',
                    () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(Icons.language_outlined, 'Languages', () {
                    Navigator.pop(context);
                  }),
                  const Divider(indent: 16, endIndent: 16, height: 20),
                  _buildDrawerItem(Icons.info_outline, 'About Us', () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A helper function to create a ListTile for each drawer item.
  Widget _buildDrawerItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isSelected = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFEEAEC) : Colors.transparent,
        border:
            isSelected
                ? const Border(
                  left: BorderSide(color: Color(0xFFC70039), width: 5),
                )
                : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFC70039) : Colors.black54,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFC70039) : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
