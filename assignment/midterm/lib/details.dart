import 'package:flutter/material.dart';
import 'favorites.dart';
import 'model/product.dart';
import 'model/products_repository.dart';

class DetailPage extends StatelessWidget {
  Widget build(BuildContext context) {
    int idx = ModalRoute.of(context).settings.arguments;
    List<Hotel> hotels = ProductsRepository.loadHotels();
    Hotel hotel = hotels[idx];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Hero(
                tag: hotel.assetName,
                child: Image.asset(
                  hotel.assetName,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(15),
                child: FavoriteWidget(hotel.name),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                titleSection(hotel),
                textSection(hotel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleSection(Hotel hotel) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              for (var i = 0; i < hotel.stars; i++)
                IconTheme(
                  data: IconThemeData(color: Colors.yellow),
                  child: Icon(Icons.star, size: 25),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            hotel.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.blueAccent,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: Text(hotel.location,
                      style: TextStyle(color: Colors.blueAccent),
                      overflow: TextOverflow.visible)),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.phone,
                color: Colors.blueAccent,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                hotel.number,
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
          Divider(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget textSection(Hotel hotel) {
    return Container(
      child: Text(
        hotel.description,
        softWrap: true,
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
