import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  final String apiKey = '6252533b';
  final String baseUrl = 'http://www.omdbapi.com/';

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?s=$query&apikey=$apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Response'] == 'True') {
        return (data['Search'] as List).map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Movies not found');
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Movie> getMovieDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl?i=$id&apikey=$apiKey'));
    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}