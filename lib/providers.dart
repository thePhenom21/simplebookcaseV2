import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sbcv2/models/book_model.dart';

StateProvider<List<BookModel>> allBooks = StateProvider((ref) => [
      BookModel("a", "b", "c", "d", "e", 4),
      BookModel("a", "bdsa", "cdasdsa", "d", "e", 45)
    ]);

StateProvider<ThemeData> themeProvider =
    StateProvider((ref) => ThemeData.dark());

StateProvider<Icon> iconProvider =
    StateProvider((ref) => Icon(Icons.light_mode));

FutureProvider<Box> hiveBoxProvider = FutureProvider((ref) async {
  Box a = await Hive.openBox("books");
  a.add("k");
  return a;
});

FutureProvider<Box> shelfProvider = FutureProvider((ref) async {
  return await Hive.openBox("shelves");
});
