import 'package:flutter/material.dart';
import 'package:sbcv2/pages/books_page.dart';
import 'package:sbcv2/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
