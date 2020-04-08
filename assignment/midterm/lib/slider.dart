import 'package:Shrine/favorites.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

final List<String> imgList = [];

final Widget placeholder = Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class nofavPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'No Saved Hotel!',
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Please Click on Heart Icon to Save Your Favorite Hotels!'
        )
      ),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Auto playing carousel

    List<Hotel> hotels = ProductsRepository.loadHotels();
    Set<String> saved = FavoriteInfo().get();

    hotels.forEach((item) {
      if (saved.contains(item.name)) {
        if (!imgList.contains(item.assetName)) imgList.add(item.assetName);
      } else
        imgList.remove(item.assetName);
    });


    final CarouselSlider autoPlayDemo = CarouselSlider(
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (assetName) {
          int idx;
          String name;
          hotels.forEach((item) {
            if (assetName.compareTo(item.assetName) == 0) {
              idx = item.id;
              name = item.name;
            }
          });
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => DetailPage(),
                      settings: RouteSettings(
                        arguments: idx,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      assetName,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.topCenter,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ).toList(),
    );

    return MaterialApp(
      title: 'demo',
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('My Page')),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: autoPlayDemo,
            ),
          ],
        ),
      ),
    );
  }
}
