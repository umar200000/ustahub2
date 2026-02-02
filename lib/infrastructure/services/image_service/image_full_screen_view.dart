import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ustahub/presentation/components/animation_effect.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:extended_image/extended_image.dart';

class ImageFullScreenPageModel {
  final List<String> imageUrl;
  final bool dark;
  final int? initialPage;

  ImageFullScreenPageModel({
    required this.imageUrl,
    this.dark = true,
    this.initialPage,
  });
}

class ImageFullScreenPage extends StatelessWidget {
  final ImageFullScreenPageModel imageFullScreenPageModel;

  const ImageFullScreenPage({
    super.key,
    required this.imageFullScreenPageModel,
  });

  static const String routeName = '/full-screen';

  @override
  Widget build(BuildContext context) {
    final args = imageFullScreenPageModel;
    return Container(
      color: args.dark ? Colors.black : Colors.white,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: PageController(initialPage: args.initialPage ?? 0),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: ExtendedNetworkImageProvider(
                  args.imageUrl[index],
                ),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: args.imageUrl[index],
                ),
              );
            },
            itemCount: args.imageUrl.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
            backgroundDecoration: BoxDecoration(
              color: args.dark ? Colors.black : Colors.white,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimationButtonEffect(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ImageProvider cachedNetworkImageProvider(String image) {
  if (kIsWeb) {
    return NetworkImage(image);
  } else {
    return ExtendedNetworkImageProvider(image);
  }
}
