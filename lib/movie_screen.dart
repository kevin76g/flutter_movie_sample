import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends State<MovieScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/movies/aquarium_movie.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter movie sample'),
      ),
      body: Center(
        child: ListView(
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            ActionContainer(controller: _controller),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ActionContainer extends StatelessWidget {
  const ActionContainer({
    Key? key,
    required VideoPlayerController controller,
  })  : _controller = controller,
        super(key: key);

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
            iconSize: 40.0,
            color: Colors.red.shade400,
          ),
          IconButton(
            icon: const Icon(Icons.comment_outlined),
            onPressed: () {},
            iconSize: 40.0,
            color: Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
            iconSize: 40.0,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            '${_controller.value.duration.inMinutes.toString()}:${_controller.value.duration.inSeconds}',
            style: const TextStyle(fontSize: 26.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
