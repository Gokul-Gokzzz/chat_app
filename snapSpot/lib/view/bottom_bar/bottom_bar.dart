// import 'package:auth/controller/bottom_bar_provider.dart';
// import 'package:auth/view/home_screen.dart';
// import 'package:auth/view/profile_page.dart';
// import 'package:auth/view/search_seen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<BottomBar> {
//   List screens = [
//     const HomeScreen(),
//     const SearchScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<BottomBarProvider>(
//           builder: (context, value, child) => screens[value.selectedIndex]),
//       bottomNavigationBar: Consumer<BottomBarProvider>(
//         builder: (context, value, child) => BottomNavigationBar(
//           currentIndex: value.selectedIndex,
//           onTap: value.navigateBottomBar,
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profil'),
//           ],
//         ),
//       ),
//     );
//   }
// }
