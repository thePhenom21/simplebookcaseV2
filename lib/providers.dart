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

StateProvider<Box> booksProvider = StateProvider((ref) => Hive.box("books"));

StateProvider<Box> shelfProvider = StateProvider((ref) => Hive.box("shelves"));

StateProvider<BookModel?> currentBook = StateProvider((ref) => null);

StateProvider<TextEditingController> controller_title =
    StateProvider((ref) => TextEditingController());

StateProvider<TextEditingController> controller_author =
    StateProvider((ref) => TextEditingController());

StateProvider<TextEditingController> controller_description =
    StateProvider((ref) => TextEditingController());

StateProvider<TextEditingController> controller_publisher =
    StateProvider((ref) => TextEditingController());

StateProvider<TextEditingController> controller_shelf =
    StateProvider((ref) => TextEditingController());

StateProvider<TextEditingController> controller_page =
    StateProvider((ref) => TextEditingController());

StateProvider<List<BookModel>> searchedBookProvider =
    StateProvider((ref) => []);
