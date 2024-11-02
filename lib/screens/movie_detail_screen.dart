import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../widgets/rating_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;

  MovieDetailScreen({required this.id});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ApiService apiService = ApiService();
  Movie? movie;
  bool isLoading = false;
  String errorMessage = '';

  void getMovieDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final movieDetails = await apiService.getMovieDetails(widget.id);
      setState(() {
        movie = movieDetails;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : movie != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(movie!.poster),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie!.title, style: TextStyle(fontSize: 24)),
                            SizedBox(height: 8),
                            Text(movie!.year),
                            SizedBox(height: 16),
                            Text(movie!.description),
                            SizedBox(height: 16),
                            Text('Genre: ${movie!.genre}'),
                            SizedBox(height: 8),
                            Text('Release Date: ${movie!.releaseDate}'),
                            SizedBox(height: 8),
                            Text('Rating: ${movie!.rating}'),
                            SizedBox(height: 8),
                            RatingWidget(rating: movie!.rating),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: Text(errorMessage.isNotEmpty ? errorMessage : 'No movie found')),
    );
  }
}