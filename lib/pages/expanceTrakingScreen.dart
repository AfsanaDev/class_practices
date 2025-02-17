import 'package:class_practices/model/expense.dart';
import 'package:flutter/material.dart';

class Expancetrakingscreen extends StatefulWidget {
  const Expancetrakingscreen({super.key});

  @override
  State<Expancetrakingscreen> createState() => _ExpancetrakingscreenState();
}

class _ExpancetrakingscreenState extends State<Expancetrakingscreen> {
  
  final List<Expense> _expanse =[];
  final List<String> _categorys=[
    'Food',
    'Transport',
    'Health',
    'Entertainment',
    'Shopping',
    'Bills',
    'Others'
  ];
  double _totalAmount=0.0;

  void _showForm(BuildContext context){
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();


    showBottomSheet(context: context, 
    builder: (_){
    return Column(
      children: [
        TextField(
          
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Amount'),
          ),
          
      ],
    );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("Expanse Traking",
        style: TextStyle(color: Colors.white,
         fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
    
      body: Column(
        children: [
          Center(
            child: Card(
              color: Colors.green.shade400,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Total Amount: \$${_totalAmount} ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:_expanse.length ,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade400,
                      radius: 30,
                      child: Text(_expanse[index].category),),
            
                    title: Text(_expanse[index].title),
                    subtitle: Text(_expanse[index].date.toString()),
                    //subtitle: Text(DateFormat.yMMMd().format(_expanse[index].date)),
                    trailing: Text('${_expanse[index].amount.toString()}'),
            
                    
                    
                    ),
                );
              }),
          )
        ],
      ),
    
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: ()=>_showForm(context),
        child: Icon(Icons.add,color: Colors.white,),
    ),
    );
  }
}