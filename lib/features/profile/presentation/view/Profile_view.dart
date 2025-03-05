import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/view_model/home_cubit.dart';



class ProfileView extends StatelessWidget {
  const ProfileView({super.key});


  void _confirmLogout(BuildContext context) {
    final homeCubit = context.read<HomeCubit>(); // Safe access
    print("Confirm Logout Dialog Shown"); // ✅ Debug

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              print("Logout cancelled"); // ✅ Debug
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print("Logout confirmed"); // ✅ Debug
              Navigator.of(context).pop();
              homeCubit.logout(context);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Profile Picture
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'), // Change with actual user image
            ),
          ),
          const SizedBox(height: 20),

          // User Name
          const Text(
            'Sachin Shrestha', // Replace with user name
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          // Email
          const Text(
            'sachin07', // Replace with actual email
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // User Details
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.blue),
            title: const Text('+977 9810119909'),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.blue),
            title: const Text('Kalanki kathmandu'),
          ),
          // ListTile(
          //   leading: const Icon(Icons.calendar_today, color: Colors.blue),
          //   title: const Text('Joined: January 2025'),
          // ),

          const SizedBox(height: 20),

          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            // child: ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const EditProfileView()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     padding: const EdgeInsets.symmetric(vertical: 12),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: const Text(
            //     'Edit Profile',
            //     style: TextStyle(fontSize: 18, color: Colors.white),
            //   ),
            // ),
          ),

          const SizedBox(height: 10),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _confirmLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data (Replace with actual user data retrieval logic)
    _nameController.text = "Sachin Shrestha";
    _emailController.text = "sachin007";
    _phoneController.text = "9810119909";
    _locationController.text = "Kathmandu,Nepal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(35, 50, 60, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),

              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'), // Replace with user's image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle profile picture update
                        },
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Full Name Field
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Full Name', Icons.person),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 15),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Email', Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
              ),
              const SizedBox(height: 15),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration('Phone Number', Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
              ),
              const SizedBox(height: 15),

              // Location Field
              TextFormField(
                controller: _locationController,
                decoration: _inputDecoration('Location', Icons.location_on),
                validator: (value) => value!.isEmpty ? 'Enter your location' : null,
              ),
              const SizedBox(height: 25),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save user changes (Replace with API call)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully!')),
                      );
                      Navigator.pop(context); // Go back to profile page
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Input Decoration
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
