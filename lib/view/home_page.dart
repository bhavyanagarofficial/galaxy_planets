import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:space_app/provider/planet_provider.dart';
import 'package:space_app/utils/global.dart';
import 'package:space_app/view/components/my_planet_card.dart';
import 'package:space_app/view/components/my_text.dart';
import 'package:space_app/view/like_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<PlanetProvider>(context);
    final providerFalse = Provider.of<PlanetProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bg_image/stars.png"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 18, 10, 4),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //todo -------------------> search fields
                    TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade900,
                          hintText: "Search for any planets and stars",
                          hintStyle: const TextStyle(
                              fontFamily: "pop",
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(CupertinoIcons.search)),
                    ),
                    Gap(size.height * 0.027),
                    //todo -------------------> categories
                    myCategories(),
                    Gap(size.height * 0.045),
                    //todo -------------------> planet cards
                    (providerTrue.planetsData.isEmpty)
                        ? const Center(child: CircularProgressIndicator())
                        : CarouselSlider.builder(
                            itemCount: providerTrue.planetsData.length,
                            options: CarouselOptions(
                              // viewportFraction: 0.8,
                              height: size.height * 0.53,
                              // autoPlay: true,
                              // reverse: true,
                              // autoPlayCurve: Curves.fastOutSlowIn,
                              // pageSnapping: true,
                              enlargeCenterPage: true,
                              // enableInfiniteScroll: true,
                            ),
                            itemBuilder: (context, index, realIndex) {
                              final planet = providerTrue.planetsData[index];
                              return MyPlanetCard(
                                index: index,
                                planet: planet,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: myBottomNavBar(context));
  }
}

SingleChildScrollView myCategories() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        categories.length,
        (index) => Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(vertical: 6.5, horizontal: 9),
          decoration: BoxDecoration(
              color: index == 0 ? Colors.white : Colors.black,
              border: Border.all(color: Colors.white70),
              borderRadius: BorderRadius.circular(8)),
          child: MyText(
              text: categories[index],
              weight: FontWeight.w400,
              color: index == 0 ? Colors.black : Colors.white),
        ),
      ),
    ),
  );
}

Container myBottomNavBar(BuildContext context) {
  return Container(
    color: Colors.grey.shade900,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Icon(Icons.home),
        const Icon(
          Icons.category,
          color: Colors.white70,
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LikedPlanets())),
          icon:
              const Icon(Icons.favorite_outline_rounded, color: Colors.white70),
        ),
        const Icon(
          Icons.person_outline_rounded,
          color: Colors.white70,
        ),
      ],
    ),
  );
}
