import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tech_gate/models/flyer.dart';
import 'package:tech_gate/screens/flyer_viewer_Screen.dart';
import 'package:tech_gate/widgets/pdf_thumbnail.dart';

class FlyerSlider extends StatelessWidget {
  final List<Flyer> flyers;

  const FlyerSlider({super.key, required this.flyers});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: flyers.map((flyer) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlyerViewer(
                  pdfPath: flyer.pdfPath,
                  title: flyer.title,
                ),
              ),
            );
          },
          child: PdfPageThumbnail(
            pdfPath: flyer.pdfPath,
            title: flyer.title,
          ),
        );
      }).toList(),
    );
  }
}
