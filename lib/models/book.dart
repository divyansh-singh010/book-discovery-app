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
    // Safely handle the authors list, defaulting to an empty list if null
    List<Author> authorsList = json['authors'] != null
        ? (json['authors'] as List)
            .map((authorJson) => Author.fromJson(authorJson))
            .toList()
        : [];

    // Safely handle the formats field, defaulting to an empty map if null
    Map<String, String> formatsMap = json['formats'] != null
        ? Map<String, String>.from(json['formats'])
        : {};

    // Safely handle the imageUrl, using a default value if the key is missing
    String imageUrl = formatsMap['image/jpeg'] ?? 'https://default-image-url.com';

    // Safely handle nullable fields like subjects, languages, and downloadCount
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: authorsList,
      formats: formatsMap,
      imageUrl: imageUrl,
      subjects: List<String>.from(json['subjects'] ?? []), // Default to empty list if null
      languages: List<String>.from(json['languages'] ?? []), // Default to empty list if null
      downloadCount: json['download_count'] != null
          ? json['download_count'] as int
          : 0, // Default to 0 if null
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
