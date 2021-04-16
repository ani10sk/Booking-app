import 'package:bkngapp/provider/food_item.dart';
import 'package:bkngapp/provider/food_items.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDeco extends StatelessWidget{
  static const rout='food-deco';
  
  //FoodDeco(this.idMeal);
  Widget build(BuildContext context){
    final routArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String idMeal=routArgs['idMeal'];
    FoodItem item=Provider.of<FoodItems>(context,listen: false).getById(idMeal);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text(item.strMeal),
      ),
      body:Padding(
        padding:EdgeInsets.all(8),
        child:SingleChildScrollView(
          child: Column(
            children:[
              Image.network(item.strMealThumb),
              Text(item.strMeal,style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Text(item.strArea,style:TextStyle(fontWeight:FontWeight.bold),),
              Text(item.strCategory,style:TextStyle(fontWeight:FontWeight.bold),),
              Text(item.strInstructions),
              item.strYoutube!=''?
              Text('The link to video is given below',style:TextStyle(fontWeight:FontWeight.bold),):SizedBox(),
              InkWell(
                onTap:()=>launch(item.strYoutube),
                child:Text(item.strYoutube)
              )
            ]
          ),
        )
      ),
    );
  }
}