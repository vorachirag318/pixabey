import 'dart:async' show Timer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pixabay/core/constant/appIcons.dart';
import 'package:pixabay/core/constant/app_colors.dart';
import 'package:pixabay/ui/image_screen/controller/imageListController.dart';
import 'package:pixabay/ui/image_screen/fullImageScreen.dart';
import 'package:pixabay/ui/shared/appTextFiled.dart';

import 'model/imageListModel.dart';

class ImageListScreen extends StatefulWidget {
  static const String routeName = "/imageListScreen";

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  ImageListController imageListController = Get.find<ImageListController>();
  TextEditingController searchImagesTextEditingController =
      TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? timer;
  @override
  void initState() {
    imageListController.fetchAllImagesList();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent / 2 &&
          !scrollController.position.outOfRange) {
        if (imageListController.hasMore) {
          imageListController.fetchAllImagesList();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          imageSearchTextFiled(),
          const SizedBox(
            height: 10,
          ),
          imageList()
        ],
      ),
    );
  }

  imageList() {
    return GetBuilder(
      builder: (ImageListController imageListController) {
        return Expanded(
          child: imageListController.loader
              ? GetPlatform.isAndroid
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Center(
                      child: CupertinoActivityIndicator(),
                    )
              : imageListController.imageList.isEmpty
                  ? const Center(
                      child: Text("No image found!"),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ScrollKeyboardCloser(
                        child: StaggeredGridView.countBuilder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 4,
                          itemCount: imageListController.imageList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: imageView(
                              imageListController.imageList[index],
                            ),
                          ),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(2, index.isEven ? 4.2 : 3.2),
                          crossAxisSpacing: 8,
                        ),
                      ),
                    ),
        );
      },
    );
  }

  imageView(Hit imageDetails) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.toNamed(FullImageScreen.routeName,
                arguments: imageDetails.largeImageUrl);
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: SizedBox(
              height: 400,
              child: networkImageShow(imageDetails.largeImageUrl),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              likeCommentDetails(
                  icon: AppIcons.likeIcon,
                  value: imageDetails.likes.toString()),
              likeCommentDetails(
                  icon: AppIcons.commentIcon,
                  value: imageDetails.comments.toString()),
            ],
          ),
        )
      ],
    );
  }

  imageSearchTextFiled() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppTextField(
        keyboardType: TextInputType.text,
        onFieldSubmitted: (p0) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        maxLength: 100,
        controller: searchImagesTextEditingController,
        onChange: (value) {
          timer?.cancel();
          timer = Timer(const Duration(microseconds: 800), () {
            if (value.isEmpty) {
              imageListController.imageList.clear();
              imageListController.searchImage = "";
              imageListController.page = 0;
              imageListController.fetchAllImagesList();
            } else {
              imageListController.imageList.clear();
              imageListController.searchImage = value;
              imageListController.page = 0;
              imageListController.fetchAllImagesList();
            }
          });
        },
        hintText: "Search images",
        prefixIcon: IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColor.kScaffoldColor,
          ),
          onPressed: () {
            imageListController.imageSearchPaginationKey.currentState
                ?.refresh();
          },
        ),
      ),
    );
  }

  appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(180),
      child: SafeArea(
        child: Text(
          "Pixabay",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Dancing", fontWeight: FontWeight.bold, fontSize: 50),
        ),
      ),
    );
  }

  likeCommentDetails({required String value, required String icon}) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 20,
          height: 20,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class ScrollKeyboardCloser extends StatelessWidget {
  final Widget child;

  ScrollKeyboardCloser({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          // close keyboard
          FocusManager.instance.primaryFocus?.unfocus();
        }
        return false;
      },
      child: child,
    );
  }
}

networkImageShow(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    )),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
