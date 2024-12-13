import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';
import 'package:space_app/utils/global.dart';
import 'package:space_app/view/components/my_text.dart';

import '../provider/planet_provider.dart';

class LikedPlanets extends StatelessWidget {
  const LikedPlanets({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final providerTrue = Provider.of<PlanetProvider>(context);
    final providerFalse = Provider.of<PlanetProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        titleSpacing: 1,
        title: MyText(text: "Liked Planets", weight: FontWeight.w400,color: Colors.white,),
          backgroundColor: bgColor,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/bg_image/stars.png"),
          ),
        ),
        child: ListView.builder(
          itemCount: providerTrue.likedPlanets.length,
          itemBuilder: (context, index) {
            final planet = providerTrue.likedPlanets[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              color: Colors.black,
              child: ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ModelViewer(
                    autoRotate: true,
                    backgroundColor: Colors.transparent,
                    src: planet.model,
                    alt: 'A 3D model of an astronaut',
                    disableZoom: true,
                    interactionPrompt: InteractionPrompt.none,
                  ),
                ),
                title: Text(planet.name),
                subtitle: Text(planet.subtitle),
                trailing: IconButton(onPressed: () {
                  providerFalse.removeFromLikePage(planet);
                }, icon: const Icon(Icons.delete_forever)),
              ),
            ),
          );
        },)
      ),
    );
  }
}
