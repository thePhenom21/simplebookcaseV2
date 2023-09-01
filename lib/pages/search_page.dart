import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/providers.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:dio/dio.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});

  final search_controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedBooks = ref.watch(searchedBookProvider);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 4 * MediaQuery.of(context).size.width / 5,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Book Info"),
                    controller: search_controller,
                    onChanged: (controller) {
                      ref.read(searchedBookProvider.notifier).update((state) {
                        List<BookModel> returnVal = [];
                        Hive.box("books").values.forEach((element) {
                          element = element as BookModel;
                          if (element.author.contains(controller) ||
                              element.title.contains(controller) ||
                              element.publisher.contains(controller)) {
                            returnVal.add(element);
                          }
                        });
                        return returnVal;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      String isbn = await readBarcode();
                      print(isbn);
                      BookModel book = await getBookfromISBN(isbn);
                      ref
                          .read(searchedBookProvider.notifier)
                          .update((state) => [book]);
                    },
                    child: Icon(Icons.barcode_reader))
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 4 * MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                  itemCount: searchedBooks.length,
                  itemBuilder: (context, index) {
                    if (searchedBooks.isNotEmpty) {
                      BookModel element = searchedBooks.toList()[index];
                      return Card(
                        child: Text(
                            "Title: ${element.title}        Publisher: ${element.publisher} \nAuthor: ${element.author}                 Page Count:${element.pageCount}\nDescription:${element.description}"),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getBookfromISBN(String isbn) async {
  Response book = await Dio()
      .get("https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn");

  Map<String, dynamic> m = book.data["items"][0]["volumeInfo"];

  BookModel newBook = BookModel(m["authors"][0], m["description"], m["title"],
      "book.publisher", "Scanned Books", m["pageCount"]);
  Hive.box("books").add(newBook);
  Hive.box("shelves").add(newBook.shelf);
  return newBook;
}

readBarcode() async {
  try {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        "red", "Cancel Scan", false, ScanMode.DEFAULT);
    return barcode;
  } catch (err) {
    print(err);
  }
}
