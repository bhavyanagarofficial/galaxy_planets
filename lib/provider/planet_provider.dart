import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/planet_model.dart';

class PlanetProvider extends ChangeNotifier{

  List<PlanetModel> planetsData = [];
  List<PlanetModel> likedPlanets = [];
  List<bool> likedList = [];

  Future<void> loadPlanetData() async {
    try{
      final jsonData = await rootBundle.loadString("assets/json/data.json");
      List data = jsonDecode(jsonData);
      planetsData = data.map((e) => PlanetModel.fromJson(e)).toList();
      likedList = List.filled(planetsData.length, false);
      notifyListeners();
    }catch(e){
      log("Error into load planets data from json object to string -> $e");
    }
  }

  void toggleLike(int index) {

    likedList[index] = !likedList[index];

    if (likedList[index]) {
      likedPlanets.add(planetsData[index]);
    } else {
      likedPlanets.remove(planetsData[index]);
    }
    notifyListeners();
  }

  void removeFromLikePage(PlanetModel planet){
    for(int i=0; i<likedPlanets.length; i++){
      if(likedPlanets[i].name == planet.name){
        likedList[i] = false;
        likedPlanets.removeAt(i);
        notifyListeners();
        break;
      }
    }
    notifyListeners();
  }

  PlanetProvider(){
    loadPlanetData();
  }

}