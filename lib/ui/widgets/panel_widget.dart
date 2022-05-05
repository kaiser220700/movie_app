import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:my_movie_app/common/my_color.dart';
import 'package:my_movie_app/common/my_icons.dart';
import 'package:my_movie_app/common/my_images.dart';
import 'package:my_movie_app/common/my_style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:expandable_text/expandable_text.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  final ScrollController controller;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: MyColors.colorBackgraound,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: [
          const SizedBox(height: 18.0),
          _buildDragHandle(),
          SizedBox(height: size.height * (20 / 926)),
          BlocBuilder<DetailMovieCubit, DetailMovieState>(
            buildWhen: (prev, curr) => prev.loadStatus != curr.loadStatus,
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    state.detailMovie?.title ?? "",
                    style: TextStyle(
                        fontSize: size.height * (45 / 926),
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: size.height * (20 / 926)),
                  Row(
                    children: [
                      //genres
                      Container(
                        height: size.height * (23 / 926),
                        width: size.width * (61 / 428),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            colors: MyColors.colorButton,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(state.detailMovie?.genres?.last.name ?? "",
                            style: MyStyles.tsTextButton),
                      ),
                      SizedBox(width: size.width * (10 / 428)),
                      //age condition
                      state.detailMovie?.adult ?? false
                          ? Container(
                              height: size.height * (23 / 926),
                              width: size.width * (61 / 428),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.bottomRight,
                                  colors: MyColors.colorButton,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: const Text("16+",
                                  style: MyStyles.tsTextButton),
                            )
                          : const SizedBox(),
                      SizedBox(width: size.width * (10 / 428)),
                      // IMDb point
                      Container(
                        height: size.height * (23 / 926),
                        width: size.width * (73 / 428),
                        decoration: BoxDecoration(
                            color: MyColors.colorIMDBCard,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              MyImages.imgIMDB,
                              height: 7,
                              fit: BoxFit.fill,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            SizedBox(width: size.width * (6 / 428)),
                            Text(
                              "${state.detailMovie?.voteAverage}",
                              style: MyStyles.tsTextPointIMDB,
                            ),
                          ],
                        ),
                      ),
                      state.detailMovie?.adult ?? false
                          ? SizedBox(width: size.width * (92 / 428))
                          : SizedBox(width: size.width * (140 / 428)),
                      const Icon(MyIcons.icShare, color: MyColors.colorIconDMS),
                      SizedBox(width: size.width * (10 / 428)),
                      const Icon(MyIcons.icFavourite,
                          color: MyColors.colorIconDMS),
                    ],
                  ),
                  SizedBox(height: size.height * (20 / 926)),
                  ExpandableText(
                    state.detailMovie?.overView ?? "",
                    style: MyStyles.tsTextDetail,
                    expandText: "More",
                    collapseOnTextTap: true,
                    maxLines: 2,
                  ),
                  SizedBox(height: size.height * (10 / 926)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Cast", style: MyStyles.tsTitleBold),
                      Text(
                        "See All",
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * (3 / 926)),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      itemCount: state.castList?.cast?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 3,
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w200${state.castList?.cast?[index].profilePath}',
                                  imageBuilder: (context, imageBuilder) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        image: DecorationImage(
                                          image: imageBuilder,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(MyImages.imgNotFound),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * (3 / 926)),
                            Center(
                              child: Text(
                                state.castList?.cast?[index].name
                                        ?.toUpperCase() ??
                                    "",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]),
                              ),
                            ),
                            SizedBox(height: size.height * (3 / 926)),
                            Center(
                              child: Text(
                                state.castList?.cast?[index].character
                                        ?.toUpperCase() ??
                                    "",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 30,
            height: 2,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0)),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
