import 'package:flutter/material.dart';
import 'package:tech_gate/screens/products/cart_screen.dart';
import 'package:tech_gate/screens/home_screen.dart';
import 'package:tech_gate/screens/location_screen.dart';
import 'package:tech_gate/screens/profile/profile_screen.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class BottomAppBars extends StatefulWidget {
  const BottomAppBars({super.key});

  @override
  State<BottomAppBars> createState() => _BottomAppBarsState();
}

class _BottomAppBarsState extends State<BottomAppBars> {
  int _selectedIndex = 0;

  // List of screens managed by the bottom navigation bar
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    LocationScreen(),
    ProfileScreen(),
  ];

  // Method to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Conditionally show basket icon only on the CartScreen (index 1)
    bool showBasketIcon = _selectedIndex == 1;

    return Scaffold(
      extendBody: true, // Extend body behind the BottomNavigationBar
      appBar:
          CustomAppBar(showBasketIcon: showBasketIcon), // Pass the parameter
      body: _widgetOptions[_selectedIndex], // Display the selected screen
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Extracted BottomNavigationBar for better readability
  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, -2),
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
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
