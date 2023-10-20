import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_generator/data/nouns.dart';
import 'package:word_generator/word_generator.dart';

class Item extends StatefulWidget {
  final String noun;
  final String desc;
  final String thumb;
  const Item({super.key,required this.noun,required this.desc,required this.thumb});
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String noun = "";

  void cambiarTitulo() {
    setState(() {
      noun = "Bienvenido";
    });
  }



  @override
  void initState() {
    super.initState();
    noun = widget.noun;
    _controller = AnimationController(vsync: this);

  }




  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: EdgeInsets.all(20),
      child: Padding(padding: EdgeInsets.all(20),
      child:   Column(
        children: [
          Image.network(widget.thumb),
          Text(noun),
          Text(widget.desc),
          TextButton(onPressed: () => {
              cambiarTitulo()
          }, child: Text("Presiona el boton"))

        ],
      ),)
   
    );
  }
}
