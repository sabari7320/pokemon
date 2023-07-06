import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PokemonListScreen extends StatefulWidget {
  final String name;

  PokemonListScreen({required this.name});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<dynamic> pokemonNames = [];
  bool isNameInList = false;

  @override
  void initState() {
    super.initState();
    fetchPokemonNames();
  }

  Future<void> fetchPokemonNames() async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        final names = results.map((pokemon) => pokemon['name']).toList();
        setState(() {
          pokemonNames = names;
          isNameInList = pokemonNames.contains(widget.name);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isNameInList
                  ? 'The name "${widget.name}" is in the list.'
                  : 'The name "${widget.name}" is not in the list.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pokemonNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pokemonNames[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}