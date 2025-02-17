import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      
      body:Column(
        children: [
          Row(children: [
            Container(

            )
          ],)
        ],
      ) ,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade400,
        onPressed: (){

        },
        child: Icon(Icons.add, color: Colors.white,),),
    );
  }
}