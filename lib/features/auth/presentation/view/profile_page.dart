import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

import '../view_model/profile/profile_bloc.dart';
import '../view_model/profile/profile_event.dart';
import '../view_model/profile/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileBloc.add(GetProfileEvent());  // Fetch profile when page loads
    });

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is ProfileUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update profile: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileUpdating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.user;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.fullName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text('@${user.username}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.phone, user.phone),
                  _buildInfoRow(Icons.location_on, user.location),
                  _buildInfoRow(Icons.calendar_today, 'Joined: January 2025'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _showEditProfileDialog(context, user),
                    child: const Text("Edit Profile"),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle logout logic
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Logout"),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: Text("Unexpected state."));
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, AuthEntity user) {
    final fullNameController = TextEditingController(text: user.fullName);
    final phoneController = TextEditingController(text: user.phone);
    final locationController = TextEditingController(text: user.location);
    final usernameController = TextEditingController(text: user.username);
    final passwordController = TextEditingController();  // Optional

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "New Password (optional)"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedUser = AuthEntity(
                  userId: user.userId,
                  fullName: fullNameController.text,
                  phone: phoneController.text,
                  location: locationController.text,
                  username: usernameController.text,
                  password: passwordController.text.isNotEmpty ? passwordController.text : user.password,
                  image: user.image,  // Keep existing image
                );

                context.read<ProfileBloc>().add(UpdateProfileEvent(updatedUser));
                Navigator.pop(context);  // Close dialog
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
