import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class GetRequest extends StatefulWidget {
  const GetRequest({super.key});

  @override
  State<GetRequest> createState() => _GetRequestState();
}

class _GetRequestState extends State<GetRequest> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GET REQUEST DEMO'), backgroundColor: Colors.purple[200],),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          final user = users[index];
          final id = user['id'];
          final name = user['name'];
          final email = user['email'];
          final website = user['website'];

          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                tileColor: Colors.deepPurple.shade200,
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: ClipOval(
                    child: Text('$id', style: const TextStyle(color: Colors.white),),
                  ),
                ),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(email),
                    Text(website),
                  ],
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData
      ),
    );
  }

  void fetchData() async {
    const url = 'https://jsonplaceholder.typicode.com/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonfile = jsonDecode(body);
    setState(() {
      users = jsonfile;
    });

    if (response.statusCode == 200) {
      log('Data Fetched Successfully!');
    }
  }
}