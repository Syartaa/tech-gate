import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tech_gate/widgets/custom_appbar.dart';

class FlyerViewer extends StatefulWidget {
  final String pdfPath;
  final String title;

  const FlyerViewer({super.key, required this.pdfPath, required this.title});

  @override
  State<FlyerViewer> createState() => _FlyerViewerState();
}

class _FlyerViewerState extends State<FlyerViewer> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final ByteData data = await rootBundle.load(widget.pdfPath);
    final String tempPath = (await getTemporaryDirectory()).path;
    final File tempFile = File('$tempPath/${widget.title}.pdf');

    await tempFile.writeAsBytes(data.buffer.asUint8List());

    setState(() {
      localPath = tempFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: localPath != null
          ? PDFView(
              filePath: localPath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageSnap: true,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('Page $page: ${error.toString()}');
              },
            )
          : const Center(
              child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
