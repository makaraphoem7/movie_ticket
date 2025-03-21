import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "John Doe");
  final TextEditingController _emailController = TextEditingController(text: "johndoe@email.com");
  final TextEditingController _passwordController = TextEditingController(text: "123456");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture and Name
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppConstants.secondaryColor,
                            child: Icon(Icons.person, size: 50, color: AppConstants.whiteColor),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _toggleEditMode,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppConstants.whiteColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Icon(Icons.edit, size: 22, color: AppConstants.secondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _nameController.text,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _emailController.text,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Form Fields
                CustomInputField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  icon: Icons.person,
                  readOnly: !_isEditing,
                  validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),

                CustomInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  readOnly: !_isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  readOnly: !_isEditing,
                  validator: (value) =>
                      value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 32),

                // Save / Edit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isEditing ? _saveProfile : _toggleEditMode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _isEditing ? 'Save' : 'Edit',
                      style: TextStyle(fontSize: 18, color: AppConstants.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
