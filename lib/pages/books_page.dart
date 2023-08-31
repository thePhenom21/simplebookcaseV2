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
    Box? books = ref.watch(hiveBoxProvider).when(
      data: (data) {
        return data;
      },
      error: (error, stackTrace) {
        return null;
      },
      loading: () {
        return null;
      },
    );
    Box? shelves = ref.watch(shelfProvider).when(
      data: (data) {
        return data;
      },
      error: (error, stackTrace) {
        return null;
      },
      loading: () {
        return null;
      },
    );
    return Scaffold(
      body: GroupListView(
        itemBuilder: (context, index) {
          String _currentBook = books!.getAt(index.index);
          return Card(
            child: Row(children: [Text("${_currentBook}")]),
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
