import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/users.dart';
import 'package:tech_gate/provider/user_provider.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:tech_gate/widgets/profile/profile_text_field.dart';

class ChangeProfileScreen extends ConsumerStatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangeProfileScreen> createState() =>
      _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends ConsumerState<ChangeProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthdayController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;

  String _gender = 'Male';
  DateTime? _selectedBirthday;

  @override
  void initState() {
    super.initState();

    // Fetch the user data and initialize controllers with current values
    final user = ref.read(userProvider).value;
    _emailController = TextEditingController(text: user?.email ?? '');
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _birthdayController = TextEditingController(
      text: user?.birthday != null
          ? DateFormat('yyyy-MM-dd').format(user!.birthday!)
          : '',
    );
    _phoneNumberController =
        TextEditingController(text: user?.phoneNumber ?? '');
    _cityController = TextEditingController(text: user?.city ?? '');
    _postalCodeController =
        TextEditingController(text: user?.postalCode.toString() ?? '');

    _gender = user?.gender == Gender.male ? 'Male' : 'Female';
    _selectedBirthday = user?.birthday;
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedBirthday = pickedDate;
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final gender = _gender == 'Male' ? Gender.male : Gender.female;

        // Update user data in Firestore via UserProvider
        await ref.read(userProvider.notifier).updateUserProfile(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              birthday: _selectedBirthday!,
              phoneNumber: _phoneNumberController.text,
              gender: gender,
              city: _cityController.text,
              postalCode: int.parse(_postalCodeController.text),
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: userState.when(
        data: (user) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Ndrysho Profilin",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                      controller: _firstNameController,
                      labelText: "First Name"),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                      controller: _lastNameController, labelText: "Last Name"),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                    controller: _emailController,
                    labelText: "Email",
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => _selectBirthday(context),
                    child: AbsorbPointer(
                        child: ProfileTextField(
                            controller: _birthdayController,
                            labelText: "Birthday")),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Gender:',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                    controller: _cityController,
                    labelText: 'City',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProfileTextField(
                    controller: _postalCodeController,
                    labelText: 'Postal Code',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC1D3B),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error loading user: $error')),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }
}
