import 'package:badee_calculator/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Item> items=[];
  bool showEndUser = false;

  String totalPriceTxt1='Total price:';
  String vatTxt1='Vat:';
  String totalWithVatTxt1='Total with vat:';

  ///////////////////////////////////////////////////////////////////
  String totalPriceTxt2='Total price:';
  String vatTxt2='Vat:';
  String totalWithVatTxt2='Total with vat:';

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController vendorPriceUnit = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController ben = TextEditingController();

  calculate(){
    //if(vendorPriceUnit.text.isNotEmpty&&qty.text.isNotEmpty&&vat.text.isNotEmpty){
        double v = double.parse(vat.text.isEmpty?'0':vat.text.toString());
        double priceUnit = double.parse(vendorPriceUnit.text.isEmpty?'0':vendorPriceUnit.text.toString());
        int qty = int.parse(this.qty.text.isEmpty?'1':this.qty.text.toString());
        double benefit= double.parse(ben.text.isEmpty?'0':ben.text.toString());
        setState(() {

          totalPriceTxt1='Total price: ${qty*priceUnit}';
          vatTxt1='Vat: ${v*qty*priceUnit/100}';
          totalWithVatTxt1='Total with vat: ${(v*qty*priceUnit/100)+(qty*priceUnit)}';

         // if(ben.text.isNotEmpty){
            double total =(qty*priceUnit*benefit/100)+(qty*priceUnit);
            totalPriceTxt2='Total price: ${total.toString()}';
            vatTxt2='Vat: ${v*total/100}';
            totalWithVatTxt2='Total with vat: ${(v*total/100)+(total)}';

          //}


        });


  }

  addItem(){
////////////////////////////////////////////////////
    double v = double.parse(vat.text.isEmpty?'0':vat.text.toString());
    double priceUnit = double.parse(vendorPriceUnit.text.isEmpty?'0':vendorPriceUnit.text.toString());
    int qty = int.parse(this.qty.text.isEmpty?'1':this.qty.text.toString());

    double benefit= double.parse(ben.text.isEmpty?'0':ben.text.toString());

    totalPriceTxt1='Total price: ${qty*priceUnit}';
    vatTxt1='Vat: ${v*qty*priceUnit/100}';
    totalWithVatTxt1='Total with vat: ${(v*qty*priceUnit/100)+(qty*priceUnit)}';

    double total =(qty*priceUnit*benefit/100)+(qty*priceUnit);
    totalPriceTxt2='Total price: ${total.toString()}';
    vatTxt2='Vat: ${v*total/100}';
    totalWithVatTxt2='Total with vat: ${(v*total/100)+(total)}';

    /////////////////////////////////

    Item item = Item(
      id: (++_counter).toString(),
      benefit:ben.text.isEmpty?'0':ben.text.toString(),
    description: desc.text.toString(),
      title: title.text.toString(),
      quantity: this.qty.text.isEmpty?'1':this.qty.text.toString(),
      vat: v.toString(),
      vendorName: vendorName.text.toString(),
      vendorPriceUnit: vendorPriceUnit.text.isEmpty?'0':vendorPriceUnit.text.toString(),
      totalPrice1: (qty*priceUnit).toString(),
      totalVat1: (v*qty*priceUnit/100).toString(),
      priceWithVat1: ((v*qty*priceUnit/100)+(qty*priceUnit)).toString(),
      totalPrice2: (total.toString()).toString(),
      totalVat2: (v*total/100).toString(),
      priceWithVat2: ((v*total/100)+(total)).toString(),
    );

    items.add(item);


        }
clear(){
 setState(() {
   title.clear();
   desc.clear();
   vendorName.clear();
   qty.clear();
   vendorPriceUnit.clear();
   vat.clear();
   ben.clear();
 });
}

sendFile()async{

    int i = 1;
    if(items.isEmpty){
      return;
    }
    print(items.length);

    String text='';

    items.forEach((element) {
      text=text+'(${i})\ntitle:${element.title}\ndescription:${element.description}\nvendor name:${element.vendorName}\n';
      text= text+'quantity:${element.quantity}\nvendor price unit:${element.vendorPriceUnit}\nvat:${element.vat}\n';
      text=text+'total price:${element.totalPrice1}\ntotal vat:${element.totalVat1}\ntotal with vat:${element.priceWithVat1}\n';
      text=text+'benefit:${element.benefit}\ntotal price:${element.totalPrice2}\ntotal vat:${element.totalVat2}\ntotal with vat:${element.priceWithVat2}\n';
    text=text+'===================================================================\n';
    i++;
    });



  Directory? directory = Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory(); //FOR iOS
    final File file = File('${directory!.path}/my_file.txt');
    await file.writeAsString(text);
    print(file.path);
    Share.shareFiles(['${file.path}'], text: 'Great picture');


}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: items.map((e) => ListTile(leading: Text('${e.quantity}X${e.title}',style: TextStyle(color: Colors.black),),trailing: InkWell(
                child: Icon(Icons.delete_forever,color: Colors.black,),
                onTap: (){
                  setState(() {
                    items.removeWhere((element) => element.id==e.id);
                  });
                },
              ),)).toList(),),
              SizedBox(height:5),
              BasicTextField(hint: 'title',controller: title,),
              SizedBox(height:5),
              BasicTextField(hint: 'description',controller: desc,),
              SizedBox(height:5),
              BasicTextField(hint: 'vendor name',controller: vendorName,),
              SizedBox(height:5),
              BasicTextField(hint: 'quantity',isPrice: true,controller:qty),
              SizedBox(height:5),
              BasicTextField(hint: 'vendor price unit',isPrice:true,controller: vendorPriceUnit,),
              SizedBox(height:5),
              BasicTextField(hint: 'vat',isPrice:true,controller: vat,),
              SizedBox(height:5),
              Text(totalPriceTxt1,style: TextStyle(color: Colors.black),),
              Text(vatTxt1,style: TextStyle(color: Colors.black),),
              Text(totalWithVatTxt1,style: TextStyle(color: Colors.black),),

              SizedBox(height:5),
              ElevatedButton(onPressed: (){
                if(!showEndUser){
                  setState(() {
                    showEndUser = true;
                  });
                }
              }, child: Text('Add end user')),

              if(showEndUser)
                Column(children: [
                  BasicTextField(hint: 'benefit',isPrice: true,controller: ben,),
                  SizedBox(height:5),
                  Text(totalPriceTxt2,style: TextStyle(color: Colors.black),),
                  Text(vatTxt2,style: TextStyle(color: Colors.black),),
                  Text(totalWithVatTxt2,style: TextStyle(color: Colors.black),),

                ],),
              SizedBox(height:5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                ElevatedButton(onPressed: (){
                  calculate();

                }, child: Text('Edit')),
                ElevatedButton(onPressed: (){

                  addItem();
                  clear();
                  print(items.length);
                }, child: Text('Add new item')),
                ElevatedButton(onPressed: (){
                  sendFile();
                  clear();
                }, child: Text('Send')),
              ]),
            ],
          ),
        ),
      ),
  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
class Item{
  String? id;
  String? title;
  String? description;
  String? vendorName;
  String? quantity;
  String? vendorPriceUnit;
  String? vat;
  String? benefit;
///////////////////////////
  String? totalPrice1;
  String? totalVat1;
  String? priceWithVat1;

  String? totalPrice2;
  String? totalVat2;
  String? priceWithVat2;

  Item(
      {this.id,
        this.title,
      this.description,
      this.vendorName,
      this.quantity,
      this.vendorPriceUnit,
      this.vat,
      this.benefit,
      this.totalPrice1,
      this.totalVat1,
      this.priceWithVat1,
      this.totalPrice2,
      this.totalVat2,
      this.priceWithVat2});
}