import 'list_book.dart';
import 'package:flutter/material.dart';
import 'api_servis.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Buku',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BooksListScreen(),
    );
  }
}