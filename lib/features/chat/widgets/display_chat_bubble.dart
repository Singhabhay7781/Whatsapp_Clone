import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/features/chat/widgets/video_player_item.dart';

class DisplayChatBubble extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayChatBubble({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.image
            ? CachedNetworkImage(
                imageUrl: message,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : VideoPlayerItem(
                videoUrl: message,
              );
  }
}
