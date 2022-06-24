import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:flutter/material.dart';

class ItemListCard extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final int isMovie;

  const ItemListCard({
    Key? key,
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            detailRoute,
            arguments: ContentArguments(
              id: id,
              title: title,
              overview: overview,
              posterPath: posterPath,
              isMovie: isMovie,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: '$baseImageUrl$posterPath',
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}
