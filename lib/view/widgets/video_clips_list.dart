import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/view/widgets/youtube.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../model/video_model.dart';

Widget buildVideoClips(BuildContext context, List<Video> videos) {
  return SizedBox(
    height: 15.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videos.length,
      itemBuilder: (BuildContext context, int index) {
        return videoWidget(context, videos[index]);
      },
    ),
  );
}

Widget videoWidget(
  BuildContext context,
  Video video,
) {
  return InkWell(
    onTap: () {
      playVideo(context, video.id ?? "");
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      color: AppColors.black,
      width: 15.h,
      child: Stack(
        children: [
          Lottie.asset(Strings.playButton, animate: false),
          Text(
            video.name ?? "",
            style: TextStyle(fontSize: 10.sp, color: AppColors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}

Future<dynamic> playVideo(BuildContext context, String videoId) {
  return showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: YouTube(videoId: videoId),
        );
      });
}
