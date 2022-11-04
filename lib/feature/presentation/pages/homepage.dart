import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/news_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Wrap your page with Bloc provider to trigger news fetch using GetNews event.
    return BlocProvider(
      create: (context) => NewsBloc()..add(GetNews()),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),

        // Add a builder to rebuild UI on state changes.
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            switch (state.status) {
              case NewsStatus.loading:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case NewsStatus.error:
                if (state.articles.isEmpty) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                return NewsList(articles: state.articles);

              case NewsStatus.loaded:
                return NewsList(articles: state.articles);
              default:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
            }
          },
        ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List articles;
  const NewsList({
    required this.articles,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Divider(),
      ),
      itemBuilder: (BuildContext context, int index) {
        // Grab new items
        var article = articles[index];
        var title = article['title'];
        var description = article['description'];
        var image = article['urlToImage'];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: AspectRatio(
                aspectRatio: 1,
                child: image != null
                    ? CachedNetworkImage(
                        imageUrl: image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.broken_image_sharp),
                        ),
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        size: 30,
                      ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description ?? '',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
