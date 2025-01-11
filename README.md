# Book Discovery App

A simple Flutter app that allows users to discover books, view their details, and search for books by title or author. The app fetches book data from the [Gutendex API](https://gutendex.com/books/).

## Features

### 1. **Book List Screen:**

- Displays a list of books with their titles, authors, and cover images.
- Supports infinite scrolling with pagination. More books are loaded as the user scrolls to the bottom.

### 2. **Book Detail Screen:**

- Displays detailed information about a selected book, including:
  - Title
  - Authors
  - Subjects
  - Languages
  - Download Count
- Shows a larger version of the book cover image.

### 3. **Search Feature:**

- Users can search for books by title or author.
- Displays search results with basic details.
- Users can tap on a search result to view more details about the book.

## Requirements

- Flutter (latest stable version)
- Gutendex API for fetching book data

## Setup

1. **Clone the repository:**
    ```bash
    git clone https://github.com/divyansh-singh010/book-discovery-app.git
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

## File Structure

    lib/
    ├── models/
    │   └── book.dart           # Contains the Book and Author model classes
    ├── screens/
    │   └── book_list_screen.dart    # Displays the list of books with pagination
    │   └── book_detail_screen.dart  # Displays details of a selected book
    │   └── search_page.dart         # Provides search functionality for books
    ├── services/
    │   └── api_service.dart        # Makes HTTP requests to the Gutendex API
    └── main.dart                  # Entry point for the app

## API Details

The app interacts with the Gutendex API to fetch book data. The API provides a list of books with details such as title, authors, image URL, and subjects.

- Fetch books:
    ```bash
    GET https://gutendex.com/books/?page=<page_number>
    ```

- Search books:
    ```bash
    GET https://gutendex.com/books/?search=<search_query>
    ```

