import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ab/models/transaction.dart';
import 'package:intl/intl.dart';


class Transactionitem extends StatefulWidget {
  const Transactionitem(
    {
    Key key,
    @required this.transactions,
    @required this.deleteTx,
  }) :
   super(key: key);

  final Transaction transactions;
 // final MediaQueryData mediaQuery;
  final Function deleteTx;

  @override
  _TransactionitemState createState() => _TransactionitemState();
}

class _TransactionitemState extends State<Transactionitem> {
  Color _bgColor;

  @override
  void initState() {
    const avalcolors=[
      Colors.purple,
    Colors.green,
    Colors.blueAccent];

    _bgColor=avalcolors[Random().nextInt(2)];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 5, 
      horizontal: 5),
                    child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
                              child: FittedBox(
              child: Text(
                'Rs: ' + widget.transactions.amount.toStringAsFixed(0))),
          ),
        ),
        title: Text(widget.transactions.title,
        style: Theme.of(context).textTheme.headline6,),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transactions.date)
          ),
          
          trailing:  MediaQuery.of(context).size.width> 360 ? 
           FlatButton.icon(  
             textColor: Theme.of(context).errorColor,
             onPressed: widget.deleteTx(widget.transactions.id),
              icon: const Icon(Icons.delete),
               label: const Text("Delete"))
           : IconButton(
            icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx(widget.transactions.id),
          
          ),     
          ),
    );
  }
}