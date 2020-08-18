import 'package:ab/widgets/transactionitem.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';


class TransactionList extends StatelessWidget {
   
final   List<Transaction> transactions;
final Function deleteTx;

TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    
    return  transactions.isEmpty
    ? LayoutBuilder(builder: (ctx, constraints)
    {
      return  Column(
        children: <Widget>[
           Text(
              "                       No Transaction added yet!!!                     ",
              style: Theme.of(context).textTheme.headline6,
            ),

            SizedBox(height: 50 ,),

            Container(
              height: constraints.maxHeight * 0.6 ,
              child: Image.asset('assets/image/waiting.png', fit: BoxFit.cover,)
              ),
       ],
      ); 
    }
    )
     
       : ListView(
       children: 
              transactions.map((tx) => Transactionitem(
                key: ValueKey(tx.id),
                transactions: tx,
                 deleteTx: deleteTx,
              )
              ).toList()
          );
          }
             
  }


