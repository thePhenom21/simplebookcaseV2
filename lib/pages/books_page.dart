import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:hive/hive.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/providers.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Box books = Hive.box("books");
    Box shelves = Hive.box("shelves");
    return Scaffold(
      body: GroupListView(
        itemBuilder: (context, index) {
          BookModel? _currentBook = books?.getAt(index.index);
          return Card(
            child: Row(children: [Text("${_currentBook?.author ?? "null"}")]),
          );
        },
        sectionsCount: 1,
        groupHeaderBuilder: (context, section) {
          return Text("a");
        },
        countOfItemInSection: (section) {
          return 1;
        },
      ),
    );
  }
}
