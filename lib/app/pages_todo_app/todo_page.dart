import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Helper/Firebase_helper.dart';
import '../custom_widget/List_custom.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController discriptioncontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();


  TextEditingController discriptioneditorcontroller = TextEditingController();
  TextEditingController titleeditorcontroller = TextEditingController();

  bool value = false;
  String? complate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Todo App"),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Tab 1',icon: Icon(Icons.car_repair),),
                Tab(text: 'Tab 2  ',icon: Icon(Icons.directions_bike),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      List complate = snapshot.data!.docs.where((element) => element['isCompleted'] == false).toList();
                      log("hi --> $complate");

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("Data Not Found"),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, i) {
                          final discription = complate[i].data()['Discription'];
                          final title = complate[i].data()['title'];
                          final uid = complate[i].data()['uid'];
                          final isCompleted = complate[i].data()['isCompleted'];
                          // print(uid);

                          return Dismissible(
                            key: ValueKey(i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: double.infinity,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: listcustomwidget(
                                          discription: discription,
                                          Title: title,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: InkWell(
                                              onTap: () {
                                                DatabaseService().deletelist(uid);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Checkbox(value: isCompleted, onChanged: (value){
                                            setState(() {
                                              DatabaseService().updatelist(uid,value);
                                              this.value=value!;
                                            });
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: complate.length,
                      );
                    }
                    return const Center(
                      child: Text("Data Not Found"),
                    );
                  },
                  stream: FirebaseFirestore.instance.collection("Todo").snapshots()),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List complate = snapshot.data!.docs.where((element) => element['isCompleted'] == true).toList();
                      log("hi --> $complate");
                      // int len = snapshot.data!.docs.length;

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("Data Not Found"),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, i) {
                          final discription = complate[i].data()['Discription'];
                          final title = complate[i].data()['title'];
                          final uid = complate[i].data()['uid'];
                          final isCompleted = complate[i].data()['isCompleted'];


                          return Dismissible(
                            key: ValueKey(i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: double.infinity,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: listcustomwidget(
                                          discription: discription,
                                          Title: title,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: InkWell(
                                              onTap: () {
                                                DatabaseService().deletelist(uid);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Checkbox(value: isCompleted, onChanged: (value){
                                            setState(() {
                                              DatabaseService().updatelist(uid,value);
                                              this.value=value!;
                                            });
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: complate.length,
                      );
                    }
                    return const Center(
                      child: Text("Data Not Found"),
                    );
                  },
                  stream: FirebaseFirestore.instance.collection("Todo").snapshots()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: titlecontroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Title"),
                            hintText: "Enter your Title",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: discriptioncontroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Discription:"),
                            hintText: "Enter your Discription",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    discriptioneditorcontroller.clear();
                                    titleeditorcontroller.clear();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Exit")),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (discriptioncontroller.text.isNotEmpty &&
                                      titlecontroller.text.isNotEmpty) {
                                    await DatabaseService().newFirebaseTodo(
                                        discriptioncontroller.text,
                                        titlecontroller.text,false);
                                    setState(() {
                                      discriptioneditorcontroller.clear();
                                      titleeditorcontroller.clear();
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Add")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
