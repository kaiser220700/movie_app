import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:my_movie_app/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:my_movie_app/bloc/movie/movie_cubit.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';
import 'package:my_movie_app/common/my_images.dart';
import 'package:my_movie_app/common/my_style.dart';
import 'package:my_movie_app/models/servide.dart';
import 'package:my_movie_app/repository/movie_repository.dart';
import 'package:my_movie_app/ui/screens/detail_movie_screen.dart';
import 'package:my_movie_app/ui/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeScreen> {
  late final MovieCubit _cubit;
  double? screenWidth, screenHeight;
  int _currentIndex = 0;
  bool _autoPlay = false;
  @override
  void initState() {
    _cubit = BlocProvider.of<MovieCubit>(context);
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: const MyBottomNaviGationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: MyColors.colorBackgraound,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB((screenWidth ?? 0) * (65 / 428),
                    (screenHeight ?? 0) * (60 / 926), 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Hello, ",
                        style: MyStyles.tsTitle,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Jane!",
                            style: MyStyles.tsTitleBold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: (screenWidth ?? 0) * (180 / 428)),
                    const Icon(MyIcons.icAlert, color: MyColors.colorIcon),
                  ],
                ),
              ),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: _buildSearchField(),
              ),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
              const Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: Text(
                  "Most Popular",
                  style: MyStyles.tsTitleBold,
                ),
              ),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
              BlocBuilder<MovieCubit, MovieState>(
                  bloc: _cubit,
                  buildWhen: (prev, cur) =>
                      prev.loadStatus != cur.loadStatus ||
                      prev.autoPlay != cur.autoPlay,
                  builder: (context, state) {
                    return Center(
                      child: SizedBox(
                        height: (screenHeight ?? 0) * (141 / 926) + 40,
                        width: double.infinity,
                        child: Swiper(
                          autoplay: _autoPlay,
                          autoplayDelay: 1500,
                          autoplayDisableOnInteraction: false,
                          onIndexChanged: (index) => _currentIndex = index,
                          onTap: (index) {
                            if (index == _currentIndex) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider<DetailMovieCubit>(
                                      create: (context) {
                                        final repository = RepositoryProvider
                                            .of<MovieRepository>(context);
                                        return DetailMovieCubit(
                                            repository,
                                            state.popularMovie?.results?[index]
                                                    .id
                                                    .toString() ??
                                                "");
                                      },
                                      child: const DetailMovieScreen(),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          viewportFraction: 0.7,
                          scale: 0.75,
                          pagination: const SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              activeColor: Color(0xFF7589d1),
                              color: Color(0xFF4e5e91),
                            ),
                          ),
                          itemCount: state.popularMovie?.results?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onDoubleTap: () {
                                if (index == _currentIndex) {
                                  _autoPlay = _cubit.onAutoPlay(_autoPlay);
                                }
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                              left: 100,
                                              right: 100,
                                              top: 20,
                                              bottom: 20),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black),
                                          ),
                                        );
                                      },
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original/${state.popularMovie?.results?[index].backdropPath ?? ""}",
                                      height: (screenHeight ?? 0) * (141 / 926),
                                      width: (screenWidth ?? 0) * (328 / 428),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                MyImages.imgNotFound),
                                          ),
                                        ),
                                      ),
                                      color: index == _currentIndex
                                          ? const Color(0x00121212)
                                              .withOpacity(0.05)
                                          : const Color.fromARGB(
                                                  255, 100, 171, 219)
                                              .withOpacity(0.6),
                                      colorBlendMode: BlendMode.hardLight,
                                    ),
                                  ),
                                  Positioned(
                                    top: 87,
                                    left: 30,
                                    child: SizedBox(
                                      width:
                                          (screenWidth ?? 0) * (328 / 428) / 2,
                                      child: Text(
                                        "${state.popularMovie?.results?[index].title}",
                                        style: MyStyles.tsTitle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 87,
                                    left: 200,
                                    child: Container(
                                      height: 20,
                                      width:
                                          (screenWidth ?? 0) * (328 / 428) / 5,
                                      decoration: BoxDecoration(
                                          color: MyColors.colorIMDBCard,
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(MyImages.imgIMDB,
                                              height: 7.0),
                                          const SizedBox(width: 10),
                                          Text(
                                            "${state.popularMovie?.results?[index].voteAverage}",
                                            style: const TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w700),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
              SizedBox(height: (screenHeight ?? 0) * (15 / 926)),
              SizedBox(
                height: (screenHeight ?? 0) * (95 / 926),
                width: screenWidth,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: service.length,
                  itemBuilder: (context, index) => _buildServiceCard(index),
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                ),
              ),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
              const Padding(
                padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: Text(
                  "Upcoming releases",
                  style: MyStyles.tsTitleBold,
                ),
              ),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
              BlocBuilder<MovieCubit, MovieState>(
                  bloc: _cubit,
                  buildWhen: (prev, cur) =>
                      prev.loadStatus != cur.loadStatus ||
                      prev.autoPlay != cur.autoPlay,
                  builder: (context, state) {
                    return SizedBox(
                      height: (screenHeight ?? 0) * (265 / 926),
                      width: double.infinity,
                      child: Swiper(
                        autoplay: _autoPlay,
                        autoplayDelay: 1500,
                        autoplayDisableOnInteraction: false,
                        onIndexChanged: (index) => _currentIndex = index,
                        onTap: (index) {
                          if (index == _currentIndex) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider<DetailMovieCubit>(
                                    create: (context) {
                                      final repository = RepositoryProvider.of<
                                          MovieRepository>(context);
                                      return DetailMovieCubit(
                                          repository,
                                          state.upcomingMovie?.results?[index]
                                                  .id
                                                  .toString() ??
                                              "");
                                    },
                                    child: const DetailMovieScreen(),
                                  );
                                },
                              ),
                            );
                          }
                        },
                        viewportFraction: 0.4,
                        scale: 0.5,
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Color(0xFF7589d1),
                            color: Color(0xFF4e5e91),
                          ),
                        ),
                        itemCount: state.upcomingMovie?.results?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onDoubleTap: () {
                              if (index == _currentIndex) {
                                _autoPlay = _cubit.onAutoPlay(_autoPlay);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return const Padding(
                                      padding: EdgeInsets.only(
                                          left: 100,
                                          right: 100,
                                          top: 20,
                                          bottom: 20),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      ),
                                    );
                                  },
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/original/${state.upcomingMovie?.results?[index].posterPath ?? ""}",
                                  height: (screenHeight ?? 0) * (200 / 926),
                                  width: (screenWidth ?? 0) * (170 / 428),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(MyImages.imgNotFound),
                                      ),
                                    ),
                                  ),
                                  color: index == _currentIndex
                                      ? const Color(0x00121212)
                                          .withOpacity(0.05)
                                      : const Color.fromARGB(255, 100, 171, 219)
                                          .withOpacity(0.6),
                                  colorBlendMode: BlendMode.hardLight,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
              SizedBox(height: (screenHeight ?? 0) * (20 / 926)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() => Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        height: (screenHeight ?? 0) * (50 / 926),
        width: (screenWidth ?? 0) * (328 / 428),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: MyColors.colorBackgroundSearchField,
            ),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: const Color(0x33FFFFFF))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(MyIcons.icSearch, color: MyColors.colorIcon),
            ),
            Container(
              height: (screenHeight ?? 0) * (50 / 926),
              width: 200,
              alignment: Alignment.center,
              child: const TextField(
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(128, 255, 255, 255),
                      fontSize: 19.0),
                ),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.5,
              color: const Color.fromARGB(64, 255, 255, 255),
            ),
            const Icon(MyIcons.icMicro,
                color: Color.fromARGB(90, 255, 255, 255))
          ],
        ),
      );

  Widget _buildServiceCard(int index) => Container(
        padding: const EdgeInsets.only(top: 10.0),
        height: (screenHeight ?? 0) * (95 / 926),
        width: (screenWidth ?? 0) * (69 / 428),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: MyColors.colorCard,
          ),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: MyColors.colorBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 33.0, width: 33.0, child: service[index].icon),
            const SizedBox(height: 7.0),
            Text(service[index].title ?? "",
                style: const TextStyle(fontSize: 11.0, color: Colors.white)),
          ],
        ),
      );
}
