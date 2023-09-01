import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive/hive.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/providers.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Box books = ref.watch(booksProvider);
    Box shelfs = ref.watch(shelfProvider);
    return Scaffold(
        body: GroupedListView(
      groupHeaderBuilder: (element) {
        return Text((element as BookModel).shelf);
      },
      itemBuilder: (context, element) {
        return GestureDetector(
          onTap: () {
            Hive.box("books").deleteAt(books.values.toList().indexOf(element));
          },
          child: Card(
              child: Text(
                  "Title: ${element.title}        Publisher: ${element.publisher} \nAuthor: ${element.author}                 Page Count:${element.pageCount}\nDescription:${element.description}")),
        );
      },
      elements: books.values.toList(),
      groupBy: (element) {
        return (element as BookModel).shelf;
      },
    ));
  }
}
