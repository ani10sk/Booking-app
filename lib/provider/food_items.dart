import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './food_item.dart';
import 'dart:convert';

class FoodItems extends ChangeNotifier{
  List<FoodItem> random=[];
  Future<void> getRandomFood()async{
    const url='http://www.themealdb.com/api/json/v1/1/random.php';
    try{
      final response=await http.get(url);
      final responseData=json.decode(response.body) as Map<String,dynamic>;
      //print(responseData);
      for(int i=0;i<responseData['meals'].length;i++){
        random.add(
          FoodItem(
            idMeal: responseData['meals'][i]['idMeal'],
            strMeal: responseData['meals'][i]['strMeal'],
            strCategory: responseData['meals'][i]['strCategory'],
            strArea: responseData['meals'][i]['strArea'],
            strInstructions: responseData['meals'][i]['strInstructions'],
            strMealThumb: responseData['meals'][i]['strMealThumb'],
            strTags: responseData['meals'][i]['strTags'],
            strYoutube: responseData['meals'][i]['strYoutube'],
            isFavorite: false
          )
        );
      }
    }catch(error){
      print(error);
    }
    notifyListeners();
  }

  FoodItem getById(String idMeal){
    for(int i=0;i<random.length;i++){
      if(idMeal==random[i].idMeal){
        return random[i];
      }
    }
  }
}