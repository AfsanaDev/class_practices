import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {

  List<Map<String, dynamic>> tasks =[];
  bool showActiveTask = true;

  void showTaskDialog({int? index}){
    TextEditingController _taskController = TextEditingController();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(
            hintText: 'Enter Your task',
            
          ),
          
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: ()=>_addTask(_taskController.text), child: Text('Add'))
        ],
      );
    });
  }

  void _addTask(String task){
    setState(() {
      tasks.add({
        'task':task,
        'completed':false,
        });
    });
    Navigator.pop(context);
  }

  void _toggleTaskStatus(int index){
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  void _deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }

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
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black,width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      offset: Offset(0, 3),
                      blurRadius: 5
                    )
                  ]
                ),
                child: Row(children: [
                  Column(children: [
                    Text("Active", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    )),
                    Text('10',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ))
                  ],)
                ]),
            
              ),
               Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black,width: 2),
                   boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      offset: Offset(0, 3),
                      blurRadius: 5
                    )
                  ]
                ),
                child: Row(children: [
                  Column(children: [
                    Text("Completed", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    )),
                    Text('10',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ))
                  ],)
                ]),
            
              )
            ],),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key:Key(tasks[index]['task']),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white,),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.check, color: Colors.white,),
                  ),
                  onDismissed:(direction){
                    if(direction == DismissDirection.startToEnd){
                      _toggleTaskStatus(index);
                    }else{
                      _deleteTask(index);
                    }
                  } ,
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index]['task']),
                    ),
                  ),
                );
            }),
          )
        ],
      ) ,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade400,
        onPressed: ()=>showTaskDialog(),
        child: Icon(Icons.add, color: Colors.white,),),
    );
  }
}