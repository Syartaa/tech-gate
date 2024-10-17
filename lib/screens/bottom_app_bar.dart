import 'package:flutter/material.dart';
import 'package:tech_gate/screens/cart_screen.dart';
import 'package:tech_gate/screens/home_screen.dart';
import 'package:tech_gate/screens/loaction_screen.dart';
import 'package:tech_gate/screens/profile_screen.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class BottomAppBars extends StatefulWidget {
  const BottomAppBars({super.key});

  @override
  State<BottomAppBars> createState() => _BottomAppBarsState();
}

class _BottomAppBarsState extends State<BottomAppBars> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    LoactionScreen(),
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
      //backgroundColor: const Color.fromARGB(255, 255, 253, 253),
      appBar: CustomAppBar(),
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected screen
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF03222C), // Dark teal background
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
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
                Theme.of(context).colorScheme.secondary, // Red for selected tab
            onTap: _onItemTapped,
            backgroundColor:
                Theme.of(context).colorScheme.primary, // Dark teal background
            elevation: 0, // No elevation since we use custom shadow
          ),
        ),
      ),
    );
  }
}
