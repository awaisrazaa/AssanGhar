import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../Utils/app_colors.dart';

class PDFScreen extends StatefulWidget {
  final String pdfurl;

  const PDFScreen({Key? key, required this.pdfurl}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  PDFDocument? document;


  @override
  void initState() {
    super.initState();
    InitializePdf();

  }

  void InitializePdf()async{
    document= await PDFDocument.fromURL(widget.pdfurl);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.appgreen,
        title: Text('PDF Viewer'),
      ),
      body: document!=null?PDFViewer(document: document!,

      ): Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
