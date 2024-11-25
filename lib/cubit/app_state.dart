part of 'app_cubit.dart';

class AppState extends Equatable {
  final int currentIndex;
  final List<BikeModel> bikes;
  final double dragPositionCheckout;
  final double dragPositionApply;
  final bool offCodeApplaied;
  final bool showLikeAnim;
  final int likedItemIndex; // Add this line

  const AppState(
      {required this.currentIndex,
      required this.dragPositionApply,
      required this.bikes,
      required this.dragPositionCheckout,
      required this.offCodeApplaied,
      required this.showLikeAnim,
      required this.likedItemIndex});

  AppState copyWith({
    int? currentIndex,
    double? dragPositionCheckout,
    double? dragPositionApply,
    List<BikeModel>? bikes,
    bool? offCodeApplaied,
    bool? showLikeAnim,
    int? likedItemIndex,
  }) {
    return AppState(
        currentIndex: currentIndex ?? this.currentIndex,
        bikes: bikes ?? this.bikes,
        dragPositionApply: dragPositionApply ?? this.dragPositionApply,
        dragPositionCheckout: dragPositionCheckout ?? this.dragPositionCheckout,
        offCodeApplaied: offCodeApplaied ?? this.offCodeApplaied,
        showLikeAnim: showLikeAnim ?? this.showLikeAnim,
        likedItemIndex: likedItemIndex ?? this.likedItemIndex);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        bikes,
        dragPositionCheckout,
        dragPositionApply,
        offCodeApplaied,
        showLikeAnim,
        likedItemIndex,
        
      ];
}
