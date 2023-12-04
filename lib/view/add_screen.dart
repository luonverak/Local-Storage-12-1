import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_storage/controller/user_controller.dart';
import 'package:local_storage/model/user_model.dart';

import '../widget/input_field.dart';
import 'home_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var fullname = TextEditingController();
  var gender = TextEditingController();
  var age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter information'),
        actions: [
          IconButton(
            onPressed: () {
              openGallery();
            },
            icon: const Icon(Icons.photo),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    image: (_file == null)
                        ? const DecorationImage(
                            image: AssetImage('asset/icon/profile.png'),
                          )
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_file!),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: fullname,
              hintText: 'Enter fullname',
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: gender,
              hintText: 'Enter gender',
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: age,
              hintText: 'Enter age',
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await UserController()
              .insertData(
                UserModel(
                  id: Random().nextInt(10000),
                  name: fullname.text,
                  age: int.parse(age.text),
                  gender: gender.text,
                  image: _file!.path,
                ),
              )
              .whenComplete(
                () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false),
              );
        },
        child: const Text('Save'),
      ),
    );
  }

  File? _file;
  Future openGallery() async {
    try {
      final fileChoose =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (fileChoose == null) return;
      setState(() {
        _file = File(fileChoose.path);
      });
    } catch (e) {
      print(e);
    }
  }
}
