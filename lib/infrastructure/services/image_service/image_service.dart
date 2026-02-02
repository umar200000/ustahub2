// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as im;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as ph;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ustahub/infrastructure/services/image_service/camera_picker/wechat_camera_picker.dart';
import 'package:ustahub/infrastructure/services/image_service/image_picker/src/constants/config.dart';
import 'package:ustahub/infrastructure/services/image_service/image_picker/src/delegates/asset_picker_text_delegate.dart';
import 'package:ustahub/infrastructure/services/image_service/image_picker/src/widget/asset_picker.dart';
import 'package:ustahub/presentation/components/c_bottom_sheet.dart';
import 'package:ustahub/presentation/components/c_list_tile.dart';
import 'package:ustahub/presentation/components/easy_loading.dart';
import 'package:ustahub/presentation/styles/style.dart';
import 'package:ustahub/presentation/styles/theme.dart';
import 'package:ustahub/presentation/styles/theme_wrapper.dart';

class ImageService {
  static Future<String?> compressImage(File imageFile, int height) async {
    im.Image? image = im.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      return null;
    } else if (image.height <= height) {
      return imageFile.path;
    } else {
      var uuid = const Uuid();
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      im.Image smallerImage = im.copyResize(image, height: height);
      var compressedImage = File('$path/${uuid.v4()}.jpg')
        ..writeAsBytesSync(im.encodeJpg(smallerImage, quality: 100));
      return compressedImage.path;
    }
  }

  static Future<AssetEntity?> convertToJpg(AssetEntity inputFile) async {
    // ImageFileType type = _getType(inputFile, await inputFile.titleAsync);
    // if (Platform.isAndroid && type == ImageFileType.heic) {
    //   try {
    //     var uuid = const Uuid();
    //     final tempDir = await getTemporaryDirectory();
    //     final path = tempDir.path;
    //     String outputPath = '$path/${uuid.v4()}.jpg';
    //     File? imagePath = await inputFile.originFile;
    //     if (imagePath == null) {
    //       return null;
    //     }
    //     await HeifConverter.convert(imagePath.path,
    //         format: ".jpg", output: outputPath);
    //     final AssetEntity fileEntity =
    //         await PhotoManager.editor.saveImageWithPath(
    //       outputPath,
    //       title: ph.basename(outputPath),
    //     );
    //     return fileEntity;
    //   } catch (e) {
    //     LogService.e("Failed to decode the image $e");
    //     return null;
    //   }
    // } else {
    //   return inputFile;
    // }
    return null;
  }

  static Future<String?> imageCrop(
    String path, {
    CropStyle? cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  }) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.jpg,
        aspectRatio: aspectRatioPresets != null
            ? aspectRatioPresets.contains(CropAspectRatioPreset.square)
                  ? const CropAspectRatio(ratioX: 1, ratioY: 1)
                  : aspectRatioPresets.contains(CropAspectRatioPreset.ratio16x9)
                  ? const CropAspectRatio(ratioX: 16, ratioY: 9)
                  : null
            : null,
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Style.primary500,
            toolbarWidgetColor: Style.shade0,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            aspectRatioPresets:
                aspectRatioPresets ??
                [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9,
                ],
            cropStyle: cropStyle ?? CropStyle.rectangle,
          ),
          IOSUiSettings(
            aspectRatioPresets:
                aspectRatioPresets ??
                [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9,
                ],
            cropStyle: cropStyle ?? CropStyle.rectangle,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (croppedFile != null) {
        return croppedFile.path;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<AssetEntity>?> showPicker(
    BuildContext context, {
    CropStyle? cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    bool crop = true,
    int maxAssets = 1,
    List<AssetEntity>? selectedAssets,
    int? compressHeight,
  }) async {
    BottomNavBarController globalController = context
        .read<BottomNavBarController>();
    bool isOpen = globalController.hiddenNavBar;
    globalController.changeNavBar(true);
    List<AssetEntity>? assets = await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return ThemeWrapper(
          builder: (ctx, colors, fonts, icons, controller) {
            return CustomBottomSheet(
              title: 'pick_photo'.tr(),
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomListTile(
                        icon: icons.pickImageO,
                        title: "pick_photo_from_gallery".tr(),
                        onTap: () async {
                          List<AssetEntity>? asset = await _imgFromGallery(
                            context,
                            colors,
                            cropStyle: cropStyle,
                            aspectRatioPresets: aspectRatioPresets,
                            crop: crop,
                            maxAssets: maxAssets,
                            selectedAssets: selectedAssets,
                            compressHeight: compressHeight,
                          );
                          if (asset != null && asset.isNotEmpty) {
                            Navigator.of(context).pop(asset);
                          } else {
                            Navigator.of(context).pop(<AssetEntity>[]);
                          }
                        },
                      ),
                      8.h.verticalSpace,
                      CustomListTile(
                        icon: icons.cameraS,
                        title: "pick_photo_from_camera".tr(),
                        onTap: () async {
                          AssetEntity? asset = await _imgFromCamera(
                            context,
                            cropStyle: cropStyle,
                            aspectRatioPresets: aspectRatioPresets,
                            compressHeight: compressHeight,
                            crop: crop,
                          );
                          if (asset != null) {
                            Navigator.of(context).pop([asset]);
                          } else {
                            Navigator.of(context).pop(<AssetEntity>[]);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
    globalController.changeNavBar(isOpen);
    return assets;
  }

  static Future<AssetEntity?> _imgFromCamera(
    BuildContext context, {
    CropStyle? cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    bool crop = true,
    int? compressHeight,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? assets = await picker.pickImage(source: ImageSource.camera);

      if (assets != null) {
        AssetEntity? assetEntity = await PhotoManager.editor.saveImageWithPath(
          assets.path,
          title: ph.basename(assets.path),
        );
        if (crop) {
          String? file = assets.path;

          String? path = await imageCrop(
            file,
            cropStyle: cropStyle,
            aspectRatioPresets: aspectRatioPresets,
          );
          if (path != null) {
            final AssetEntity fileEntity = await PhotoManager.editor
                .saveImageWithPath(path, title: ph.basename(path));
            assetEntity = fileEntity;
          } else {
            return null;
          }
        }

        if (compressHeight != null) {
          String file = assets.path;
          String? path = await compressImage(File(file), compressHeight);
          if (path != null) {
            final AssetEntity fileEntity = await PhotoManager.editor
                .saveImageWithPath(path, title: ph.basename(path));
            assetEntity = fileEntity;
          } else {
            return null;
          }
        }
        // String file = assets.path;
        // String? path = await convertToJpg(File(file));
        // if (path != null) {
        //   final AssetEntity? fileEntity =
        //       await PhotoManager.editor.saveImageWithPath(
        //     path,
        //     title: ph.basename(path),
        //   );
        //   if (fileEntity != null) {
        //     assetEntity = fileEntity;
        //   } else {
        //     return null;
        //   }
        // } else {
        //   return null;
        // }
        return assetEntity;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('${"image_upload_error".tr()} $e');
      return null;
    }
  }

  static Future<List<AssetEntity>?> _imgFromGallery(
    BuildContext context,
    CustomColorSet colors, {
    CropStyle? cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    bool crop = true,
    required int maxAssets,
    List<AssetEntity>? selectedAssets,
    int? compressHeight,
  }) async {
    try {
      List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          themeColor: colors.primary500,
          selectedAssets: selectedAssets,
          maxAssets: maxAssets,
          textDelegate: const EnglishAssetPickerTextDelegate(),
          requestType: RequestType.image,
        ),
      );
      if (assets != null && assets.isNotEmpty) {
        if (crop) {
          List<AssetEntity> assetsCrop = [];
          await Future.forEach(assets, (AssetEntity? element) async {
            if (element != null) {
              if (selectedAssets != null
                  ? !selectedAssets.contains(element)
                  : true) {
                File? file = await element.originFile;
                if (file != null) {
                  String? path = await imageCrop(
                    file.path,
                    aspectRatioPresets: aspectRatioPresets,
                    cropStyle: cropStyle,
                  );
                  if (path != null) {
                    final AssetEntity fileEntity = await PhotoManager.editor
                        .saveImageWithPath(path, title: ph.basename(path));
                    assetsCrop.add(fileEntity);
                  }
                }
              } else {
                assetsCrop.add(element);
              }
            }
          });
          if (assetsCrop.isNotEmpty) {
            assets = assetsCrop;
          } else {
            return null;
          }
        }

        List<AssetEntity> assetsCompress = [];
        await Future.forEach(assets, (AssetEntity? element) async {
          if (element != null) {
            if (selectedAssets != null
                ? !selectedAssets.contains(element)
                : true) {
              AssetEntity? fileEntity = await convertToJpg(element);
              if (fileEntity != null) {
                assetsCompress.add(fileEntity);
              } else {
                return null;
              }
            } else {
              assetsCompress.add(element);
            }
          }
        });
        if (assetsCompress.isNotEmpty) {
          assets = assetsCompress;
        } else {
          return null;
        }
        return assets;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('${"image_upload_error".tr()} $e');
      return null;
    }
  }
}
