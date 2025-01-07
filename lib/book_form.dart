import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Formpage extends StatefulWidget{
  @override
  State<Formpage> createState()=> _formpageState();
}
class _formpageState extends State<Formpage>{

  TextEditingController titlecontroller=TextEditingController();
  TextEditingController authorcontroller=TextEditingController();
  TextEditingController generecontroller=TextEditingController();
  TextEditingController yearcontroller=TextEditingController();
  TextEditingController ratingcontroller=TextEditingController();

  late Box box;
  List<Map<String,dynamic>> books=[];

    openbox()async{
    box=await Hive.openBox("books");
    loadBooks();
  }

   void loadBooks()async{
    List<Map<String,dynamic>>? bookItems=box.get("books")?.cast<String>();
    if(bookItems !=null){
      setState(() {
       books=bookItems; 
      });
    }
  }

  void saveBooks()async{
    await box.put("Books", books);
  }

  void addbookItems(String books){
    if(books.isNotEmpty){
      setState(() {
        books.add(books);
      });
    }
    saveBooks();
    titlecontroller.clear();
    authorcontroller.clear();
    generecontroller.clear();
    yearcontroller.clear();
    ratingcontroller.clear();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Book Database",style: TextStyle( color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: authorcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                hintText: "Author",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: generecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                hintText: "Genere",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: yearcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                hintText: "Year of publication",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: ratingcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                hintText: "Rating",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.blue,
                ),
                onPressed: (){
                  setState(() {
                    saveBooks();
                  });
                }, child: Text("Add book",style: TextStyle(fontSize: 20,color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}