import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  String _gender = 'Male'; // Default gender

  void _signup() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signing up as $email')),
      );

      // Add your signup logic here (e.g., API call)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.secondary, // Dark background color
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/logo.png', // Use the same logo from the login screen
                        height: 60,
                      ),
                      const SizedBox(height: 10),

                      // Title
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // First Name Field
                      _buildInputField(
                        controller: _firstNameController,
                        label: 'First Name',
                      ),
                      const SizedBox(height: 16.0),

                      // Last Name Field
                      _buildInputField(
                        controller: _lastNameController,
                        label: 'Last Name',
                      ),
                      const SizedBox(height: 16.0),

                      // Email Field
                      _buildInputField(
                        controller: _emailController,
                        label: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Birthday Field
                      _buildInputField(
                        controller: _birthdayController,
                        label: 'Birthday (DD/MM/YYYY)',
                      ),
                      const SizedBox(height: 16.0),

                      // Phone Number Field
                      _buildInputField(
                        controller: _phoneNumberController,
                        label: 'Phone Number',
                      ),
                      const SizedBox(height: 16.0),

                      // Gender Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Gender:',
                            style: TextStyle(color: Colors.black),
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                                activeColor: const Color(0xFFEC1D3B),
                              ),
                              const Text('Male',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                                activeColor: const Color(0xFFEC1D3B),
                              ),
                              const Text('Female',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // City Field
                      _buildInputField(
                        controller: _cityController,
                        label: 'City',
                      ),
                      const SizedBox(height: 16.0),

                      // Postal Code Field
                      _buildInputField(
                        controller: _postalCodeController,
                        label: 'Postal Code',
                      ),
                      const SizedBox(height: 16.0),

                      // Password Field
                      _buildInputField(
                        controller: _passwordController,
                        label: 'Password',
                        isPassword: true,
                      ),
                      const SizedBox(height: 16.0),

                      // Confirm Password Field
                      _buildInputField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        isPassword: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),

                      // Signup Button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFEC1D3B), // Red button color
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Navigate to Login
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context), // Go back to login
                        child: Text(
                          "Already have an account? Login",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEC1D3B), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 1.5),
        ),
      ),
      validator: validator,
    );
  }
}
