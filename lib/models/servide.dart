import 'package:flutter/cupertino.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';


class Service {
  Icon? icon;
  String? title;
  Service ({
    this.icon,
    this.title
  });
}

List<Service> service = [
  Service(
    icon: const Icon(MyIcons.icGenres, color: MyColors.colorIcon),
    title: "Genres",
  ),
  Service(
    icon: const Icon(MyIcons.icTvSeries, color: MyColors.colorIcon),
    title: "TV series",
  ),
  Service(
    icon: const Icon(MyIcons.icMovieRoll, color: MyColors.colorIcon),
    title: "Movies",
  ),
  Service(
    icon: const Icon(MyIcons.icTheatre, color: MyColors.colorIcon),
    title: "In Theatre",
  ),
];