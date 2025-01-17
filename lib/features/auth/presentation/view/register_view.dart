import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/register/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _location = TextEditingController();

  // String? _selectedLocation;
  // final List<String> _locations = ['Kathmandu', 'Jhapa', 'Dhangadi', 'Pokhara'];

  File? _selectedImage;

  final ImagePicker _imagePicker = ImagePicker();

  // Function to pick an image
  // Future<void> _pickImage() async {
  //   final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Trigger the RegisterBloc event
      context.read<RegisterBloc>().add(
        RegisterUser(
          context: context,
          fullName: _nameController.text,
          phone: _phoneController.text,
          location: _location.text,
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background1.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay for better contrast
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Foreground Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                        fontFamily: 'Montserrat Italic',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Profile Picture
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Upload image it is not null
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          radius: 50,
                          // backgroundImage: _img != null
                          //     ? FileImage(_img!)
                          //     : const AssetImage('assets/images/profile.png')
                          //         as ImageProvider,
                          backgroundImage:
                          const AssetImage('assets/images/profile.png')
                          as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Registration Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Full Name Field
                          _buildTextField(
                            controller: _nameController,
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),

                          // Phone Number Field
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),

                          // Location Dropdown
                          _buildTextField(
                            controller: _location,
                            label: 'Location',
                            hint: 'Enter your Location',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Location';
                              }
                              return null;
                            },
                          ),
                          // DropdownButtonFormField<String>(
                          //   value: _selectedLocation,
                          //   dropdownColor: Colors.black.withOpacity(0.8),
                          //   decoration: _inputDecoration('Location'),
                          //   items: _locations
                          //       .map((location) => DropdownMenuItem(
                          //     value: location,
                          //     child: Text(
                          //       location,
                          //       style: const TextStyle(color: Colors.white),
                          //     ),
                          //   ))
                          //       .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _selectedLocation = value;
                          //     });
                          //   },
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return 'Please select a location';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          const SizedBox(height: 20.0),

                          // Email Field
                          _buildTextField(
                            controller: _usernameController,
                            label: 'username',
                            hint: 'Enter your username',
                            // keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),

                          // Password Field
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),

                          // Confirm Password Field
                          // _buildTextField(
                          //   controller: _confirmPasswordController,
                          //   label: 'Confirm Password',
                          //   hint: 'Re-enter your password',
                          //   obscureText: true,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please confirm your password';
                          //     } else if (value != _passwordController.text) {
                          //       return 'Passwords do not match';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          const SizedBox(height: 25.0),

                          // Register Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _register,
                              // style: ElevatedButton.styleFrom(
                              //   backgroundColor: Colors.blue,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              // ),
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label).copyWith(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}
