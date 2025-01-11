import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  final String baseUrl = 'https://gutendex.com/books/';

  Future<List<Book>> fetchBooks(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?search=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to search books');
    }
  }
}
