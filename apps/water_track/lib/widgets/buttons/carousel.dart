import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:water_track/utils/constants.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key, required this.items});
  final Iterable<Widget> items;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.items.toList().asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key ? primaryDark : primary),
                  ),
                );
              }).toList(),
            ),
            CarouselSlider(
              items: widget.items.toList(),
              carouselController: _controller,
              options: CarouselOptions(
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
