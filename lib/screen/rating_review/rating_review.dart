import 'package:feg_store/bloc/bloc/app_blocs.dart';
import 'package:feg_store/bloc/bloc/app_state.dart';
import 'package:feg_store/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../bloc/bloc/app_event.dart';
import '../../constants/app_colors.dart';

class RatingReview extends StatefulWidget {
  final String? userid;
  final String? token;

  const RatingReview({
    super.key,
    required this.userid,
    required this.token,
  });

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final controller = PageController(viewportFraction: 1, keepPage: true);
  int pageIndex = 0;
  final TextEditingController textEditingController = TextEditingController();
  double ratingCount = 3;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingBloc, RatingState>(builder: (context, state) {
      final pages = <Widget>[
        rating(context, controller, ratingCount),
        review(context, textEditingController, ratingCount, controller)
      ];
      if (state is RatingLoaded) {
        pageIndex = 1;
        controller.animateToPage(pageIndex,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300));
      } else if (state is RatingError) {}
      return Scaffold(
        appBar: AppBar(
          title: Text(
            pageIndex == 0 ? "Rating" : "Review",
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_circle_left,
              color: Colors.black,
            ),
            onPressed: () {
              pageIndex == 0
                  ? Navigator.pop(context)
                  : controller.animateToPage(pageIndex,
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 300));
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    itemCount: pages.length,
                    itemBuilder: (_, index) {
                      print("ratingCount=====$ratingCount");
                      pageIndex = index;
                      return pages[index];
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: CustomizableEffect(
                    activeDotDecoration: DotDecoration(
                      width: 35,
                      height: 8,
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    dotDecoration: DotDecoration(
                      width: 8,
                      height: 8,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                      verticalOffset: 0,
                    ),
                    spacing: 6.0,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: MaterialButton(
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Palette.primary,
                    onPressed: () {
                      print('Page: $pageIndex');
                      print('----ratingCount btn-- $ratingCount');
                      pageIndex == 0
                          ? BlocProvider.of<RatingBloc>(context).add(AddRating(
                              widget.userid.toString(),
                              ratingCount.round().toString(),
                              widget.token.toString()))
                          : BlocProvider.of<ReviewBloc>(context).add(AddReview(
                              widget.userid.toString(),
                              textEditingController.text.toString(),
                              widget.token.toString()));
                    },
                    child: Center(
                      child: Text(
                        pageIndex == 0 ? "Next" : "Save",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SetRating) {
        print('----rating-- ${state.rating}');
        print('----ratingCount-- ${state.ratingCount}');
        ratingCount = state.ratingCount;
      }
    });
  }
}

Widget rating(context, controller, ratingCount) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'FEGSTORE',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Column(
          children: [
            Text(
              'Rate Your Experience',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black, fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Did you enjoy working with us?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
            Text(
              'Please add your rating',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: RatingBar.builder(
                initialRating: 3,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.vertical,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Very Bad",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ]);
                    case 1:
                      return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.vertical,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Bad",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ]);
                    case 2:
                      return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.vertical,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Ok",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ]);
                    case 3:
                      return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.vertical,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Good",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ]);
                    case 4:
                      return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction: Axis.vertical,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Excellent",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ]);
                    default:
                      return Container();
                  }
                },
                onRatingUpdate: (rating) {
                  print("rating==$rating");
                  BlocProvider.of<RatingBloc>(context)
                      .add(Rating(rating, ratingCount));
                },
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget review(context, textEditingController, ratingCount, controller) {
  return BlocConsumer<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoaded) {
          // Navigator.pushReplacementNamed(
          //   context,
          //   pageListRoute,
          // );
        } else if (state is ReviewError) {}
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rating',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Text(
                    ratingCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: ratingCount,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Write your Review',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: textEditingController,
                  maxLines: 3, //or null
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10) //
                        ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10) //
                        ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10) //
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      listener: (context, state) {});
}
