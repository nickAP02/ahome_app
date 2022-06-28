import 'dart:convert';
import 'package:ago_ahome_app/model/room.dart';
import 'package:ago_ahome_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 final client = http.Client();
 Future<List<Room>> getRooms() async{
    final response = await client.get(Uri.parse('http://192.168.165.149:5000/api/v1/rooms'));
    print(response.toString());
    //print(response.statusCode);
    if(response.statusCode == 200){
      try{
        var data = json.decode(response.body);
        print(data.toString());
        return data.map<Room>((json)=>Room.fromJson(json)).toList();
      }on NoSuchMethodError catch (_, n){
        throw n.toString();
      }
    }  
    
    else{
      throw Exception("La requête n'a pas aboutie : ${response.statusCode}");
    }
  }
class NavBar extends StatefulWidget {

  NavBar();

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  final HttpService httpService = HttpService();
  int currentPageIndex = 0;
  Future<List<Room>> ?rooms;
  var isLoaded = false;
  //late TabController _tabController =  TabController(length: rooms!.length, vsync: this);
@override
  void initState() {

    super.initState();
    //getRooms();
    //print(rooms);
    //final roomModel = Provider.of<RoomProvider>(context, listen:false);
    getRooms();
    // getRooms().then((value) =>{
    //   print(value),
    //   rooms = value as Future<List<Room>>?,
    //   print(rooms)
    // });
    //print(rooms.toString());
  }

  @override
  Widget build(BuildContext context) {
    //final roomModel = Provider.of<RoomProvider>(context);
    return FutureBuilder<List<Room>?>(
      future: getRooms(),
      builder:(context,snapshot){
        // if(snapshot.data!.isEmpty){
          // return Center(child: Text("${snapshot.data}"));
        // }
        // print(snapshot.data!.iterator.moveNext());
        print(snapshot.hasData);
        //print(snapshot.data);
        //print(snapshot.connectionState);
          if(snapshot.connectionState == ConnectionState.none || snapshot.hasData==false){
            return const Center(child: Text("Pas de pièces disponibles"));
          }
          else if(snapshot.connectionState == ConnectionState.done || snapshot.hasData == true){
              return DefaultTabController(
                length: snapshot.data!.length,
                child:Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors.black12,
                      //indicatorSize: TabBarIndicatorSize.tab,
                        controller: TabController(length:snapshot.data!.length, vsync: this),
                        tabs: snapshot.data!.map((e) => Tab(text:e.categorie)).toList()
                      ),
                  ),
                ] 
                )
              );
          }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        }

        return const Center(child: Text("Il n'y a rien qui se passe"));
    }
    );
  }
}