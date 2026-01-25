import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:organization/common/constant/image_constants.dart';
import 'package:organization/common/constant/size_constants.dart';

cacheImageBannerExploreOurProgram(
  String imageUrl,
  String placeHolderImagePath,
) {
  // // debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: SizeConstants.width,
    height: SizeConstants.width / 1.3,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Center(
        child: SizedBox(
          width: SizeConstants.width * 0.5,
          child: Image.asset(placeHolderImagePath),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Center(
        child: SizedBox(
          width: SizeConstants.width * 0.5,
          child: Image.asset(placeHolderImagePath),
        ),
      );
    },
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
  );
}

cacheImageGalleryExploreOurProgram(
  String imageUrl,
  String placeHolderImagePath,
) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: SizeConstants.width,
    height: SizeConstants.width / 1.3,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Center(
        child: SizedBox(
          width: SizeConstants.width * 0.15,
          child: Image.asset(placeHolderImagePath, fit: BoxFit.fitWidth),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Center(
        child: SizedBox(
          width: SizeConstants.width * 0.15,
          child: Image.asset(placeHolderImagePath, fit: BoxFit.fitWidth),
        ),
      );
    },
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
  );
}

cacheProfilePictureImage(String imageUrl, String placeHolderImagePath) {
  // // debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: SizeConstants.width * 0.4,
    height: SizeConstants.width * 0.4,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Container(
        padding: EdgeInsets.all(SizeConstants.s1 * 5),
        child: ClipOval(
          child: Image.asset(
            ImageAssetsConstants.pic,
            height: SizeConstants.s1 * 65,
            width: SizeConstants.s1 * 65,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Container(
        padding: EdgeInsets.all(SizeConstants.s1 * 5),
        child: ClipOval(
          child: Image.asset(
            ImageAssetsConstants.pic,
            height: SizeConstants.s1 * 65,
            width: SizeConstants.s1 * 65,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
  );
}
