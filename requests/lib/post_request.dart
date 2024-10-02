import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostRequest extends StatefulWidget {
  const PostRequest({super.key});

  @override
  State<PostRequest> createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> submitData() async {
    final String name = _nameController.text;
    final String email = _emailController.text;

    const url = 'http://127.0.0.1:5050/post';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'content-type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name' : name,
        'email' : email
      }),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
    } 
    else if (response.statusCode == 500){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('POST REQUEST DEMO'), backgroundColor: Colors.purple[200],),
      backgroundColor: Colors.deepPurple[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
              width: double.infinity,
              child: Text(
                'POST REQUEST FORM',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                label: const Text('Name'),
                filled: true,
                fillColor: Colors.deepPurple[50]
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                label: const Text('Email Address'),
                filled: true,
                fillColor: Colors.deepPurple[50]
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: submitData, 
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}