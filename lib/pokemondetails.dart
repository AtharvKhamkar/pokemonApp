// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pokeapp/pokemon.dart';

class PokeDetails extends StatelessWidget {
  const PokeDetails({
    Key? key,
    required this.pokemon,
  }) : super(key: key);
  final Pokemon pokemon;

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    pokemon.name.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Height:${pokemon.height}"),
                  Text("Weight:${pokemon.weight}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber[200],
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Weakness",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  pokemon.weaknesses != null && pokemon.weaknesses!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.weaknesses!
                              .map((t) => FilterChip(
                                  backgroundColor: Colors.red[200],
                                  label: Text(
                                    t,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {}))
                              .toList(),
                        )
                      : const Offstage(),
                  Text("Next Evolutioin",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  if (pokemon.nextEvolution != null &&
                      pokemon.nextEvolution!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution!
                          .map((n) => FilterChip(
                              backgroundColor: Colors.green[200],
                              label: Text(n.name.toString()),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img.toString(),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(pokemon.img.toString()))),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade900,
        title: Text(pokemon.name.toString()),
      ),
      body: bodyWidget(context),
    );
  }
}
