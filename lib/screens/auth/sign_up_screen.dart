import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../main.dart';
import 'login_screen.dart'; // Ensure this path is correct
import '../../widgets/custom_input_field.dart'; // Import the new widget

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  // Handle Sign-Up Logic
  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo_app.png',
                  width: 200,
                  height: 200,
                ),
                // const SizedBox(height: 10),

                // Title
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryColor,
                  ),
                ),
                const SizedBox(height: 40),

                // Username Field
                CustomInputField(
                  controller: _usernameController,
                  hintText: 'Username',
                  icon: Icons.person,
                  validator: (value) => value!.isEmpty ? 'Username cannot be empty' : null,
                ),
                const SizedBox(height: 20),

                // Email Field
                CustomInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  validator: (value) => value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 20),

                // Password Field
                CustomInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                CustomInputField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 40),

                // Sign Up Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.secondaryColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(
                            color: AppConstants.whiteColor,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.whiteColor,
                          ),
                        ),
                ),
                const SizedBox(height: 40),

                // Back to Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: AppConstants.greyColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: AppConstants.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
