import 'package:flutter/material.dart';
import 'package:foodistan/widgets/reviewer_widget.dart';

class RestuarantDeliveryReview extends StatefulWidget {
  static String id = 'restaurant_delivery_review';

  @override
  _RestuarantDeliveryMenuSReview createState() =>
      _RestuarantDeliveryMenuSReview();
}

class _RestuarantDeliveryMenuSReview extends State<RestuarantDeliveryReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: DropdownButton(
            hint: Padding(
              padding: const EdgeInsets.all(11),
              child: Text(
                "Top Rated",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            isExpanded: true,
            iconSize: 33,
            style: const TextStyle(color: Colors.black),
            items: ['Top Rated', 'Oldest', 'Latest'].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              // selectcountry = val;
              // onSubmit check
            },
          ),
        ),
            ReviewerWidget(),
      ]),
    );
  }
}
