import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

share(BuildContext ctx, String? extract, String url) {
  Share.share(
    "Found this Interesting article on Wikipedia\n\n${extract != null ? extract : ""}\n\n$url",
    subject: "Found this Interesting article on Wikipedia",
  );
}
