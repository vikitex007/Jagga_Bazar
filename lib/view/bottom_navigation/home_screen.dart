
import 'package:flutter/material.dart';
import 'package:jagga_bazar/view/bottom_navigation/profile_screen.dart';

import '../login_screen.dart';

class Property {
  final String title;
  final String location;
  final String price;
  final String imagePath;

  Property({
    required this.title,
    required this.location,
    required this.price,
    required this.imagePath,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Property> properties = [
      Property(
        title: 'Land for sale',
        location: 'Kathmandu',
        price: '\Rs1,50,00,000',
        imagePath: 'assets/post/land/land1.jpeg',
      ),
      Property(
        title: 'Serene Land',
        location: 'Pokhara',
        price: '\Rs200,000',
        imagePath: 'assets/post/land/land2.jpeg',
      ),
      Property(
        title: 'Prime Location',
        location: 'Bhaktapur',
        price: '\Rs250,000',
        imagePath: 'assets/post/land/land3.jpeg',
      ),
      Property(
        title: 'Beautiful Landscape',
        location: 'Lalitpur',
        price: '\Rs300,000',
        imagePath: 'assets/post/land/land4.jpeg',
      ),
      Property(
        title: 'Investment Opportunity',
        location: 'Chitwan',
        price: '\Rs400,000',
        imagePath: 'assets/post/land/land5.jpeg',
      ),
      Property(
        title: 'Biggest Sale',
        location: 'Hetauda',
        price: '\Rs400,000',
        imagePath: 'assets/post/land/land6.jpeg',
      ),
      Property(
        title: 'No ghata only faida',
        location: 'Chitwan',
        price: '\Rs400,000',
        imagePath: 'assets/post/land/land7.jpeg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
        title: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo at the top-left
              Image.asset(
                'assets/images/jagg.png',
                height: 50,
                width: 50,
              ),
              // Centered Search bar
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Search here',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              // Circular avatar at the top-right\
              GestureDetector(
                onTap: () {
                  _showOptions(context);

                } ,
                child:const CircleAvatar(
                  backgroundImage:
                  AssetImage('assets/images/pp.jpeg'), // Replace with your avatar image path
                  radius: 18,
                ),
              )
            ],
          ),
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buttons row (square-shaped)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Land Button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Land'),
                  ),
                  const SizedBox(width: 30), // Add spacing between buttons
                  // Apartment Button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Apartment'),
                  ),
                  const SizedBox(width: 30),
                  // Home Button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Home'),
                  ),
                ],
              ),

// Line separator
              const Divider(
                color: Colors.grey, // Line color
                thickness: 1, // Line thickness
                indent: 10, // Left indentation
                endIndent: 10, // Right indentation
              ),


              // Row for "Land"
              const Text(
                'Popular Properties',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300, // Increase height for a larger image
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          property.imagePath,
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                          height: 200, // Make the image larger
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          property.title,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Location: ${property.location}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Price: ${property.price}',
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.green),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200, // Make the card wider
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    property.imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property.title,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      property.location,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    Text(
                                      property.price,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(
                color: Colors.grey, // Line color
                thickness: 1, // Line thickness
                indent: 10, // Left indentation
                endIndent: 10, // Right indentation
              ),
              // Row for "Apartment"
              // Inside the body of the Scaffold (for the Apartment section):
              const Text(
                'Apartment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250, // Increase height for larger apartment images
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7, // Example: 7 posts for Apartment
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/post/apart/apart${index + 1}.jpeg', // Replace with unique apartment images
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                          height: 200, // Make the image larger
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Apartment ${index + 1} Details',
                                          style: const TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Location: Some location',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Price: Rs. 100,000',
                                          style: TextStyle(fontSize: 16, color: Colors.green),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context); // Close the dialog
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200, // Make the card wider
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/post/apart/apart${index + 1}.jpeg', // Replace with unique apartment images
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Apartment ${index + 1}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),


              const Divider(
                color: Colors.grey, // Line color
                thickness: 1, // Line thickness
                indent: 10, // Left indentation
                endIndent: 10, // Right indentation
              ),

              // Row for "Home"
              // Inside the body of the Scaffold (for the Home section):
              const Text(
                'Home',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250, // Increase height for larger home images
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7, // Example: 7 posts for Home
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/post/home/home${index + 1}.jpeg', // Replace with unique home images
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                          height: 200, // Make the image larger
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Home ${index + 1} Details',
                                          style: const TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Location: Some location',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Price: Rs. 100,000',
                                          style: TextStyle(fontSize: 16, color: Colors.green),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context); // Close the dialog
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200, // Make the card wider
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/post/home/home${index + 1}.jpeg', // Replace with unique home images
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Home ${index + 1}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


void _showOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Go to Profile'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen(),)); // Close the slider
              // Navigate to the profile page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen(),));
              // Close the slider
              // Perform logout logic here
              // Example: auth.signOut();
            },
          ),
        ],
      );
    },
  );
}