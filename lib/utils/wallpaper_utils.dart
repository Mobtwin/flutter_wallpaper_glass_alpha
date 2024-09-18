import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveImage(String image, BuildContext context) async {
  ByteData byteData = await rootBundle.load(image);
  Uint8List imageData = byteData.buffer.asUint8List();
  final result = await ImageGallerySaver.saveImage(imageData);
  if (result != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['isSuccess']
              ? 'Image saved successfully'
              : 'Failed to save image',
          style: GoogleFonts.abel(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

void onShareXFileFromAssets(BuildContext context, String image) async {
  // final scaffoldMessenger = ScaffoldMessenger.of(context);
  final data = await rootBundle.load(image);
  final buffer = data.buffer;
  await Share.shareXFiles(
    [
      XFile.fromData(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        name: 'shared_image.jpg',
        mimeType: 'image/jpeg',
      ),
    ],
  );

  // scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
}

SnackBar getResultSnackBar(ShareResult result) {
  return SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Share result: ${result.status}"),
        if (result.status == ShareResultStatus.success)
          Text("Shared to: ${result.raw}")
      ],
    ),
  );
}

Future<void> setWallpaper(
    BuildContext context, String image, int location) async {
  try {
    // Load the image from assets
    final ByteData assetImage = await rootBundle.load(image);

    // Get the temporary directory to store the file
    final Directory tempDir = await getTemporaryDirectory();

    // Create a new file in the temporary directory
    final File file = File('${tempDir.path}/wallpaper.jpg');

    // Write the asset image bytes to the file
    await file.writeAsBytes(assetImage.buffer.asUint8List());

    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);

    // Show a snackbar with the result
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result ? 'Wallpaper set successfully' : 'Failed to set wallpaper',
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to set wallpaper'),
      ),
    );
  }
}
