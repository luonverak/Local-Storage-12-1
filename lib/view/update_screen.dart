import 'package:flutter/material.dart';

import '../widget/input_field.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});
  var fullname = TextEditingController();
  var gender = TextEditingController();
  var age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit information'),
        actions: [
          IconButton(
            onPressed: () {},
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
                    color: Colors.amber,
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
        onPressed: () {},
        child: const Text('Save'),
      ),
    );
  }
}
