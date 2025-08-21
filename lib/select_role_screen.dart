// import 'package:flutter/material.dart';
// import 'package:blood_link/donor_screen.dart';
// import 'package:blood_link/recipient_screen.dart';

// class SelectRoleScreen extends StatelessWidget {
//   const SelectRoleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFEE8E8), Color(0xFFFFFFFF)],
//           ),
//         ),
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               expandedHeight: 120.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 titlePadding: const EdgeInsets.only(bottom: 20.0),
//                 title: const Text(
//                   'Select Role',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2C3E50),
//                   ),
//                 ),
//               ),
//             ),
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 24.0,
//                 vertical: 20.0,
//               ),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate([
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: RoleCard(
//                       icon: Icons.person,
//                       iconColor: const Color(0xFFE55B5B),
//                       iconBackground: const Color(0xFFE0F2F7),
//                       title: 'Donor',
//                       onTap: () {
//                         print('Donor selected');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const DonorScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   SizedBox(
//                     width: double.infinity,
//                     child: RoleCard(
//                       icon: Icons.person,
//                       iconColor: const Color(0xFF2C3E50),
//                       iconBackground: const Color(0xFFFEE8E8),
//                       title: 'Recipient',
//                       onTap: () {
//                         print('Recipient selected');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const RecipientScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   SizedBox(
//                     width: double.infinity,
//                     child: RoleCard(
//                       icon: Icons.local_hospital,
//                       iconColor: const Color(0xFF2C3E50),
//                       iconBackground: const Color(0xFFE8F5E9),
//                       title: 'Hospital Admin',
//                       onTap: () {
//                         print('Hospital Admin selected');
//                       },
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoleCard extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final Color iconBackground;
//   final String title;
//   final VoidCallback onTap;

//   const RoleCard({
//     super.key,
//     required this.icon,
//     required this.iconColor,
//     required this.iconBackground,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 3,
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.white.withOpacity(0.95),
//               Colors.white.withOpacity(0.85),
//             ],
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: iconBackground,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Icon(icon, size: 48, color: iconColor),
//             ),
//             const SizedBox(width: 25),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF2C3E50),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
