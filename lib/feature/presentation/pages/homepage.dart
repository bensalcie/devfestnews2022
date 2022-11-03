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
                  child: CircularProgressIndicator(),
                );
              case NewsStatus.error:
                return const Center(
                  child: Text('Something went wrong'),
                );
              case NewsStatus.loaded:
                return ListView.separated(
                  itemCount: state.articles.length,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Divider(),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Grab new items
                    var article = state.articles[index];
                    var title = article['title'];
                    var description = article['description'];
                    var image = article['urlToImage'];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: image != null
                                  ? Image.network(image)
                                  : const Icon(
                                      Icons.gavel,
                                      size: 30,
                                    ),
                            )),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
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
                        ),
                      ],
                    );
                  },
                );
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
