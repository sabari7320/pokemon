import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'new.dart';

class UserInput extends StatefulWidget {
  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POKEMONS'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter Name',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonListScreen(name: name),
                ),
              );
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}



