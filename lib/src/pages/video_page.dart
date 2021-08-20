import 'package:flutter/material.dart';
import 'package:utesaapp/src/providers/services_provider.dart';
import 'package:utesaapp/src/utils/utils.dart';
import 'package:utesaapp/src/widget/logout_widget.dart';
import 'package:utesaapp/src/widget/menu_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatelessWidget {

  final serviceProvider = ServicesProvider();

  @override
  Widget build(BuildContext context) {

    // YoutubePlayerController _controller = new YoutubePlayerController(
    //   initialVideoId: 'dfxCF7rQqz8',
    //   flags: YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: true,
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text("Videos"),
        backgroundColor: HexColor("327D57"),
      ),
      drawer: MenuWidget(),
      body: _createVideoList(),
    );
  }

  Widget _createVideoList() {
    return FutureBuilder(
      future: serviceProvider.getVideos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.hasData ){

          final videos = snapshot.data;
          if( !videos["ok"] ){
            return LogoutWidget();
          }
          final videoList = videos["data"];

          return ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int i) => _createVideoItem(videoList[i]),
          );

        }else {
          return Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );    
  }

  Widget _createVideoItem(video) {
    YoutubePlayerController _controller = new YoutubePlayerController(
      initialVideoId: video["codigo"],
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Center(
            child: Text(video["nombre"]),
          ),
          SizedBox(height: 10.0,),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent
            ),
          ),
        ],
      ),
    );
  }
}