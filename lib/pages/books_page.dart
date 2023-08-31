import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/providers.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ListView.builder(
      itemCount: ref.watch(allBooks).length,
      itemBuilder: (context, index) {
        BookModel _curBook = ref.watch(allBooks)[index];
        return SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          child: Card(
            child: Row(children: [Text(_curBook.shelf)]),
          ),
        );
      },
    ));
  }
}
