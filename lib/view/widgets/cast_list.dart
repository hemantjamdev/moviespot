import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/strings.dart';
import '../pages/person_details.dart';

Widget buildCastCrew(
    {required BuildContext context,
    required String imageUrl,
    required String name,
    required int id}) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PersonDetails(personId: id)));
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.h,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(Strings.imageBase + imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 10.h,
            child: Text(
              name,
              style: TextStyle(fontSize: 8.sp),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}
