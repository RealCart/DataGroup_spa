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
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController()..randomPhotos();
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
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24.0,
                  ),
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

              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Image.network(
                    item.path,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
                itemCount: list!.length,
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
