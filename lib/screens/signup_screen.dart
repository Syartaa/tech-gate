import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/user.dart';
import 'package:tech_gate/provider/user_provider.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
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
  DateTime? _selectedBirthday;

  // Method to open the DatePicker dialog
  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default date
      firstDate: DateTime(1900), // Minimum date
      lastDate: DateTime.now(), // Maximum date
    );
    if (pickedDate != null && pickedDate != _selectedBirthday) {
      setState(() {
        _selectedBirthday = pickedDate; // Store selected date
      });
    }
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final gender = _gender == 'Male' ? Gender.male : Gender.female;

        // Call the signUp method from userProvider
        await ref.read(userProvider.notifier).signUp(
              email: _emailController.text,
              password: _passwordController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              birthday:
                  _selectedBirthday!, // No need to parse from the text field
              // Parse birthday
              phoneNumber: _phoneNumberController.text,
              gender: gender,
              city: _cityController.text,
              postalCode: int.parse(_postalCodeController.text),
            );

        // Navigate back to login or another screen after successful signup
        if (context.mounted) {
          Navigator.pop(context); // Return to login screen
        }
      } catch (e) {
        // Show error if signup fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

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
                        'assets/logo.png',
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

                      // Birthday Field with DatePicker
                      GestureDetector(
                        onTap: () =>
                            _selectBirthday(context), // Open DatePicker on tap
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: _selectedBirthday != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(_selectedBirthday!)
                                  : '', // Display the selected date if available
                            ),
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Birthday',
                              hintText:
                                  'Select your birthday', // Shown when no date is selected
                              suffixIcon: const Icon(Icons.calendar_today,
                                  color: Colors.grey), // Calendar icon
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEC1D3B), width: 1.5),
                              ),
                            ),
                            validator: (value) {
                              if (_selectedBirthday == null) {
                                return 'Please select your birthday';
                              }
                              return null;
                            },
                          ),
                        ),
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
                          onPressed: userState.isLoading ? null : _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC1D3B),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: userState.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Navigate to Login
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Already have an account? Login",
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
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
      style: TextStyle(color: Colors.black),
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
            color: Theme.of(context).colorScheme.secondary,
            width: 1.5,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
