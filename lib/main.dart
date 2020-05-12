import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget  {
  @override
_HomepageState createState() => _HomepageState();
}
  class _HomepageState extends State<MyApp> {

    //init global variable list.

    ScrollController scrollController = new ScrollController();

    List data=[];
    List<String> name=[];
    List<String> imgUrl=[];
    bool show=false;
    List data1=[];
    List<String> name1=[];
    List<String> imgUrl1=[];
    bool show1=false;
    bool txt=false;
    bool txt1=false;
@override
void dispose(){
scrollController.dispose();
super.dispose();
}
    //getting json data 
    getjsondata() async {

      //first coolection of images
    http.Response response= await http.get('https://api.unsplash.com/collections/1580860/photos/?client_id=your_APIkey');
    if(response.statusCode == 200)
      data = json.decode(response.body);

       //second coolection of images
      http.Response response1= await http.get('https://api.unsplash.com/collections/139386/photos/?client_id=your_APIkey');
      if(response1.statusCode == 200)
      data1 = json.decode(response1.body);
      assign();

      //if images are added in list then make it true for displaying 
      setState(() {
        show=true;
        show1=true;
      });
    
    }
@override
void initState(){
  super.initState();
  scrollController.addListener(() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
    assign();
  });
}
    //storing to the list by of 8 view card
    assign(){

      for(var i=0;i<data.length;i++){
      imgUrl.add((data.elementAt(i)["urls"]["small"]).toString());

      if(data.elementAt(i)["description"] != null)
      name.add(data.elementAt(i)["description"]);
      else
      name.add(data.elementAt(i)["alt_description"]);
      }

      for(var i=0;i<data1.length;i++){
      imgUrl1.add((data1.elementAt(i)["urls"]["small"]).toString());

      if(data1.elementAt(i)["description"] != null)
      name1.add(data1.elementAt(i)["description"]);
      else
      name1.add(data1.elementAt(i)["alt_description"]);
      }
    }
      @override
      Widget build(BuildContext context) {
        getjsondata();

        //gridview fro tab layout
        var gridView = new GridView.builder(

        //scroll controller
          controller: scrollController,

          padding: EdgeInsets.only(top: 10),
            itemCount: data.length,
            gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, ),
            itemBuilder: (BuildContext context, int index) {
              //if !(description are null for both desc and additional desc then make it false)
                if(name.elementAt(index)!= null)
                  txt=true;
                  else txt=false;
                
              return new GestureDetector(
                child: new Card(
        
                        margin: EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                  elevation: 5.0,
                  child: Column(
                    
              children: <Widget>[

                //image in card view
                FadeInImage.assetNetwork(
                            placeholder: 'assets/830.gif',
                            image: imgUrl.elementAt(index),
                            fit: BoxFit.fitWidth,
                            height: 150,
                            alignment: Alignment.topCenter,
                          ),
                          //text bottom of image in card view

                if(txt)       //checking fro null if both desc and add desc is null or not
                Text(name.elementAt(index),style: TextStyle(color: Colors.blueGrey, fontSize: 14 ))
                else
                Text("nature",style: TextStyle(color: Colors.blueGrey,fontSize: 14 ))
                
              ],
        
                ),
                ),
              );
              
            });
            //gridview for second tab layout
        var gridView1 = new GridView.builder(
             //scroll controller
          controller: scrollController,

          padding: EdgeInsets.only(top: 10),
            itemCount: data1.length,
            gridDelegate:
                new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {

                //if !(description are null for both desc and additional desc then make it false)
                if(name1.elementAt(index)!= null)
                  txt1=true;
                  else txt1=false;
              return new GestureDetector(
                
                child: new Card(
        
                        margin: EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                  elevation: 5.0,
                  child: Column(
                    
              children: <Widget>[

          //image view in card
                FadeInImage.assetNetwork(
                  
                            placeholder: 'assets/830.gif',
                            image: imgUrl1.elementAt(index),
                            fit: BoxFit.fitWidth,
                          
                            height: 150,
                          
                            alignment: Alignment.topCenter,
                          ),
                //text bottom of image in card view

                if(txt1)       //checking fro null if both desc and add desc is null or not
                Text(name1.elementAt(index),style: TextStyle(color: Colors.blueGrey,fontSize: 14 ))
                else
                Text("pets",style: TextStyle(color: Colors.blueGrey,fontSize: 14 ))
                
              ],
        
                ),
                ),
                
              );
              
            });
            
            
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
            
                primarySwatch: Colors.blue,
              
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: DefaultTabController(length: 2,child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Flutter App', style: TextStyle(color:Colors.redAccent),),
                  backgroundColor: Colors.white,
                elevation: 0,
                  bottom: TabBar(
              
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent
                    ),
                    tabs:[
                   
                  Tab(
                
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:Border.all(
                              color: Colors.redAccent,
                              width: 1
                            )
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child:  Text("Pets"),
                          ),
                        ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color:Colors.redAccent,
                            width:1
                          )
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Nature"),
                        ),
                      ),),
                      
                  ]),
                  
                ),

                //main body with tabbar view and  gridview
                body: TabBarView(children: [gridView1,gridView,]),
            ),
            )
            
        );
      
    }

}