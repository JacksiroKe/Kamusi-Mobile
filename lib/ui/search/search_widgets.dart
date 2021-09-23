import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../cubit/cubit.dart';
import '../../../data/models/models.dart';

// ignore: must_be_immutable
class HistoryContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 130,
        child: Column(
          children: [
            Text(
              'HISTORIA',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              height: 105,
              child: Swiper(
                itemCount: KamusiCubit.get(context).histories.length,
                itemBuilder: (BuildContext context, int index) {
                  return WordContainer(
                    'Histories_' +
                        KamusiCubit.get(context).histories[index].id.toString(),
                    KamusiCubit.get(context).histories[index],
                  );
                },
                itemWidth: 250,
                itemHeight: 200,
                layout: SwiperLayout.TINDER,
                autoplay: true,
                duration: 5000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 130,
        child: Column(
          children: [
            Text(
              'VIPENDWA',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              height: 105,
              child: Swiper(
                itemCount: KamusiCubit.get(context).favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return WordContainer(
                    'Favorites_' +
                        KamusiCubit.get(context).favorites[index].id.toString(),
                    KamusiCubit.get(context).favorites[index],
                  );
                },
                itemWidth: 250,
                itemHeight: 200,
                layout: SwiperLayout.TINDER,
                autoplay: true,
                duration: 5000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WordContainer extends StatelessWidget {
  final String heroTag;
  final Word word;

  WordContainer(this.heroTag, this.word);

  String? wordMeaning;
  var wordMeanings, wordExtra, wordSynonyms;

  @override
  Widget build(BuildContext context) {
    wordMeaning = word.meaning.replaceAll("\\", "");
    wordMeaning = wordMeaning!.replaceAll('"', '');
    wordMeaning = wordMeaning!.replaceAll(',', ', ');
    wordMeaning = wordMeaning!.replaceAll('  ', ' ');

    wordMeanings = wordMeaning!.split("|");
    wordExtra = wordMeanings[0].split(":");
    wordSynonyms = word.synonyms.split(',');

    wordMeaning = " ~ " + wordExtra[0].trim() + ".";

    return Card(
      elevation: 5,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                word.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '~ ' + wordMeanings[0],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        onTap: () {
          //navigateToViewer(context, word);
        },
      ),
    );
  }
}
