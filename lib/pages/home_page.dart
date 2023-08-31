import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        onPressed: () {},
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
