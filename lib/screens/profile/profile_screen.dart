import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/user_provider.dart';
import 'package:tech_gate/screens/home_screen.dart';
import 'package:tech_gate/screens/products/order_history_screen.dart';
import 'package:tech_gate/screens/products/track_order_screen.dart';
import 'package:tech_gate/screens/profile/change_password.dart';
import 'package:tech_gate/screens/profile/change_profile.dart';
import 'package:tech_gate/screens/profile/delete_account.dart';
import 'package:tech_gate/screens/profile/gifts.dart';
import 'package:tech_gate/screens/welcome_screen.dart';
import 'package:tech_gate/widgets/profile/profile_option.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get user details from userProvider
    final userAsyncValue = ref.watch(userProvider);

    return userAsyncValue.when(
      data: (user) {
        // Extract first name, last name, and phone number from user object
        final firstName = user?.firstName ?? "First Name";
        final lastName = user?.lastName ?? "Last Name";
        final phoneNumber = user?.phoneNumber ?? "Phone number";

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$firstName $lastName",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        phoneNumber,
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(162, 255, 255, 255),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 241, 240, 237),
                    radius: 25,
                  ),
                ],
              ),
            ),
            ProfileOption(
              title: "Ndrysho profilin",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ChangeProfileScreen()),
                );
              },
            ),
            ProfileOption(
              title: "Ndrysho Fjalekalimin",
              icon: Icons.lock, // Custom icon
              onTap: () {
                // Navigate to change password screen
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
            ProfileOption(
              title: "Fshij llogarine",
              icon: Icons.no_accounts_outlined, // Custom icon
              onTap: () {
                // Navigate to delete account screen
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DeleteAccount()),
                );
              },
            ),
            ProfileOption(
              title: "Shperblimet",
              icon: Icons.card_giftcard, // Custom icon
              onTap: () {
                // Navigate to rewards screen
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Gifts()),
                );
              },
            ),
            ProfileOption(
              title: "Ç'kyçu",
              icon: Icons.logout, // Custom icon
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Blerjet kete muaj (fizike)",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "0.0 \$",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 180,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Blerjet kete muaj (online)",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "0.0 \$",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProfileOption(
              title: "Historia e blerjeve",
              icon: Icons.history, // Custom icon
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistoryScreen()));
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
