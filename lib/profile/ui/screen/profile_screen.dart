import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../widgets/profile_image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Header
            Row(
              children: [
                const ProfileImagePicker(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'email@example.com',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // My Orders
            _buildListTile(
              title: 'My orders',
              subtitle: 'Already have 12 orders',
              onTap: () {
                // Navigate to orders screen
              },
            ),

            // Shipping Addresses
            _buildListTile(
              title: 'Shipping addresses',
              subtitle: '3 addresses',
              onTap: () {
                // Navigate to addresses screen
              },
            ),

            // Payment methods
            _buildListTile(
              title: 'Payment methods',
              subtitle: 'Visa **34',
              onTap: () {
                // Navigate to payment methods screen
              },
            ),

            // Promocodes
            _buildListTile(
              title: 'Promocodes',
              subtitle: 'You have special promocodes',
              onTap: () {
                // Navigate to promocodes screen
              },
            ),

            // My reviews
            _buildListTile(
              title: 'My reviews',
              subtitle: 'Reviews for 4 items',
              onTap: () {
                // Navigate to reviews screen
              },
            ),

            // Settings
            _buildListTile(
              title: 'Settings',
              subtitle: 'Notifications, password',
              onTap: () {
                // Navigate to settings screen
              },
            ),

            const SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 11,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}