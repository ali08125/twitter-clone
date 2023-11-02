import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key, required this.imageLinks});

  final List<String> imageLinks;

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final carouselController = CarouselController();
  final pageController = PageController();
  var _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
                carouselController: carouselController,
                items: widget.imageLinks.map((image) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      image,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                )),
            Row(
              children: widget.imageLinks.asMap().entries.map((e) {
                return Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(_current == e.key ? 0.9 : 0.4)),
                );
              }).toList(),
            )
          ],
        )
      ],
    );
  }
}
