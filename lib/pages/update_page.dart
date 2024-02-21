import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:patterns_mobx/stores/update_store.dart';

class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String title, body;
  UpdatePage({required this.title, required this.body});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateStore store = UpdateStore();

  @override
  void initState() {
    super.initState();

    store.titleTextEditingController.text = widget.title;
    store.bodyTextEditingController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update page'),
      ),
      body: Observer(
        builder: (_) => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Title",style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    // #title
                    TextField(
                      controller: store.titleTextEditingController,
                      style: const TextStyle(color: Colors.black, fontSize: 30),
                      decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.blue, fontSize: 20),
                        //border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 50,),
                    const Text("Content",style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    // #body
                    TextField(
                      controller: store.bodyTextEditingController,
                      maxLines: null,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      decoration: const InputDecoration(
                        hintText: "Body",
                        hintStyle: TextStyle(color: Colors.blue, fontSize: 20),
                        //border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent
                      ),
                      width: 160,
                      height: 100,
                      child: TextButton(
                        onPressed: (){
                          store.apiPostUpdate(context);
                        },//_apiPostCreate();
                        child: const Text("Add",style: TextStyle(color: Colors.white,fontSize: 30),),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            store.isLoading ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}