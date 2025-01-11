class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final Map<String, String> formats;
  final String imageUrl;
  final List<String> subjects;
  final List<String> languages;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.formats,
    required this.imageUrl,
    required this.subjects,
    required this.languages,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<Author> authorsList = json['authors'] != null
        ? (json['authors'] as List)
            .map((authorJson) => Author.fromJson(authorJson))
            .toList()
        : [];

    Map<String, String> formatsMap = json['formats'] != null
        ? Map<String, String>.from(json['formats'])
        : {};

    String imageUrl = formatsMap['image/jpeg'] ?? 'https://default-image-url.com';

    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: authorsList,
      formats: formatsMap,
      imageUrl: imageUrl,
      subjects: List<String>.from(json['subjects'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      downloadCount: json['download_count'] != null
          ? json['download_count'] as int
          : 0, 
    );
  }
}

class Author {
  final String name;
  final int birthYear;
  final int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] as String,
      birthYear: json['birth_year'] as int? ?? 0,
      deathYear: json['death_year'] as int? ?? 0, 
    );
  }
}
