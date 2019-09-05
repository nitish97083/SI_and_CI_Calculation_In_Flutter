import 'dart:math';

import 'package:flutter/material.dart';

main(){runApp(
   MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       brightness: Brightness.dark,
      primaryColor: Colors.green[300],
      accentColor: Colors.orange[300],
     ),
     title:'SI and CI Calculator',
    home: CalCulator()),
   ) ;
}


class CalCulator extends StatefulWidget{

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalCulator();
  }


}

class _CalCulator extends State<CalCulator>{

var _formkey = GlobalKey<FormState>();
TextEditingController principal = TextEditingController();
TextEditingController rateOfInterest = TextEditingController();
TextEditingController time = TextEditingController();

  var _currency=['ruppes','dollars','others'];
  var display ='';
var firstSelectedItem = 'ruppes';
var show = '';
@override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      
      appBar: AppBar(
        title: Text('SI and CI Calculator'),
      ),
      body: Form(
        key: _formkey,
      child:Padding(
        padding: EdgeInsets.all(20.0),  
        child: ListView(
          children: <Widget>[
             SizedBox(height: 50.0,),
         Padding(
         padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
       child:TextFormField(
              keyboardType: TextInputType.number,
              controller: principal,
              validator:(String value){
                  if(value.isEmpty){
                    return "Please Enter Principal Amount";
                  }

              },
              decoration: InputDecoration(
                labelText: 'Principle',
                errorStyle: TextStyle(color: Colors.orange,
                fontSize: 10.0,),
                hintText: 'Enter principle e.g. 1200',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 )  
              ),
           ),
            ),
             SizedBox(height: 50.0,),
            Padding(
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.number,
              controller: rateOfInterest,
              validator: (String value){
                      if(value.isEmpty){
                        return'Please enter rate of interest';
                      }
              },
              decoration: InputDecoration(
             labelText: 'Rate of Interest',
             hintText: 'Enter Rate of interest e.g. 4',
             border: OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(20.0)),
             )

              )

             ) ,
            ),
             SizedBox(height: 50.0,),
            Row(
              children: <Widget>[

              ],
              
            ),
       //   Expanded(

              Row(
             children: <Widget>[

                Expanded(

          child:TextFormField(
                      keyboardType: TextInputType.number,
                      controller: time,
                     validator: (String value){
                       if(value.isEmpty){
                         return"please enter time period ";
                       }
                     },
                      decoration: InputDecoration(
                        labelText: 'time',
                        hintText: 'time e.g.1 year',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        labelStyle: TextStyle(
                           backgroundColor:Colors.yellowAccent[300],
                                             fontSize: 20.0,
                                             color: Colors.white,
                                             fontFamily: 'Montserrat',
                                             fontWeight: FontWeight.bold ) ,
                      
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ) ),

                     ),
                ),

                Container(width: 30.0,height: 40.0,),
               Expanded(
                 child: DropdownButton<String>(
                    items:  _currency.map((String dropdownMenuItem){
                      return DropdownMenuItem<String>(
                        value: dropdownMenuItem,
                        child: Text(dropdownMenuItem),
                      );
                      }).toList(),
                     value: firstSelectedItem,
                     onChanged: (String selecteditem){

                       _onSelectedDropdown(selecteditem);
                       
                                                // your code is execute when menu is selected
                                            }
                                        ) 
                                      )
                       
                                    ],
                                   ),
                             SizedBox(height: 50.0,),

                                Padding(
                                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                 child: Row(
                                    children: <Widget>[
                                       Expanded(
                                         child: RaisedButton(

                                           child: Text('For SI',
                                           style: TextStyle(
                                           backgroundColor:Colors.yellowAccent[300],
                                             fontSize: 20.0,
                                             color: Colors.black,
                                             fontWeight: FontWeight.bold ) ,
                                           ),
                                      
                                      
                                           onPressed:(){
                                             
                                           setState(() {
                                         if(_formkey.currentState.validate()){
                                       this.display = _onClaculatedSI(); 
                                           }
                                           }
                                           );
                                      
                                           } ,
                                         ),
                                       ),
                                      Container(width: 10.0),
                                       Expanded(
                                        
                                         child: RaisedButton(
                                           child: Text('For CI',
                                           style:TextStyle(
                                             backgroundColor:Colors.yellowAccent[300],
                                             fontSize: 20.0,
                                             color: Colors.black,
                                             fontWeight: FontWeight.bold ) ,
                                           ),
                                           onPressed:(){
                                          setState(() {
                                           if(_formkey.currentState.validate()){
                                       this.display = _onClaculatedSI(); 
                                           }
                                          });
                                             
                                           }
                                         ),
                                       ),
                                       Container(width: 10.0),
                                       Expanded(
                                         child: RaisedButton(
                                           child: Text('Reset',style:TextStyle(
                                             backgroundColor:Colors.yellowAccent[300],
                                             fontSize: 20.0,
                                             color: Colors.black,
                                             fontWeight: FontWeight.bold,),
                                           ),


                                           onPressed:(){
                              setState(() {
                               _reset();

                              
                              });
                                             
                                           }
                                         ),
                                       ),
                                  ],
                                  )
                                ),
                               Padding(
                                 padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                 child: Text(display),
                                
                               ),
                                 Padding(
                                 padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                 child: Text(show),
                                
                               )
                                
                                 ],
                               ),
                             ),
                            ),
                           );
                        
                         }
                       
               void _onSelectedDropdown(String selecteditem) {

               setState(() {
        this.firstSelectedItem = selecteditem;
      });
    }

          String _onClaculatedSI() {
              double princples =double.parse(principal.text);
          double rateofi = double.parse(rateOfInterest.text);
          double tim = double.parse(time.text);

          double totalAmountPayble = (princples +(princples*rateofi*tim)/100);
             String result = 'Your result is $totalAmountPayble';

              return result;
  }
        void _reset(){
         principal.text = '';
         rateOfInterest.text= '';
         time .text = '';
         display = '';
  }
         String _onCI(){
              
              double rat= double.parse(rateOfInterest.text);
              double princp =double.parse(principal.text);
              double ti = double.parse(time.text);
              double ci = princp*(pow((1+rat/100), ti));
              String resul = 'your CI is $ci';
              return resul;
           }
}