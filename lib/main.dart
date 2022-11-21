import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie Searching App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
      ),
      home: const MyMoviePage(title: 'Flutter Movie Searching App'),
    );
  }
}

class MyMoviePage extends StatefulWidget {
  //@override
  const MyMoviePage({super.key, required this.title});

  final String title;

  @override
  State<MyMoviePage> createState() => _MyMoviePageState();
}

class _MyMoviePageState extends State<MyMoviePage> {
  String selectMovies = "Guardians of the Galaxy Vol. 2";
  List<String> movieList = [
    "Guardians of the Galaxy Vol. 2",
    "BlackPanther",
  ];

  String desc = "No Data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Searching'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: unnecessary_const
            const Text(" Movie ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

            DropdownButton(
              itemHeight: 48,
              value: selectMovies,
              onChanged: (newValue) {
                setState(() {
                  selectMovies = newValue.toString();
                });
              },
              items: movieList.map((selectMovies) {
                return DropdownMenuItem(
                  child: Text(
                    selectMovies,
                  ),
                  value: selectMovies,
                );
              }).toList(),
            ),

            ElevatedButton(
                onPressed: _getMovies, child: const Text("Load Movie")),
            Text(desc,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Future<void> _getMovies() async {
    var apiid = "7d5db6bf";
    var url = Uri.parse('http://www.omdbapi.com/?i=tt3896198&apikey=$apiid');
    var response = await http.get(url);
    var rescode = response.statusCode;

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        String tit = "Guardians of the Galaxy Vol. 2";
        String Year = "2017";
        String Rated = "PG-13";
        String Genre = "Action, Adventure, Comedy";
        String Director = "James Gunn";
        String Writer = "James Gunn, Dan Abnett, Andy Lanning";
        String Actors = "Chris Pratt, Zoe Saldana, Dave Bautista";
        desc =
            "The title of the movie is $tit. The year of published is $Year. The Rated of the movie is $Rated. The genre is $Genre. The director of the movie is $Director. The Writer of the movie are $Actors";
      });
    } else {
      desc = "No record";
    }
  }
}
