import 'dart:io';
import './widgets/new_transaction.dart';
import './widgets/transactionlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Expense App',
    debugShowCheckedModeBanner: false,
    // Image.asset('assets/image/Group1.jpg'),
      
      theme: ThemeData
      ( //setting default theme here, if we manually change somewhere, then that will be consider
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        errorColor: Colors.redAccent,
        canvasColor: Colors.white,//create different shades of that color
        fontFamily: 'Quicksand', // setting  default font in theme

        textTheme: ThemeData.light().textTheme.copyWith(
           headline6: TextStyle(
              fontFamily: 'OpenSans',
               fontSize: 18,
               fontWeight: FontWeight.bold,   
),
        button: TextStyle(color: Colors.white),
          ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
           headline6: TextStyle(
              fontFamily: 'OpenSans',
               fontSize: 20,
               fontWeight: FontWeight.bold,          
               )
                ),
        )
      ),
      
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver
{

@override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    

    super.didChangeAppLifecycleState(state);
  }

@override
  void dispose() {
WidgetsBinding.instance.removeObserver(this);    

    super.dispose();
  }


  final List<Transaction> _userTransactions = [];
 bool _showChart= false;
 
  List <Transaction> get _recentTransactions
  {
    return _userTransactions.where((tx) 
    { 
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context)
  { 
    final mediaQuery = MediaQuery.of(context);
   final isLandscape = mediaQuery.orientation==
   Orientation.landscape;
          
    final PreferredSizeWidget appBar= Platform.isIOS?
    
     CupertinoNavigationBar(
      middle: Text("Personal Expenses"),
   
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        GestureDetector(
          child: Icon(CupertinoIcons.add),
        onTap: ()
           {
              startatnewtransaction(context);
           },
           ),
    ],
    ),
    ) 
    : 
    
    AppBar(
         actions: <Widget>[
           IconButton(icon: Icon(Icons.add),
           onPressed: ()
           {
              startatnewtransaction(context);
           },),
         ],
    
        title: Text('Basic Expense App',style:TextStyle(fontFamily: 'OpenSans')),
      );

final txListWidget= Container(
                 height: (mediaQuery.size.height -
                  appBar.preferredSize.height-
                   mediaQuery.padding.top) * 0.7,
         decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/Group1.jpg"),
                      fit: BoxFit.fill)), 
             child: TransactionList(_userTransactions,_deleteTransaction)
             );

final pageBody = SafeArea(child: SingleChildScrollView(
        child: 
        
        Column
    (
     mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
    if(isLandscape) ..._builderLanscapeContent(mediaQuery,
  appBar,
  txListWidget,),
  if(!isLandscape)
    ..._builderPortraitCOntent(mediaQuery,appBar,txListWidget 
    )],
        ),
      ),
      );



    return Platform.isIOS  
    ? 
      CupertinoPageScaffold(
        child: pageBody,
        navigationBar: appBar,
        )
    :
    Scaffold(
      appBar: appBar,
      body: pageBody,

floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Platform.isIOS ? 
      Container():  
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()
        {
 startatnewtransaction(context);
        },
        ),
      );
  }
void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate)
{

  final newTx= Transaction(
    title: txtitle, 
    amount: txamount,
    date: chosenDate,
  id: DateTime.now().toString(), 
  );

setState(() {
  _userTransactions.add(newTx);
});

}

void startatnewtransaction(BuildContext ctx)
{
showModalBottomSheet(context: ctx, builder: (context) 
{
  return GestureDetector(
    onTap: ()
     {},
    child: NewTransaction(_addNewTransaction),
    behavior: HitTestBehavior.opaque);

});

}

void _deleteTransaction(String id)
{ setState(() {
  _userTransactions.removeWhere((tx) => tx.id==id);
}
);}


 List <Widget> _builderLanscapeContent(MediaQueryData mediaQuery,
 AppBar appBar,
 Widget txListWidget,)
 {

return   [Row(  
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>
           [
             Text("Show Chart", 
             style: Theme.of(context).textTheme.headline6,
             ),
             Switch.adaptive(
               activeColor: Theme.of(context).accentColor,
               value: _showChart, 
               onChanged: (val)
             {
               setState(()
                {
                 _showChart=val;
               });
             },),
           ]
   ),
   _showChart
     ?  Container(
             height: ( mediaQuery.size.height -
              appBar.preferredSize.height-
               mediaQuery.padding.top) * 0.5,
             child: Chart(_recentTransactions),
             )
             : 
             txListWidget ];
 }
 
 List <Widget> _builderPortraitCOntent(
   MediaQueryData mediaQuery,
 AppBar appBar,
 Widget txListWidget,
 )
 {
return [Container(
             height: ( mediaQuery.size.height -
              appBar.preferredSize.height-
               mediaQuery.padding.top) * 0.3,
             child: Chart(_recentTransactions)
             )
,txListWidget ];
             
             ;
 }
}