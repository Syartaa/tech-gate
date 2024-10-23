import 'package:flutter/material.dart';
import 'package:tech_gate/screens/products/cart_screen.dart';
import 'package:tech_gate/screens/home_screen.dart';
import 'package:tech_gate/screens/location_screen.dart';
import 'package:tech_gate/screens/profile_screen.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class BottomAppBars extends StatefulWidget {
  const BottomAppBars({super.key});

  @override
  State<BottomAppBars> createState() => _BottomAppBarsState();
}

class _BottomAppBarsState extends State<BottomAppBars> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    LocationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extend body behind BottomNavigationBar
      appBar: CustomAppBar(), // Your custom AppBar
      body: _widgetOptions[_selectedIndex], // Display the selected screen
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, // Background color
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -2), // Shadow above the navbar
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Blej online',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Dyqanet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              Theme.of(context).colorScheme.secondary, // Selected tab color
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent, // Avoid color conflicts
          elevation: 0, // No elevation since shadow is applied in Container
        ),
      ),
    );
  }
}
