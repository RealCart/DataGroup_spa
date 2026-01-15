import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_project/core/constants/app_assets.dart';
import 'package:spa_project/core/utils/status_enum.dart';
import 'package:spa_project/features/home/presentation/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _textEditingController;
  late final HomeController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _controller = HomeController()..randomPhotos();
    _scrollController = ScrollController()..addListener(_getMore);
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    _scrollController
      ..removeListener(_getMore)
      ..dispose();

    super.dispose();
  }

  void _getMore() {
    final double maxExtent = _scrollController.position.maxScrollExtent;
    final double currentPosition = _scrollController.position.pixels;

    log('''
      MaxExtent: $maxExtent,
      CurrentPosition: $currentPosition,
      Get more: ${maxExtent - currentPosition <= 300},
    ''', name: "ScrollController");

    if (maxExtent - currentPosition <= 300) {
      _controller.getMore(_textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              backgroundColor: Colors.black,
              leadingWidth: double.infinity,
              toolbarHeight: kToolbarHeight + 20.0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(AppAssets.images.logo),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 80.0,
                  horizontal: 21.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppAssets.images.searchBg,
                    ),
                  ),
                ),
                child: TextField(
                  controller: _textEditingController,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24.0,
                  ),
                  onChanged: (value) {
                    _controller.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Поиск",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 26.0),
                      child: SvgPicture.asset(
                        AppAssets.icons.search,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            if (_controller.status == StatusEnum.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (_controller.status == StatusEnum.error) {
              return Center(
                child: Text("Ошибка!"),
              );
            }

            if (_controller.status == StatusEnum.success) {
              final list = _controller.photo;

              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  _controller.randomPhotos();
                },
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return CachedNetworkImage(
                      imageUrl: item.path,
                      progressIndicatorBuilder: (context, url, progress) {
                        return SizedBox(
                          height: 300.0,
                          width: double.infinity,
                          child: ColoredBox(
                            color: Colors.grey,
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20.0,
                  ),
                  itemCount: list!.length,
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
