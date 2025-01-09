import 'package:exam_books/book_form.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{
  late Box box;
  List<Map<String,dynamic>> bookItems=[];

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
        title: Text("Books",style: TextStyle( color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(itemBuilder: (context,index){
        final books=bookItems[index];
        return Card(
          elevation: 10,
          color: const Color.fromARGB(255, 220, 239, 255),
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title                           :${books["title"]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                Text("Author                       :${books["Author"]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                Text("Genere                      :${books["Genere"]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                Text("Year of publication :${books["year"]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                Text("Rating                       :${books["Rating"]}",style: TextStyle(fontSize: 18,color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      iconColor: Colors.black,
                      itemBuilder: (BuildContext context){
                      return [
                        PopupMenuItem(
                          child: TextButton.icon(onPressed: (){},
                          label: Text("Edit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),)
                          ),
                        PopupMenuItem(
                          child: TextButton.icon(onPressed: (){},
                          label: Text("Delete",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),)
                          ),
                      ];
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context,index){return SizedBox(height: 20,);},
      itemCount: bookItems.length),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push((context), MaterialPageRoute(builder: (context)=>Formpage()));
          loadBooks();
        },
        child: Icon(Icons.add_outlined,color: Colors.white,),
        ),
    );
  }
}