import 'package:flutter/material.dart';
import '../models/transaction.dart'; 
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {

final List<Transaction> recentTransactions;

Chart(this.recentTransactions);

List<Map<String,Object>>  get grouptransactionvalues
{
return List.generate(7,(index) {
  final weekday = DateTime.now().subtract(Duration(days: index),);
  
  double totalsum =0.0;

  for(var i=0; i < recentTransactions.length;i++)
  {
    if(recentTransactions[i].date.day==weekday.day 
    && recentTransactions[i].date.month==weekday.month
    && recentTransactions[i].date.year==weekday.year)  
    {  totalsum+=recentTransactions[i].amount; }
  } 

   return   {
     'day': DateFormat.E().format(weekday).substring(0,3), 
   'amount': totalsum};
   
}).reversed.toList();
}
  
double get totalSpending{
  return grouptransactionvalues.fold(0.0, (sum, item) { 
      return sum + item['amount'];
  });
}

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 15,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: grouptransactionvalues.map((data)
          { 
            return  Flexible( 
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],  
                data['amount'],
               totalSpending == 0.0 ? 0.0 :  ( data['amount']as double)/totalSpending));
          }).toList(),
          ),
        ),
        
    );
  }
}