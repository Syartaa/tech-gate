import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeSlider extends StatefulWidget {
  const WelcomeSlider({super.key});

  @override
  _WelcomeSliderState createState() => _WelcomeSliderState();
}

class _WelcomeSliderState extends State<WelcomeSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<String> imageAssets = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: imageAssets.map((asset) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 48),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: false,
            height: 600,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageAssets.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.jumpToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? const Color.fromARGB(255, 255, 68, 99)
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
