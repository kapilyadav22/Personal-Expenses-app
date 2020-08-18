import 'package:ab/widgets/adaptive.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'adaptive.dart';

class NewTransaction extends StatefulWidget 
{
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final _titlecontroller= TextEditingController();
final _amountcontroller= TextEditingController(); 

DateTime _selectedDate;

@override
  void initState() {

    super.initState();
  }


  @override
  void didUpdateWidget(NewTransaction oldWidget) {

    super.didUpdateWidget(oldWidget);
  }

@override
  void dispose() {

    super.dispose();
  }


void _submitdata()
{ 
if(_amountcontroller.text.isEmpty)
{ return ;} 

final enteredtitle=_titlecontroller.text;
final enteredamount=double.parse(_amountcontroller.text);

if(enteredtitle.isEmpty || enteredamount<=0 || _selectedDate== null)
{ return; }

widget.addTx(  
  enteredtitle,
  enteredamount,
  _selectedDate,  
   );
      Navigator.of(context).pop();   //closing the modal sheet if open at pop  
}

void _presentdatepicker()
{
  showDatePicker(context: context,
   initialDate: DateTime.now(),
    firstDate: DateTime(2011),
     lastDate: DateTime.now(), 
    ).then((pickedDate) {
          if(pickedDate==null)
          { return;   }
         setState(()
          {
        _selectedDate = pickedDate;
          } );
    });
}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  SingleChildScrollView(
          child: Card(
               elevation: 5,
               child: Container(
                    padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom:  mediaQuery.viewInsets.bottom + 20,

                    ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.end , 
                 children: <Widget> [
                      //CupertinoTextField(),

                 TextField(decoration: InputDecoration(labelText: "Title"),
                 controller: _titlecontroller,
                 
                 onSubmitted: (_) => _submitdata(),    //to submit the title when we enter right tick from keyboard
               
                 ),
                  TextField(decoration: InputDecoration(labelText: "Amount"),
                 controller: _amountcontroller,
                 keyboardType: TextInputType.number,
                  onSubmitted: (_)=> _submitdata(),   //to submit the amount when we enter right tick from keyboard            
                    ), 
                  Container(
                    height: 50,
                    child: Row(children: <Widget>[
                Expanded(
                  child: Text(_selectedDate ==null? 
                  'NO Date Chosen!': 
                  'Picked Date ' + DateFormat.yMMMMEEEEd().format(_selectedDate)
                  )
                  ),
               Adaptiveflatbutton("Chose date", _presentdatepicker),
                    ],),
                  ),

                 RaisedButton(
                   color: Colors.purple,
                   child: const Text("Add transaction"),
                   textColor: Theme.of(context).textTheme.button.color,
                   onPressed: () {
                     _submitdata();  //it is just to refer to the submitdata function             
                       },
                   ),
             ],),
               ),

      ),
    );
  }
}