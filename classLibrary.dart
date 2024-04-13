import 'dart:convert';

// Interface for items in the library
abstract class MediaItem {
  String get title;
  void display();
}

// Base class for all items in the library
class Book implements MediaItem {
  final String title;
  final String author;
  final int pages;

  Book({required this.title, required this.author, required this.pages});

  @override
  void display() {
    print('Book: $title, Author: $author, Pages: $pages');
  }
}

// Inherits from Book and overrides the display method
class SpecialEditionBook extends Book {
  final String specialFeature;

  SpecialEditionBook({
    required String title,
    required String author,
    required int pages,
    required this.specialFeature,
  }) : super(title: title, author: author, pages: pages);

  @override
  void display() {
    super.display();
    print('Special Feature: $specialFeature');
  }
}

// A class for managing library items
class Library {
  List<MediaItem> items = [];

  // Simulate file loading with a JSON string (this would typically be read from a file)
  void loadItems(String jsonString) {
    var jsonData = jsonDecode(jsonString) as List<dynamic>;
    for (var item in jsonData) {
      switch (item['type']) {
        case 'book':
          items.add(Book(title: item['title'], author: item['author'], pages: item['pages']));
          break;
        case 'specialEditionBook':
          items.add(SpecialEditionBook(
            title: item['title'],
            author: item['author'],
            pages: item['pages'],
            specialFeature: item['specialFeature']
          ));
          break;
      }
    }
  }

  void displayItems() {
    for (var item in items) {
      item.display();
    }
  }
}

void main() {
  // Simulating reading from a file.
  String dataFromJson = '''
    [
      {"type": "book", "title": "The Lord of the Rings", "author": "J.R.R. Tolkien", "pages": 1178},
      {"type": "specialEditionBook", "title": "The Hobbit", "author": "J.R.R. Tolkien", "pages": 310, "specialFeature": "Illustrated Edition"}
    ]
  ''';

  Library library = Library();
  library.loadItems(dataFromJson);
  library.displayItems();
}
