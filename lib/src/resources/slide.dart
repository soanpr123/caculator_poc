import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  List imgList = [
    'https://cafebiz.cafebizcdn.vn/thumb_w/600/2019/2/8/660x380bi-kip-tiet-kiem-tien-giup-ban-so-huu-tu-vai-trieu-den-vai-chuc-trieu-20180930073051-1549641919566882018590-crop-15496419965141244652081.jpg',
    'https://1.bp.blogspot.com/-MrvtcVV5s8Q/WlSJyiIudZI/AAAAAAAANUw/k3yoYi3i3TAVw6YgAwhbbUT3ytY6uZOGACLcBGAs/s1600/e05243fe-f065-11e7-80c1-56c566ee3692.jpg',
    'https://image.bnews.vn/MediaUpload/Medium/2018/12/08/072257-usd.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Container(
            alignment: Alignment.center,
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CarouselSlider(
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.fill,
                            height: 200,

                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            )));
  }
}
