import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
  final String organizerId;

  CreateEventPage({required this.organizerId});

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _placeController = TextEditingController();
  final _dateController = TextEditingController();
  final _detailsController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isButtonPressed = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _createEvent() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? imageUrl;

        if (_image != null) {
          final fileName = _image!.path.split('/').last;
          final storageRef =
              FirebaseStorage.instance.ref().child('event_posters/$fileName');
          final uploadTask = storageRef.putFile(_image!);

          await uploadTask.whenComplete(() async {
            imageUrl = await storageRef.getDownloadURL();
          });
        }

        await FirebaseFirestore.instance.collection('events').add({
          'title': _titleController.text,
          'place': _placeController.text,
          'date': _dateController.text,
          'details': _detailsController.text,
          'ticketPrice': _ticketPriceController.text,
          'posterImage': imageUrl,
          'organizerId': widget.organizerId,
        });

        await FirebaseFirestore.instance.collection('notifications').add({
          'title': _titleController.text,
          'date': _dateController.text,
          'details': _detailsController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'unread',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event created successfully')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _image = null;
        });
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create event')),
        );
      }
    }
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      bool isNumber = false,
      int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[850],
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.pink),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Create Event',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _titleController,
                label: 'Title',
              ),
              _buildTextField(
                controller: _placeController,
                label: 'Place',
              ),
              _buildTextField(
                controller: _dateController,
                label: 'Date',
              ),
              _buildTextField(
                controller: _detailsController,
                label: 'Details',
                maxLines: 3,
              ),
              _buildTextField(
                controller: _ticketPriceController,
                label: 'Ticket Price',
                isNumber: true,
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text(
                      'No image selected.',
                      style: TextStyle(color: Colors.white),
                    )
                  : Image.file(_image!),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                color: Colors.blue,
                onPressed: _pickImage,
                child: const Text(
                  'Pick Event Banner',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(height: 40),
              isButtonPressed
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : SizedBox(
                      height: 2,
                    ),
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  onPressed: _createEvent,
                  child: const Text(
                    'Create Event',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
