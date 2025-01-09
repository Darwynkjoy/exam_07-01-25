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

  List<Map<String,dynamic>> bookItems=[];
  late Box box;

  openbox()async{
    box=await Hive.openBox("boxbooks");
    loadBooks();
  }

  void initState(){
    super.initState();
    openbox();
  }

    void loadBooks(){
    List <dynamic> book=box.get("books")?.cast<dynamic>();
    if(book != null){
      setState(() {
        bookItems=List<Map<String,dynamic>>.from(book);
      });
    }
    else{
      setState(() {
        bookItems=[];
      });
    }
    print("books loaded:$bookItems");
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
                    bookItems!.add({
                      "title":titlecontroller.text,
                      "author":authorcontroller.text,
                      "genere":generecontroller.text,
                      "year":yearcontroller.text,
                      "rating":yearcontroller.text,
                    });
                    box.put("books", bookItems);
                    titlecontroller.clear();
                    authorcontroller.clear();
                    generecontroller.clear();
                    yearcontroller.clear();
                    ratingcontroller.clear();
                    print("this is box values:${box.values}");
                    print("book items:${bookItems}");
                  });
                  Navigator.pop(context);
                }, child: Text("Add book",style: TextStyle(fontSize: 20,color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}