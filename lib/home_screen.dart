import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/PostModel.dart';
void main(){
  runApp(const MaterialApp(home: HomeScreen(),));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List <PostModel> list=[];
  Future<List<PostModel>> getPostApi() async {
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
        for(Map i in data){
              list.add(PostModel.fromJson(i));
        }
        return list;
    }
    else
    {
          return list;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API"),),
      body: Column(
        children:  [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print("Data no aave to");
                    return Text("Loading..");
                  }
                  else {
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index){
                          print("data Avaya nah");
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Title:\n",style:
                                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,)),
                                  Text(list[index].title.toString()),
                                  SizedBox(height: 5,),
                                  Text("Description:\n",
                                    style:TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,),),
                                  SizedBox(height: 5,),
                                  Text("Description\n"+list[index].body.toString()),


                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
       //  Text("Hello This is Rest Api")
        ],
      ),
    );
  }
}
