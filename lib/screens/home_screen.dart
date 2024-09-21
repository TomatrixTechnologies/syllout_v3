import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:syllout_v3/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> videoUrls = [
    'https://youtu.be/dQw4w9WgXcQ?si=cd6lsTHj4GtHwiDW',
    'https://youtu.be/dQw4w9WgXcQ?si=cd6lsTHj4GtHwiDW',
    'https://youtu.be/dQw4w9WgXcQ?si=cd6lsTHj4GtHwiDW',
    'https://youtu.be/dQw4w9WgXcQ?si=cd6lsTHj4GtHwiDW',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SyllOut', style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return regularVideoCard(context, videoUrls[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the side menu
        },
        child: Icon(Icons.menu),
        backgroundColor: Colors.orange,
      ),
      drawer: CustomDrawer(),
    );
  }

  Widget regularVideoCard(BuildContext context, String videoUrl) {
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId == null) {
      // Handle invalid video URL
      return Card(
        color: Colors.grey[900],
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Invalid Video URL',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the thumbnail
          Image.network(
            thumbnailUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey,
                height: 200,
                child: Center(
                  child: Text(
                    'Thumbnail not available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          // Display the video player
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            aspectRatio: 16 / 9, // Standard video aspect ratio
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Fix background color
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Menu',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ListTile(
              leading: Icon(Icons.video_collection, color: Colors.orange),
              title: Text('Add Video', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                // Handle add video
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.orange),
              title: Text('Add Document', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                // Handle add document
              },
            ),
            ListTile(
              leading: Icon(Icons.update, color: Colors.orange),
              title: Text('Update Cover', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                // Handle update cover
              },
            ),
          ],
        ),
      ),
    );
  }
}
