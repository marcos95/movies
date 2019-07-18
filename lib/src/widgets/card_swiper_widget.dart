import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final container = Container(
      padding: EdgeInsetsDirectional.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * .7,
        itemHeight: _screenSize.height * .5,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-swiper';
          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'detail',
                      arguments: movies[index]);
                },
              ),
            ),
          );
        },
        itemCount: movies.length,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
    return container;
  }
}
