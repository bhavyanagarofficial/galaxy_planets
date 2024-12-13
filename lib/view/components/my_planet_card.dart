import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:space_app/model/planet_model.dart';
import '../../utils/global.dart';
import '../details_page.dart';
import 'my_text.dart';

class MyPlanetCard extends StatelessWidget {
  final int index;
  final PlanetModel planet;

  const MyPlanetCard({
    super.key,
    required this.index,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.75,
      // decoration: BoxDecoration(color: Colors.green.shade50),
      child: Stack(
        children: [
          //todo ----> Details card
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16,101, 16, 43), // size.height * 0.145
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 22, top: size.height * 0.12),
              decoration: BoxDecoration(
                  color: planetsColor[index].shade50,
                  borderRadius: BorderRadius.circular(12)),
              child: ListView(
                children: [
                  MyText(
                    text: planet.name,
                    weight: FontWeight.w700,
                    size: size.width * 0.052,
                  ),
                  const Gap(14),
                  MyText(text: planet.description, weight: FontWeight.w400)
                ],
              ),
            ),
          ),
          //todo ----> 3d planet
          Positioned(
            left: -8,
            child: FutureBuilder(
              future: precacheImage(AssetImage(planet.model), context),
              // Preload the asset image
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: 180,
                    width: 190,
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
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  );
                }
              },
            ),
          ),
          //todo ----> go to Details page button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.5),
                  shape: BoxShape.circle,
                  color: planetsColor[index]),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(index: index, planet: planet, tag: "Planet $index"),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
