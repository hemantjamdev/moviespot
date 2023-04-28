import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/people_model.dart';
import '../../provider/person_provider.dart';
import '../widgets/back_button.dart';

class PersonDetails extends StatelessWidget {
  final int personId;

  const PersonDetails({Key? key, required this.personId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PersonProvider>(context, listen: false)
        .getPersonDetail(personId);
    return Scaffold(
      body: Consumer<PersonProvider>(
        builder: (context, PersonProvider provider, child) {
          return FutureBuilder<PeopleModel>(
            future: provider.getPersonDetail(personId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildActorDetails(context, snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: const CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}

Widget _buildActorDetails(BuildContext context, PeopleModel actor) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _buildActorImage(actor.profilePath),
            buildBackButton(context),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                actor.name ?? "",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Born: ${actor.birthday}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Place of Birth: ${actor.placeOfBirth}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Known For: ${actor.knownForDepartment}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                actor.biography ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildActorImage(String? profilePath) {
  return Container(
    height: 70.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: CachedNetworkImageProvider(
          "${Strings.imageBase}${profilePath ?? ""}",
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
    ),
  );
}
