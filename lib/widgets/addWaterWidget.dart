import 'package:flutter/material.dart';

class Addwaterwidget extends StatelessWidget {
  final String addWaterAmount;
  IconData? buttonIcon;
  final VoidCallback onClick;
  Addwaterwidget({super.key, required this.addWaterAmount , this.buttonIcon, required this.onClick} );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: onClick,
                      label: Text('+${addWaterAmount}ml',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.green
                      ),),
                       icon: Icon(buttonIcon ?? Icons.water_drop,color: Colors.green,)
                        ),
                    ),
                    
                  );
  }
}