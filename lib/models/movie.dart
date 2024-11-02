class Movie {
  final String title;
  final String year;
  final String poster;
  final String description;
  final String genre;
  final String releaseDate;
  final double rating;
  final String imdbID;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.description,
    required this.genre,
    required this.releaseDate,
    required this.rating,
    required this.imdbID,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      poster: json['Poster'],
      description: json['Plot'] ?? 'No description available',
      genre: json['Genre'] ?? 'N/A',
      releaseDate: json['Released'] ?? 'N/A',
      rating: double.tryParse(json['imdbRating'] ?? '0') ?? 0.0,
      imdbID: json['imdbID'],
    );
  }
}