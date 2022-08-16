import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/LoginPage.dart';
import 'package:pokeapp/splashscreenpage.dart';
import 'dart:convert';
import 'LoginPage.dart';
import 'package:pokeapp/utils/myRoutes.dart';
import 'package:pokeapp/pokemon.dart';
import 'package:pokeapp/pokemondetails.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MaterialApp(
        title: "Poke App",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: myRoutes.splashscreenRoute,
        routes: {
          myRoutes.homeRoute: (context) => HomePage(),
          myRoutes.loginRoute: (context) => LoginPage(),
          myRoutes.splashscreenRoute: (context) => SplashScreen(),
        }));

class HomePage extends StatefulWidget {
  static String? homePage;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

  PokeHub? pokeHub;
  HomePage? homePage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    setState(() {
      pokeHub = PokeHub.fromJson(decodedJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text("Poke App"),
        backgroundColor: Colors.lightBlue.shade900,
      ),
      drawer: Drawer(),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub!.pokemon!
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetails(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.img.toString(),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(poke.img ?? ''))),
                                  ),
                                  Text(
                                    poke.name.toString(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
        backgroundColor: Colors.lightBlue.shade900,
      ),
    );
  }
}
