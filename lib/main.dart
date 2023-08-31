import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/pages/home_page.dart';
import 'package:sbcv2/providers.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(BookModelAdapter());
  await Hive.openBox("books");
  await Hive.openBox("shelves");
  await Hive.box("books").add(BookModel("a", "bdsa", "cdasdsa", "d", "e", 45));
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ref.watch(themeProvider),
    );
  }
}
