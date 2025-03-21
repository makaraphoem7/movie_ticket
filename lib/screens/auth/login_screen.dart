import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../routes/app_routes.dart';
import '../../main.dart';
import '../../widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));

      if (_usernameController.text == 'user' &&
          _passwordController.text == '123456') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainWrapper()),
        );
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  void _handleSocialLogin(String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged in with $platform')),
    );
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
                Image.asset('assets/images/logo.png', width: 180, height: 180),
                // const SizedBox(height: 32),

                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Login to continue", style: TextStyle(fontSize: 16, color: AppConstants.greyColor)),
                const SizedBox(height: 40),

                // Username Field
                CustomInputField(
                  controller: _usernameController,
                  hintText: 'Username',
                  icon: Icons.person,
                  validator: (value) => value!.isEmpty ? 'Username cannot be empty' : null,
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
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?", style: TextStyle(color: AppConstants.secondaryColor)),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button with loading state
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isLoading
                        ? AppConstants.secondaryColor.withOpacity(0.7) // Slightly reduced opacity
                        : AppConstants.secondaryColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5, // Add elevation for a floating button effect
                    shadowColor: Colors.black.withOpacity(0.8),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.whiteColor, // Keep the text white
                          ),
                        ),
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    Expanded(child: Divider(color: AppConstants.greyColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR", style: TextStyle(color: Colors.grey[400])),
                    ),
                    Expanded(child: Divider(color: AppConstants.greyColor)),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.g_mobiledata, "Google", () => _handleSocialLogin("Google")),
                    const SizedBox(width: 16),
                    _buildSocialButton(Icons.facebook, "Facebook", () => _handleSocialLogin("Facebook")),
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(color: AppConstants.greyColor)),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, Routes.signup),
                      child: Text("Sign Up", style: TextStyle(color: AppConstants.secondaryColor)),
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

  Widget _buildSocialButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5)], // Shadow effect
        ),
        child: Row(
          children: [
            Icon(icon, color: AppConstants.secondaryColor, size: 28),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
