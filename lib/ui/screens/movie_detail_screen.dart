import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';
import 'package:my_movie_app/common/my_images.dart';
import 'package:my_movie_app/ui/widgets/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  late final MovieDetailCubit _cubit;
  double? _screenWidth, _screenHeight;
  final panelController = PanelController();
  double? _iconBackHeightCurrent;
  double? _iconBackHeight;

  @override
  void initState() {
    _cubit = BlocProvider.of<MovieDetailCubit>(context);
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenHeight = size.height;
    _screenWidth = size.width;
    _iconBackHeightCurrent = (_screenHeight ?? 0) * 0.92;
    final panelHeightOpen = (_screenHeight ?? 0) * 0.8;
    final panelHeightClosed = (_screenHeight ?? 0) * 0.45;
    return Scaffold(
      body: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        listenWhen: (prev, cur) => prev.iconBackHeight != cur.iconBackHeight,
        listener: (context, state) {
          _iconBackHeight = state.iconBackHeight;
        },
        buildWhen: (prev, cur) => prev.iconBackHeight != cur.iconBackHeight,
        builder: (context, state) => SlidingUpPanel(
          controller: panelController,
          maxHeight: panelHeightOpen,
          minHeight: panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: _buildBody(),
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50.0)),
          onPanelSlide: (position) => _cubit.onPositionIcon(position,
              _iconBackHeightCurrent ?? 0, panelHeightOpen, panelHeightClosed),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() => Stack(
        children: [
          BlocBuilder<MovieDetailCubit, MovieDetailState>(
            buildWhen: (prev, curr) => prev.loadStatus != curr.loadStatus,
            builder: (context, state) {
              return CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: (_screenWidth ?? 0) * 0.4, right: (_screenWidth ?? 0) * 0.4, top: (_screenHeight ?? 0) * 0.21, bottom: (_screenHeight ?? 0) * 0.21),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                },
                imageUrl:
                    "https://image.tmdb.org/t/p/original/${state.detailMovie?.backdropPath}",
                height: (_screenHeight ?? 0) * 0.53,
                width: double.infinity,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(MyImages.imgNotFound),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        const Color(0x00121212).withOpacity(0.12),
                        BlendMode.hardLight,
                      ),
                    ),
                  ),
                ),
                color: const Color(0x00121212).withOpacity(0.3),
                colorBlendMode: BlendMode.hardLight,
              );
            },
          ),
          Positioned(
            left: (_screenWidth ?? 0) * 0.13,
            bottom: _iconBackHeight ?? _iconBackHeightCurrent,
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: const Icon(
                MyIcons.icBack,
                color: MyColors.colorIcon,
              ),
            ),
          ),
          Positioned(
            top: (_screenHeight ?? 0) / 4 - 40,
            left: (_screenWidth ?? 0) / 2 - 40,
            child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
              buildWhen: (prev, cur) => prev.loadStatus != cur.loadStatus,
              builder: (context, state) => GestureDetector(
                onTap: () async {
                  final youtubeUrl =
                      'https://www.youtube.com/embed/${state.video?.results?.first.key}';
                  if (!await launchUrl(Uri.parse(youtubeUrl))) {
                    throw "Could not launch $youtubeUrl";
                  }
                },
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.yellow,
                  size: 65,
                ),
              ),
            ),
          )
        ],
      );
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: MyColors.colorBackgroundBNB,
        ),
      ),
      child: BottomNavigationBar(
        iconSize: 31,
        currentIndex: 0,
        onTap: (index) {},
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedItemColor: MyColors.colorIcon,
        selectedIconTheme: const IconThemeData(color: MyColors.colorIcon),
        items: [
          BottomNavigationBarItem(
            icon: Container(
                child: const Icon(MyIcons.icHome),
                margin: const EdgeInsets.only(top: 14.0)),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(MyIcons.icFavourite),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(MyIcons.icTicket),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(MyIcons.icAccount),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(MyIcons.icShuffle),
            label: "",
          ),
        ],
      ),
    );
  }
}
