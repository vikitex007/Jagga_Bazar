import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            './assets/images/jagg.png',
            height: 40, // Adjust the size of the logo
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "This is dashboard",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             Icon(Icons.location_on, color: Colors.blue),
//             SizedBox(width: 5),
//             Text(
//               'Kathmandu, Nepal',
//               style: TextStyle(color: Colors.black, fontSize: 16),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications, color: Colors.blue),
//             onPressed: () {},
//           ),
//           CircleAvatar(
//             backgroundColor: Colors.grey[300],
//             child: Icon(Icons.person, color: Colors.white),
//           ),
//           SizedBox(width: 10),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hey, Sachin!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "Let's start exploring",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Land, Apartment, etc',
//                 prefixIcon: Icon(Icons.search),
//                 suffixIcon: Icon(Icons.mic),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildCategoryChip('All', true),
//                 _buildCategoryChip('Jagga', false),
//                 _buildCategoryChip('Apartment', false),
//
//               ],
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Black Friday Sale!',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'All discount up to 60%',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                   Icon(Icons.arrow_forward, color: Colors.blue),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Featured Estates',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'view all',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//             // Add a ListView or GridView here for featured estates
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
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
//         showUnselectedLabels: true,
//       ),
//     );
//   }
//
//   Widget _buildCategoryChip(String label, bool isSelected) {
//     return ChoiceChip(
//       label: Text(label),
//       selected: isSelected,
//       selectedColor: Colors.blue,
//       backgroundColor: Colors.grey[200],
//       labelStyle: TextStyle(
//         color: isSelected ? Colors.white : Colors.black,
//         fontWeight: FontWeight.bold,
//       ),
//       onSelected: (selected) {},
//     );
//   }
// }
