import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:patterns_mobx/pages/create_page.dart';
import 'package:patterns_mobx/stores/home_store.dart';
import 'package:patterns_mobx/views/item_of_post.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = HomeStore();

  @override
  void initState() {
    super.initState();
    store.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MobX'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) => Stack(
          children: [
            ListView.builder(
              itemCount: store.items.length,
              padding: EdgeInsets.only(top: 5),
              itemBuilder: (ctx, index) {
                return itemOfPost(store, context, store.items[index]);
              },
            ),

            store.isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}