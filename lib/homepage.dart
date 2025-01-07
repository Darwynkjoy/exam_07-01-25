import 'package:exam_books/book_form.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{
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
        return Container(
          height: 220,
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(255, 220, 239, 255),
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title                           :",style: TextStyle(fontSize: 18,color: Colors.black),),
                  Text("Author                       :",style: TextStyle(fontSize: 18,color: Colors.black),),
                  Text("Genere                      :",style: TextStyle(fontSize: 18,color: Colors.black),),
                  Text("Year of publication :",style: TextStyle(fontSize: 18,color: Colors.black),),
                  Text("Rating                       :",style: TextStyle(fontSize: 18,color: Colors.black),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: (){}, child: Icon(Icons.edit,color: Colors.white,)),
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: (){}, child: Icon(Icons.delete,color: Colors.white,))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context,index){return SizedBox(height: 20,);},
      itemCount: 2),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push((context), MaterialPageRoute(builder: (context)=>Formpage()));
        },
        child: Icon(Icons.add_outlined,color: Colors.white,),
        ),
    );
  }
}