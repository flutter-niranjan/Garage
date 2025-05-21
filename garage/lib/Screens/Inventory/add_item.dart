import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/Model/item.dart';
import 'package:garage/Providers/garage_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State createState() => AddItemState();
}

class AddItemState extends State {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _picker = ImagePicker();

  String _name = "";
  String _description = "";
  String _category = "Battery";
  double _price = 0.0;

  List<String> categories = ["Battery", "AC", "Brake", "Clutch", "Tyre"];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();
      final newItem = InventoryItem(
          name: _name,
          description: _description,
          category: _category,
          price: _price,
          imagePath: _image!.path,
          image: _image!,
          );

      Provider.of<GarageProvider>(context, listen: false).addItem(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Inventory Item",
        style: GoogleFonts.poppins(),
        ),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _image == null ? Container(
                height: 150,
                color: Colors.grey,
                child: Icon(Icons.camera_alt),
              ): Image.file(_image!,height: 150,),
            ),
            TextFormField(
              decoration:  InputDecoration(labelText: "Item Name"),
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Item Description"),
              onSaved: (value) => _description = value!,
            ),
            DropdownButtonFormField(
              value: _category,
              items: categories.map((cat)=>DropdownMenuItem(value: cat,child: Text(cat))).toList(), 
              onChanged: (value) => setState(()=> _category = value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text("Add Item"),)
          ],
        ),
      ),
      ),
    );
  }
}
