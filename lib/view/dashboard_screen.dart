// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _pages = [
//     const HomePage(),
//     const SearchPage(),
//     const FavoritesPage(),
//     const ProfilePage(),
//   ];
//
//   final List<String> _titles = [
//     "Home",
//     "Search",
//     "Favorites",
//     "Profile",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
//         title: Text(
//           _titles[_currentIndex],
//           style: const TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//       ),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Welcome to the Home Page!',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             "Here's where you'll find updates and featured content.",
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Discover New Features!',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward, color: Colors.blue),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'This is the Search Page',
//         style: TextStyle(fontSize: 18),
//       ),
//     );
//   }
// }
//
// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'This is the Favorites Page',
//         style: TextStyle(fontSize: 18),
//       ),
//     );
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'This is the Profile Page',
//         style: TextStyle(fontSize: 18),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:jaggabazar/view/bottom_navigation/profile_screen.dart';
import 'bottom_navigation/favourite_screen.dart';
import 'bottom_navigation/home_screen.dart';
import 'bottom_navigation/add_post_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    "Home",
    "Add Post",
    "Favorites",
    "Profile",
  ];

  final List<Widget> _bottomScreens = [
    const HomeScreen(),
    const AddPostScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? null : AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
      ),
      body: _bottomScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
