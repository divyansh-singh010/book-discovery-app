import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import '../screens/book_detail_screen.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true; 
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchBooks();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        fetchBooks();
      }
    });
  }

  Future<void> fetchBooks() async {
    setState(() => isLoading = true);
    try {
      final newBooks = await ApiService().fetchBooks(page);
      setState(() {
        books.addAll(newBooks);
        page++;
        if (newBooks.isEmpty) {
          hasMore = false;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Unable to fetch books.')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Discovery'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: books.isEmpty && isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: books.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < books.length) {
                  final book = books[index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          book.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.book),
                        ),
                      ),
                      title: Text(
                        book.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Author: ${book.authors.map((author) => author.name).join(", ")}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Download Count: ${book.downloadCount}',
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
