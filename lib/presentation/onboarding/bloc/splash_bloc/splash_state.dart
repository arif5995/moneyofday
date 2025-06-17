part of 'splash_cubit.dart';

@immutable
class SplashState extends Equatable {
  final ViewData<bool> splashState;
  final ViewData<int> category;

  const SplashState({required this.splashState, required this.category});

  SplashState copyWith({
    ViewData<bool>? splashState,
    ViewData<int>? category,
  }) {
    return SplashState(
      splashState: splashState ?? this.splashState,
      category: category ?? this.category,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [splashState, category];
}
