

class BookingsPageState{
  final String? error;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isLoading;

  BookingsPageState({
    this.error,
    this.startDate,
    this.endDate,
    this.isLoading=false,
});

  BookingsPageState copyWith({
    String? error,
    DateTime? startDate,
    DateTime? endDate,
    bool? isLoading,
}) {
    return BookingsPageState(
      error: error ?? this.error,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isLoading: isLoading ?? this.isLoading
    );
  }

}