// // ignore_for_file: library_private_types_in_public_api

// import 'package:auth/controller/profile_provider.dart';
// import 'package:auth/view/privacy_policy.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final settingProvider =
//         Provider.of<ProfileProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           ListTile(
//             title: const Text('Notifications'),
//             trailing: Switch(
//               value: settingProvider.notificationsEnabled,
//               onChanged: (value) {
//                 settingProvider.notificationsEnabled = value;
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Dark Mode'),
//             trailing: Switch(
//               value: settingProvider.darkModeEnabled,
//               onChanged: (value) {
//                 settingProvider.darkModeEnabled = value;
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Change Password'),
//             onTap: () {},
//           ),
//           ListTile(
//             title: const Text('Privacy Policy'),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const PrivacyPolicyPage()));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
