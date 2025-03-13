import 'package:intl/intl.dart';
import 'package:class_practices/model/expense.dart';
import 'package:flutter/material.dart';


class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Expense> _expense = [];
  final List<String> _categories = [
    'Food',
    'Transport',
    'Health',
    'Entertainment',
    'Shopping',
    'Bills',
    'Others'
  ];

  double _total = 0.0;

  void _addExpense(String title,double amount, DateTime date,String category){
    setState(() {
      _expense.add(Expense(title: title, amount: amount, date: date, category: category));
      _total += amount;
    });

  }

  void _deleteExpense(int index){
setState(() {
  _total -= _expense[index].amount;
  _expense.removeAt(index);
});
  }




  void _showForm(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    String selectedCategory = _categories.first;
    DateTime selectedDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title',
                  labelStyle: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.w600
                  )),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount',
                  labelStyle: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                  ),
                ),
                SizedBox(height: 10,),
                DropdownButtonFormField<String>(
                    items: _categories.map((category)=>DropdownMenuItem(value : category , child: Text(category))).toList(),
                    onChanged: (value) => selectedCategory = value!,
                decoration: InputDecoration(labelText: 'Category',
                labelStyle: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.w600
                  )),
                ),
                SizedBox(height: 20,),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade400)),
                      onPressed: (){
                      if(titleController.text.isEmpty || double.tryParse(amountController.text) == null ){
                        return;
                      }
                     _addExpense(titleController.text, double.parse(amountController.text), selectedDate, selectedCategory);
                      titleController.clear();
                      amountController.clear();
                      Navigator.pop(context);



                    }, child: Text("Add Expense", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),))),
                SizedBox(height: 20,)

              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green.shade400,
          title: Text("Expense Trackeing",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,color: Colors.white),),
          actions: [
            IconButton(onPressed: () => _showForm(context), icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Card(
                color: Colors.green.shade400,
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Total: \৳${_total}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _expense.length,
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      key: Key(_expense[index].hashCode.toString()),
                      confirmDismiss: (DismissDirection direction) async{
                        if(direction == DismissDirection.endToStart || direction == DismissDirection.startToEnd){
                          return showDialog(context: context, 
                          builder:(BuildContext context){
                              return AlertDialog(
                                title: Text('Conformation',style: TextStyle(fontWeight: FontWeight.w600),),
                                content: Text('Are you sure you want to delete this expense?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade400)),
                                    onPressed: (){
                                    Navigator.of(context).pop(false);
                                  }, child: Text('No',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),)),

                                  ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red.shade400)), 
                                  onPressed: (){Navigator.of(context).pop(true);}, 
                                  child: Text('Yes',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  ),
                                  

                                ]
                              );
                          } );
                        }
                      },
                      background: //Icon(Icons.delete,color: Colors.red,),
                      Container(color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, right: 10),
                        child: Text('Delete', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,),
                      ),),
                      onDismissed: (direction)=>_deleteExpense(index),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blueAccent,
                            child: Text(_expense[index].category,style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                          title: Text(_expense[index].title),
                          
                          subtitle: Text(
                              DateFormat.yMMMd().format(_expense[index].date)),
                          trailing: Text(_expense[index].amount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade400,
          onPressed: () => _showForm(context),
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
}