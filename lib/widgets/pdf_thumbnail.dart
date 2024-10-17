import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfPageThumbnail extends StatefulWidget {
  final String pdfPath;
  final String title;

  const PdfPageThumbnail({
    super.key,
    required this.pdfPath,
    required this.title,
  });

  @override
  _PdfPageThumbnailState createState() => _PdfPageThumbnailState();
}

class _PdfPageThumbnailState extends State<PdfPageThumbnail> {
  PdfDocument? _pdfDocument;
  PdfPageImage? _pdfPageImage;
  bool _hasError = false; // To track if an error occurs during PDF loading

  @override
  void initState() {
    super.initState();
    _loadPdfPageThumbnail();
  }

  Future<void> _loadPdfPageThumbnail() async {
    try {
      // Load the PDF document from assets
      final document = await PdfDocument.openAsset(widget.pdfPath);

      // Render the first page as an image
      final page = await document.getPage(1);
      final pageImage = await page.render(
        width: page.width,
        height: page.height,
        format: PdfPageImageFormat.png,
      );

      // Close the page to free resources
      await page.close();

      if (mounted) {
        setState(() {
          _pdfDocument = document;
          _pdfPageImage = pageImage;
          _hasError = false; // No error occurred
        });
      }
    } catch (e) {
      print('Error loading PDF page: $e');
      if (mounted) {
        setState(() {
          _hasError = true; // Set error state to true
        });
      }
    }
  }

  @override
  void dispose() {
    _pdfDocument?.close(); // Close the document on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _buildContent(),
      ),
    );
  }

  // Helper method to handle the various content states (loading, error, success)
  Widget _buildContent() {
    if (_hasError) {
      return const Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        ), // Error widget
      );
    }

    if (_pdfPageImage != null) {
      return Image.memory(
        _pdfPageImage!.bytes,
        fit: BoxFit.cover,
      );
    }

    return const Center(
      child: CircularProgressIndicator(), // Loading indicator
    );
  }
}
