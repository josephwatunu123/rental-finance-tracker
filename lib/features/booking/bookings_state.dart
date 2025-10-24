

class BookingsPageState{
  final String? error;
  final bool isLoading;

  BookingsPageState({
    this.error,
    this.isLoading=false,
});

  BookingsPageState copyWith({
    String? error,
    bool? isLoading,
}) {
    return BookingsPageState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading
    );
  }

}