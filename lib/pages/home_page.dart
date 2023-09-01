import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbcv2/models/book_model.dart';
import 'package:sbcv2/pages/books_page.dart';
import 'package:sbcv2/pages/search_page.dart';
import 'package:sbcv2/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  //mixin needed for tab contoller vsync property

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    BookModel? book = ref.watch(currentBook);
    BookModel? deleted = ref.watch(deletedBook);
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return BookDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (ref.watch(themeProvider) == ThemeData.dark()) {
                  ref
                      .read(themeProvider.notifier)
                      .update((state) => ThemeData.light());
                  ref
                      .read(iconProvider.notifier)
                      .update((state) => Icon(Icons.dark_mode));
                } else {
                  ref
                      .read(themeProvider.notifier)
                      .update((state) => ThemeData.dark());
                  ref
                      .read(iconProvider.notifier)
                      .update((state) => Icon(Icons.light_mode));
                }
              },
              icon: ref.watch(iconProvider))
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [BooksPage(), SearchPage()],
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.book),
                onPressed: () {
                  setState(() {
                    tabController!.index = 0;
                  });
                },
              ),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      tabController!.index = 1;
                    });
                  })
            ],
          )),
    );
  }
}

class BookDialog extends ConsumerWidget {
  BookDialog({super.key});

  final controller_t = TextEditingController();
  final controller_a = TextEditingController();
  final controller_d = TextEditingController();
  final controller_publish = TextEditingController();
  final controller_s = TextEditingController();
  final controller_pa = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller_t,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: controller_a,
              decoration: InputDecoration(hintText: "Author"),
            ),
            TextField(
              controller: controller_publish,
              decoration: InputDecoration(hintText: "Publisher"),
            ),
            TextField(
              controller: controller_d,
              decoration: InputDecoration(hintText: "Description"),
            ),
            TextField(
              controller: controller_s,
              decoration: InputDecoration(hintText: "Shelf"),
            ),
            TextField(
              controller: controller_pa,
              decoration: InputDecoration(hintText: "Page Count"),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    Navigator.of(context).pop();
                    BookModel book = BookModel(
                        controller_a.value.text,
                        controller_d.value.text,
                        controller_t.value.text,
                        controller_publish.value.text,
                        controller_s.value.text,
                        int.parse(controller_pa.value.text));
                    await addBook(book, ref);
                    controller_a.clear();
                    controller_d.clear();
                    controller_pa.clear();
                    controller_publish.clear();
                    controller_t.clear();
                    controller_s.clear();
                  } catch (err) {
                    print(err);
                  }
                },
                child: Text("Save Book"))
          ],
        ),
      ),
    );
  }
}

Future<int> addBook(BookModel book, WidgetRef ref) async {
  await Hive.box("books").add(book);
  for (BookModel b in Hive.box("books").values) {
    if (!Hive.box("shelves").values.contains(b.shelf)) {
      await Hive.box("shelves").add(b.shelf);
    }
  }
  ref.read(currentBook.notifier).update((state) => book);
  return 0;
}
