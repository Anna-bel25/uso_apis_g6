import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'poeta.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(196, 109, 233, 215)),
        useMaterial3: true,
      ),
      home: const MyApiPage(title: 'Lectura API - Poeta'),
    );
  }
}

class MyApiPage extends StatefulWidget {
  const MyApiPage({super.key, required this.title});

  final String title;

  @override
  State<MyApiPage> createState() => _MyApiPageState();
}

class _MyApiPageState extends State<MyApiPage> {
  Future<List<Poeta>>? _listadoPoemas;

  Future<List<Poeta>> _getPoemas() async {
    final response = await http.get(Uri.parse('https://poetrydb.org//author/Emily%20Dickinson/author,title,linecount'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
      .map((poetaData) => Poeta(
        title: poetaData['title'],
        author: poetaData['author'] ?? '',
        linecount: poetaData['linecount'] ?? '',
      ))
      .toList();
    } else {
      throw Exception('Error de conexion');
    }
  }


  @override
  void initState() {
    super.initState();
    _listadoPoemas = _getPoemas();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lectura API - Poeta'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: FutureBuilder<List<Poeta>>(
        future: _getPoemas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final poemas = snapshot.data!;
            return ListView.builder(
              itemCount: poemas.length,
              itemBuilder: (context, index) {
                final poeta = poemas[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
                  
                  child: Card(
                    color: Color.fromARGB(214, 211, 254, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    elevation: 5, 
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: ClipOval(
                        //SizedBox
                        //width: 50,
                        //height: 50,
                        child: Image.network('https://images.unsplash.com/photo-1541520495007-26f425f8846d?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(poeta.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Autor: ${poeta.author}'),
                          Text('Cantidad de líneas: ${poeta.linecount}'),
                        ],
                      ),
                    ),
                  )
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center (
              child: Text('${snapshot.error}'),
              );
          } else {
            return const Center (
              child: CircularProgressIndicator(),
              );
          }
        },

      ),
    );
  }
}