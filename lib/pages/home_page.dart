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
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          showDialog(
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller_t = ref.watch(controller_title);
    final controller_a = ref.watch(controller_author);
    final controller_d = ref.watch(controller_description);
    final controller_publish = ref.watch(controller_publisher);
    final controller_s = ref.watch(controller_shelf);
    final controller_pa = ref.watch(controller_page);

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
                        int.parse(controller_pa.value.text, radix: 10));
                    ref.read(controller_author.notifier).update((state) {
                      return TextEditingController();
                    });
                    ref.read(controller_title.notifier).update((state) {
                      return TextEditingController();
                    });
                    ref.read(controller_description.notifier).update((state) {
                      return TextEditingController();
                    });
                    ref.read(controller_publisher.notifier).update((state) {
                      return TextEditingController();
                    });
                    ref.read(controller_page.notifier).update((state) {
                      return TextEditingController();
                    });
                    ref.read(controller_shelf.notifier).update((state) {
                      return TextEditingController();
                    });
                    addBook(book, ref);
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
  ref.read(booksProvider.notifier).update((state) {
    state.add(book);
    return state;
  });
  for (BookModel shelf in ref.read(booksProvider).values) {
    ref.read(shelfProvider.notifier).update((state) {
      state.add(shelf.shelf);
      return state;
    });
  }
  return 0;
}
