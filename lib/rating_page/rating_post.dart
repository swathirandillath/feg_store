import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);


  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double? rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
        title: const Text(
          "yours rating",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'FEGSTORE',
            style: TextStyle(
                color: Color(0xff4d53e5),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          const Text(
            'Rate Your Experience',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          const Text(
            'did you enjoy working with us?',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const Text(
            'Please add your rating',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          RatingBar.builder(
            initialRating: 3,
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Column(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text("Very Bad")
                    ],
                  );
                case 1:
                  return Column(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text("Bad")
                    ],
                  );
                case 2:
                  return Wrap(

                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,


                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.green,


                      ),
                      Text("Ok")
                    ],
                  );
                case 3:
                  return Column(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 50,
                      ),
                      Text("Good")
                    ],
                  );
                case 4:
                  return Column(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 50,
                      ),
                      Text("Excellent")
                    ],
                  );

                default:
                  return Container();
              }
            },
            onRatingUpdate: (rating) {
              print(rating);
            },
          )
        ],
      )),
    );
  }
}
