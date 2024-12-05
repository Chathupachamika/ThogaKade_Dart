import 'dart:io';

enum BookStatus { available, borrowed }

class Book {
  String id;
  String title;
  String author;
  String isbn;
  BookStatus status;

  Book(this.id, this.title, this.author, this.isbn, this.status);

  bool isValidISBN(String isbn) {
    return RegExp(r'^\d{13}$').hasMatch(isbn);
  }

  void updateStatus(BookStatus newStatus) {
    status = newStatus;
  }
}

class TextBook extends Book {
  String subjectArea;
  String gradeLevel;

  TextBook(
      String id,
      String title,
      String author,
      String isbn,
      BookStatus status,
      this.subjectArea,
      this.gradeLevel)
      : super(id, title, author, isbn, status);
}

class BookCollection {
  List<Book> books = [];

  String generateId() {
    return "B0${books.length + 1}".padLeft(5, '');
  }

  void addBook(Book book) {
    books.add(book);
  }

  bool removeBook(String bookId) {
    int initialLength = books.length;
    books.removeWhere((book) => book.id == bookId);
    return books.length < initialLength; // Returns true if a book was removed
  }

  List<Book> searchByTitle(String title) {
    return books.where((book) => book.title.contains(title)).toList();
  }

  List<Book> searchByAuthor(String author) {
    return books.where((book) => book.author.contains(author)).toList();
  }

  void updateBookStatus(String bookId, BookStatus newStatus) {
    for (var book in books) {
      if (book.id == bookId) {
        book.updateStatus(newStatus);
        return;
      }
    }
    print("Book with ID $bookId not found.");
  }

  void displayBooks() {
    if (books.isEmpty) {
      print("No books available.");
      return;
    }

    print('''
+----------------+-------------------------+-----------------------------+---------------+--------------+
| Book ID        | Title                   | Author                      | ISBN          | Status       |
+----------------+-------------------------+-----------------------------+---------------+--------------+''');
    for (var book in books) {
      print(
          '| ${book.id.padRight(14)} | ${book.title.padRight(23)} | ${book.author.padRight(27)} | ${book.isbn.padRight(13)} | ${book.status.name.padRight(12)} |');
    }
    print("+----------------+-------------------------+-----------------------------+---------------+--------------+");
  }
}

void main() {
  final bookCollection = BookCollection();

  while (true) {
    print("\n+---------------------------------+");
    print("|     Book Management System      |");
    print("+---------------------------------+");
    print("|                                 |");
    print("|     [1] Add Book                |");
    print("|     [2] Add TextBook            |");
    print("|     [3] Remove Book             |");
    print("|     [4] Search Book by Title    |");
    print("|     [5] Search Book by Author   |");
    print("|     [6] Update Book Status      |");
    print("|     [7] List All Books          |");
    print("|     [8] Exit                    |");
    print("|                                 |");
    print("+---------------------------------+\n");

    stdout.write("Enter an option: ");
    String? option = stdin.readLineSync();

    switch (option) {
      case '1':
        addBook(bookCollection);
        break;
      case '2':
        addTextBook(bookCollection);
        break;
      case '3':
        removeBook(bookCollection);
        break;
      case '4':
        searchBookByTitle(bookCollection);
        break;
      case '5':
        searchBookByAuthor(bookCollection);
        break;
      case '6':
        updateBookStatus(bookCollection);
        break;
      case '7':
        bookCollection.displayBooks();
        break;
      case '8':
        exit(0);
      default:
        print("Invalid option. Try again.");
    }
  }
}

void addBook(BookCollection bookCollection) {
  stdout.write("Title: ");
  String title = stdin.readLineSync()!;
  stdout.write("Author: ");
  String author = stdin.readLineSync()!;
  stdout.write("ISBN (13 digits): ");
  String isbn = stdin.readLineSync()!;
  String id = bookCollection.generateId();

  if (!RegExp(r'^\d{13}$').hasMatch(isbn)) {
    print("Invalid ISBN format.");
    return;
  }

  bookCollection.addBook(Book(id, title, author, isbn, BookStatus.available));
  print("Book added successfully!");
}

void addTextBook(BookCollection bookCollection) {
  stdout.write("Title: ");
  String title = stdin.readLineSync()!;
  stdout.write("Author: ");
  String author = stdin.readLineSync()!;
  stdout.write("ISBN (13 digits): ");
  String isbn = stdin.readLineSync()!;
  stdout.write("Subject Area: ");
  String subjectArea = stdin.readLineSync()!;
  stdout.write("Grade Level: ");
  String gradeLevel = stdin.readLineSync()!;
  String id = bookCollection.generateId();

  if (!RegExp(r'^\d{13}$').hasMatch(isbn)) {
    print("Invalid ISBN format.");
    return;
  }

  bookCollection.addBook(TextBook(
      id, title, author, isbn, BookStatus.available, subjectArea, gradeLevel));
  print("TextBook added successfully!");
}

void removeBook(BookCollection bookCollection) {
  stdout.write("Enter Book ID to remove: ");
  String bookId = stdin.readLineSync()!;
  if (bookCollection.removeBook(bookId)) {
    print("Book removed successfully!");
  } else {
    print("Book not found.");
  }
}

void searchBookByTitle(BookCollection bookCollection) {
  stdout.write("Enter title to search: ");
  String title = stdin.readLineSync()!;
  List<Book> results = bookCollection.searchByTitle(title);

  if (results.isEmpty) {
    print("No books found with title '$title'.");
  } else {
    print("Books found:");
    results.forEach((book) => print("ID: ${book.id}, Title: ${book.title}"));
  }
}

void searchBookByAuthor(BookCollection bookCollection) {
  stdout.write("Enter author to search: ");
  String author = stdin.readLineSync()!;
  List<Book> results = bookCollection.searchByAuthor(author);

  if (results.isEmpty) {
    print("No books found with author '$author'.");
  } else {
    print("Books found:");
    results.forEach((book) => print("ID: ${book.id}, Author: ${book.author}"));
  }
}

void updateBookStatus(BookCollection bookCollection) {
  stdout.write("Enter Book ID to update status: ");
  String bookId = stdin.readLineSync()!;
  stdout.write("Enter new status (available/borrowed): ");
  String statusInput = stdin.readLineSync()!.toLowerCase();

  BookStatus? newStatus = (statusInput == "available")
      ? BookStatus.available
      : (statusInput == "borrowed")
      ? BookStatus.borrowed
      : null;

  if (newStatus == null) {
    print("Invalid status.");
    return;
  }

  bookCollection.updateBookStatus(bookId, newStatus);
  print("Book status updated successfully!");
}
