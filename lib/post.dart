import 'dart:io';
import 'package:cocktail/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  bool isChecked = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  File? _image;
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _instructionControllers = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Veg'),
                SizedBox(
                  width: 8.0,
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Recipe Type'),
            ),
            SizedBox(height: 20),
            _image == null
                ? ElevatedButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Text('Upload Image'),
                  )
                : Column(
                    children: [
                      Image.file(_image!),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Text('Change Image'),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            Text('Ingredients'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _ingredientControllers.length,
              itemBuilder: (context, index) {
                return TextField(
                  controller: _ingredientControllers[index],
                  decoration:
                      InputDecoration(labelText: 'Ingredient ${index + 1}'),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Instructions'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _instructionControllers.length,
              itemBuilder: (context, index) {
                return TextField(
                  controller: _instructionControllers[index],
                  decoration:
                      InputDecoration(labelText: 'Instruction ${index + 1}'),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _ingredientControllers.add(TextEditingController());
                    });
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _instructionControllers.add(TextEditingController());
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                int cc = await getCount();
                String t = isChecked ? 'v' : 'n';
                cc++;
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref("recipes1/$cc");
                await ref.set({
                  "id": cc,
                  "name": _nameController.text,
                  "ingredients": _ingredientControllers
                      .map((controller) => controller.text)
                      .toList(),
                  "instructions": _instructionControllers
                      .map((controller) => controller.text)
                      .toList(),
                  "type": t,
                  "userRating": ['gaurav2@dev.in'],
                  "total": 17,
                  "n": 4,
                });
                DatabaseReference ref2 = FirebaseDatabase.instance.ref("count");
                await ref2.set({"count": cc});

                if (_image != null) {
                  uploadImage(_image!, "$cc");
                } else {
                  print('No image selected');
                }
              },
              child: Text('Add Recipe'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadImage(File imageFile, String fileName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('recipes1/$fileName');
      await storageReference.putFile(imageFile);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
