import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final _movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    _movieProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child:
                Text('Populares', style: Theme.of(context).textTheme.subhead),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream: _movieProvider.popularMoviesStream,
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data, nextPage: _movieProvider.getPopular,);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: _movieProvider.getNowPlaying(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
