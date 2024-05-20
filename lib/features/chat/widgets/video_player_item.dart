import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/features/chat/widgets/video_play.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
  });
  final String videoUrl;
  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then(
        (value) => videoPlayerController.setVolume(1),
      );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlay(videoUrl: widget.videoUrl),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          children: [
            CachedVideoPlayer(videoPlayerController),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    if (isPlay) {
                      videoPlayerController.pause();
                    } else {
                      videoPlayerController.play();
                    }
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                  icon: Icon(
                    isPlay ? Icons.pause_circle : Icons.play_circle,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
