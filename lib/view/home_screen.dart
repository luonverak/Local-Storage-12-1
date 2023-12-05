import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/controller/user_controller.dart';
import 'package:local_storage/model/user_model.dart';
import 'package:local_storage/view/add_screen.dart';
import 'package:local_storage/view/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<UserModel>>? list;
  late UserController db;
  Future refresh() async {
    db = UserController();
    setState(() {
      list = db.getData();
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Storage'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 500,
        child: FutureBuilder<List<UserModel>>(
          future: list,
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: Icon(
                Icons.info,
                color: Colors.red,
              ));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(File(data.image)),
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text('Age ${data.age}'),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    model: data,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Delete !',
                                desc: 'Are you sur?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  await UserController()
                                      .deleteData(data.id)
                                      .whenComplete(() => refresh());
                                },
                              ).show();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
