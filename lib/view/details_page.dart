import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';
import '../provider/planet_provider.dart';
import '../utils/global.dart';
import 'components/my_text.dart';

class DetailsPage extends StatelessWidget {
  final int index;
  final PlanetModel planet;
  final String tag;

  const DetailsPage(
      {super.key,
      required this.index,
      required this.planet,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<PlanetProvider>(context);
    final providerFalse = Provider.of<PlanetProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bg_image/star2.png"),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bg_image/star2.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //todo ------------------> body in 2 parts
            Center(
              child: Column(
                children: [
                  //todo ------------------> img
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: 210,
                      child: ModelViewer(
                        autoRotate: true,
                        backgroundColor: Colors.transparent,
                        src: planet.model,
                        alt: 'A 3D model of an astronaut',
                        disableZoom: true,
                        interactionPrompt: InteractionPrompt.none,
                      ),
                    ),
                  ),
                  //todo ------------------> details
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 12, 14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                    text: "${planet.name}🛰️",
                                    weight: FontWeight.w800,
                                    color: Colors.white,
                                    size: size.width * 0.05,
                                    maxLines: 1),
                                IconButton(
                                  onPressed: () {
                                    providerFalse.toggleLike(index);
                                  },
                                  icon: Icon(
                                    providerTrue.likedList[index]
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_outline_rounded,
                                    color: providerTrue.likedList[index]
                                        ? Colors.red
                                        : null,
                                  ),
                                )
                              ],
                            ),
                            MyText(
                                text: "${planet.subtitle}🚀",
                                weight: FontWeight.w500,
                                color: Colors.white,
                                size: size.width * 0.042),
                            const Gap(6),
                            MyText(
                                text: "Distance from sun",
                                weight: FontWeight.w400,
                                color: Colors.white70),
                            MyText(
                                text: "${planet.distance} million km",
                                weight: FontWeight.w400,
                                color: Colors.white),
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    MyText(
                                        text: "Surface area",
                                        weight: FontWeight.w400,
                                        color: Colors.white70),
                                    MyText(
                                        text: planet.surface_area,
                                        weight: FontWeight.w400,
                                        color: Colors.white),
                                  ],
                                ),
                                Column(
                                  children: [
                                    MyText(
                                        text: "Orbital Period",
                                        weight: FontWeight.w400,
                                        color: Colors.white70),
                                    MyText(
                                        text: planet.orbital_period,
                                        weight: FontWeight.w400,
                                        color: Colors.white),
                                  ],
                                )
                              ],
                            ),
                            const Gap(6),
                            MyText(
                                text: planet.description,
                                weight: FontWeight.w400,
                                color: Colors.white70),
                            const Gap(5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
