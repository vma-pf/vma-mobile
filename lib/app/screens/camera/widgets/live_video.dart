import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vma/app/common/vma_state.dart';

class LiveVideo extends StatefulWidget {
  final String cameraId;
  const LiveVideo({super.key, required this.cameraId});

  @override
  State<StatefulWidget> createState() => _LiveVideoState();
}

class _LiveVideoState extends VMAState<LiveVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer().then(
      (_) => setState(
        () {
          _isPlaying = true;
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    try {
      String hlsUrl =
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
      // String hlsUrl = await _model.fetchHlsUrl(widget.cameraId);
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(hlsUrl));
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: 16 / 9,
      );
    } catch (error) {
      debugPrint("Error fetching or initializing HLS: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isPlaying
        ? Chewie(controller: _chewieController)
        : Center(child: CircularProgressIndicator());
  }
}
