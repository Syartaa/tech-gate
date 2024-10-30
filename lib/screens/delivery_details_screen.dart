import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/user_provider.dart';
import 'package:tech_gate/screens/checkout/check_out_payment.dart';
import 'package:tech_gate/widgets/product/custom_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryDetailsScreen extends ConsumerWidget {
  DeliveryDetailsScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalcodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    // Populate the controllers with user data when available
    userState.whenData((user) {
      if (user != null) {
        _addressController.text = user.city;
        _cityController.text = user.city;
        _postalcodeController.text = user.postalCode.toString();
        _phoneNumberController.text = user.phoneNumber;
        _nameController.text = '${user.firstName} ${user.lastName}';
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60), // Set custom height for AppBar
        child: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.primary, // AppBar color
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery details",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ), // Display category name
              Image.asset(
                'assets/logo.png', // Add your logo image here
                height: 30,
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30), // Bottom border rounded
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Text(
            "Delivery to",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _addressController,
                    labelText: "Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _cityController,
                    labelText: "City",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _postalcodeController,
                    labelText: "Postal Code",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    labelText: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _phoneNumberController,
                    labelText: "Phone number",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 150.0),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save delivery details
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => CheckOutPayment()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC1D3B),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm delivery details',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
