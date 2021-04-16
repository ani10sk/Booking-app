import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/food_items.dart';
import '../screens/fooddeco.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isWaiting=false;
  @override
  void didChangeDependencies(){
    print('hello');
    setState(() {
      isWaiting=true;
    });
    Provider.of<FoodItems>(context,listen: false).getRandomFood().then((value) => setState((){isWaiting=false;}));
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Super Meal'),
      ),
      body: isWaiting?Center(child:CircularProgressIndicator()):
      //Center(child:Text('Succesful')),
      Consumer<FoodItems>(
        builder: (ctx,item,_)=>item.random.length==0?Center(child:Text('No items available')):
        ListView.builder(
          itemCount:item.random.length,
          itemBuilder:(ctx,i)=>InkWell(
            onTap: ()=>Navigator.of(context).pushNamed(FoodDeco.rout,arguments: {'idMeal':item.random[i].idMeal}),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height:MediaQuery.of(context).size.height*.5,
                child: GridTile(
                  child:Image.network(item.random[i].strMealThumb,fit:BoxFit.contain,),
                  //footer: Text(item.random[i].strMeal,style:TextStyle(color:Colors.white),),
                  footer: Padding(
                    padding:EdgeInsets.all(6),
                    child: Text(
                      item.random[i].strMeal,
                      style:TextStyle(color:Colors.white,backgroundColor:Colors.black,fontSize:20,),
                    ),
                  ),
                  header: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      item.random[i].isFavorite?Icons.favorite:Icons.favorite_border,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed:(){
                      setState(() {
                        item.random[i].isFavorite=!item.random[i].isFavorite;
                      });
                    },
                  )),
                ),
              ),
            ),
          )
        )
      );
  }
}