import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  String _selectedPriority = 'Low'; // Default priority

  List<String> _priorities = ['Low', 'Medium', 'High']; // Priority options

  File? _image;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: GestureDetector(
                  onTap: () {
                    _getImage(); // Call method to pick an image
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[200],
                    child: _image == null
                        ? Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 48,
                        color: Colors.grey,
                      ),
                    )
                        : Center(
                      child: Image.file(_image!), // Show selected image
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 150, // Set the width of the dropdown
                child: DropdownButtonFormField(
                  value: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value.toString();
                    });
                  },
                  items: _priorities.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _noteController,
                maxLines: 3, // Allow multiple lines for notes
                decoration: InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price (£)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number, // Allow only numeric input
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Decrease quantity
                      int quantity = int.tryParse(_quantityController.text) ?? 0;
                      if (quantity > 0) {
                        setState(() {
                          _quantityController.text = (quantity - 1).toString();
                        });
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Increase quantity
                      int quantity = int.tryParse(_quantityController.text) ?? 0;
                      setState(() {
                        _quantityController.text = (quantity + 1).toString();
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: _websiteController,
                decoration: InputDecoration(
                  labelText: 'Website Link',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Validate and save item details
                  String itemName = _itemNameController.text.trim();
                  String note = _noteController.text.trim();
                  double price = double.tryParse(_priceController.text) ?? 0.0;
                  int quantity = int.tryParse(_quantityController.text) ?? 0;
                  String websiteLink = _websiteController.text.trim();

                  // Pass the item data back to the previous page
                  Navigator.pop(context, {
                    'itemName': itemName,
                    'image': _image,
                    'priority': _selectedPriority,
                    'note': note,
                    'price': price,
                    'quantity': quantity,
                    'websiteLink': websiteLink,
                  });
                },
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
}
