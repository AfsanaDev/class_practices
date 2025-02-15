import 'package:class_practices/widgets/addWaterWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WaterAppscreen extends StatefulWidget {
  const WaterAppscreen({super.key});

  @override
  State<WaterAppscreen> createState() => _WaterAppscreenState();
}

class _WaterAppscreenState extends State<WaterAppscreen> {
  int _currentIntake =0;
  final int _goal = 2000;


  void waterAdd(int amount)
  {
    setState(() {
      if(_currentIntake < _goal){
        _currentIntake = (_currentIntake + amount).clamp(0, _goal);
      }
    });
  }


  void resetWater(){
   setState(() {
     _currentIntake = 0;
   });
  }
  @override
  Widget build(BuildContext context) {
    double progress =(_currentIntake /_goal).clamp(0.0, 1.0);
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          backgroundColor: Colors.green.shade400,
          title: Text('Water Traking App', 
          style:TextStyle(
            fontSize:24,
            fontWeight: FontWeight.w600,
            color: Colors.white),
             ),
            centerTitle: true,
        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                     )
                  ]
                ),
                child: Column(
                  children: [
                    Text('Today I drank',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text('${_currentIntake} ml',style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.green.shade500),),
                  ],
                ),
              ),

              SizedBox(height: 30,),

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade500,
                      color: Colors.green,
                      strokeWidth: 10,
                    ),
                  ),

                  Text('${(progress*100).toInt()} %',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),),

                  
                  
                ],
              ),
              SizedBox(height: 20,),
                  
                  Wrap(
                    spacing: 15,
                    children: [
                      Addwaterwidget(addWaterAmount: '200', onClick: ()=>waterAdd(200),buttonIcon: Icons.local_drink,),
                      Addwaterwidget(addWaterAmount: '500', onClick: ()=>waterAdd(500),),
                      Addwaterwidget(addWaterAmount: '1000', onClick:()=>waterAdd(1000) , buttonIcon: Icons.local_cafe,),
                      //Addwaterwidget(addWaterAmount: '100ml'), onClick: () {  },
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),  
                      onPressed: ()=> resetWater(), 
                      child: Text('Reset', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),)),
                    ),
                  )
            ],
          ),
        ),
      );
  }
}