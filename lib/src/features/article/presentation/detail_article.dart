import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udaraku/src/features/article/presentation/article_viewmodel.dart';


class DetailArticle extends StatelessWidget {
  final String articleId;

  DetailArticle({required this.articleId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleViewModel()..fetchArticleById(articleId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<ArticleViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading || viewModel.selectedArticle == null) {
              return Center(child: CircularProgressIndicator());
            }

            final article = viewModel.selectedArticle!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          article.imageUrl,
                          width: 400,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 15),
                         Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            article.type,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          article.title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.8,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Penulis'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100)),
                            ),
                            Text(
                              'Diterbitkan'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.writer,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              article.date,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.8,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          article.content,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
