import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spendsense/authentication/login_screen.dart';
import 'package:spendsense/models/user_details.dart';
import 'package:spendsense/presentation/category_management_screen.dart';
import 'package:spendsense/services/firestore_service.dart';
import 'package:spendsense/utils/appconstant.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  // Dialog to edit user profile
  void _showEditProfileDialog(UserDetails userDetails) {
    final firstNameController = TextEditingController(
      text: userDetails.firstName,
    );
    final lastNameController = TextEditingController(
      text: userDetails.lastName,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
                autofocus: true,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firestoreService.updateUserDetails(
                    firstNameController.text.trim(),
                    lastNameController.text.trim(),
                  );
                  Navigator.pop(context);
                  Appconstant.showSnackBar(
                    context,
                    message: "Profile updated successfully!",
                  );
                  // Refresh the state to show the new name in the header
                  setState(() {});
                } catch (e) {
                  Appconstant.showSnackBar(
                    context,
                    message: "Failed to update profile",
                    isSuccess: false,
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserDetails?>(
        future: _firestoreService.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Could not load user data."));
          }
          final userDetails = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 1,
                centerTitle: false,
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: const Color(0xFF1B3253),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 20.h),
                  _buildProfileHeader(userDetails),
                  SizedBox(height: 20.h),
                  _buildSectionHeader("ACCOUNT"),
                  _buildSettingsTile(
                    icon: Icons.edit_outlined,
                    title: "Edit Profile",
                    onTap: () => _showEditProfileDialog(userDetails),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await GoogleSignIn().signOut();
                            await FirebaseAuth.instance.signOut();
                            if (mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                  _buildSettingsTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () {
                      Appconstant.showSnackBar(
                        context,
                        message: "Feature not implemented yet.",
                      );
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.category_outlined,
                    title: "Manage Categories",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CategoryManagementScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 30),
                  _buildSectionHeader("PREFERENCES"),
                  _buildSettingsTile(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.grey.shade700,
                    ),
                    title: Text("Dark Mode", style: TextStyle(fontSize: 16.sp)),
                    trailing: Switch(
                      value: false,
                      onChanged: (val) {
                        Appconstant.showSnackBar(
                          context,
                          message: "Feature not implemented yet.",
                        );
                      },
                    ),
                  ),
                  const Divider(height: 30),
                  _buildSectionHeader("LEGAL & SUPPORT"),
                  _buildSettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () {},
                  ),
                  _buildSettingsTile(
                    icon: Icons.support_agent_outlined,
                    title: "Contact Support",
                    onTap: () {},
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildProfileHeader(UserDetails userDetails) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: const Color(0xFF80C0E2).withOpacity(0.2),
            child: const Icon(Icons.person, size: 30, color: Color(0xFF1B3253)),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userDetails.firstName ?? ''} ${userDetails.lastName ?? 'User'}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B3253),
                ),
              ),
              Text(
                userDetails.email ?? "No email",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
