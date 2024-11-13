import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/data/flyer_dummy_data.dart';
import 'package:tech_gate/provider/auth_provider.dart'; // Update the import to auth_provider
import 'package:tech_gate/widgets/flyer_slider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the auth state from the provider
    final authState = ref.watch(authNotifierProvider);

    return ListView(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Image.asset('assets/barcode.png'),
            ),
          ),
        ),
        // Display the user information based on authentication state
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: authState.when(
            initial: () {
              return const Text(
                "Please log in",
                style: TextStyle(fontSize: 18),
              );
            },
            authenticated: (user) {
              return Text(
                "Pershendetje ${user.firstName}", // Display the user's first name
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              );
            },
            loading: () => const Center(
                child: CircularProgressIndicator()), // Show loading indicator
            error: (error) => Text('Error: $error'), // Handle error
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(35),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Porosit prej shpis ",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.white,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 35,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/2.jpg',
              fit: BoxFit.fill,
              width: 150,
              height: 250,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Fletushkat",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        FlyerSlider(flyers: flyers),
        const SizedBox(height: 20)
      ],
    );
  }
}
