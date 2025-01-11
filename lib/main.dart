import 'package:flutter/material.dart';
import 'screens/book_list_screen.dart';
import 'screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Discovery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      routes: {
        '/': (context) => BookListScreen(),
        '/search': (context) => SearchPage(),
      },

      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => BookListScreen(),
      ),
    );
  }
}
