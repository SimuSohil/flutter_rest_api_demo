// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutRequest extends StatefulWidget {
  const PutRequest({super.key});

  @override
  State<PutRequest> createState() => _PutRequestState();
}

class _PutRequestState extends State<PutRequest> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> updateData() async {
    final String id = _idController.text;
    final String name = _nameController.text;
    final String email = _emailController.text;

    final url = 'http://127.0.0.1:5050/put/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      headers: <String, String> {
        'Content-Type' : 'application/json',
      },
      body: jsonEncode({
        'name' : name,
        'email' : email
      })
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PUT REQUEST DEMO'), backgroundColor: Colors.purple[200],),
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
                'PUT REQUEST FORM',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),
              ),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                label: const Text('ID'),
                filled: true,
                fillColor: Colors.deepPurple[50]
              ),
            ),
            const SizedBox(height: 20,),
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
                onPressed: updateData, 
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                child: const Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }
}