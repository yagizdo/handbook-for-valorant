import 'package:in_app_review/in_app_review.dart';

class ReviewService {
  ReviewService({InAppReview? inAppReview}) : _inAppReview = inAppReview ?? InAppReview.instance;
  final InAppReview _inAppReview;

  Future<void> requestReview() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      }
    } on Exception catch (_) {
      // Graceful no-op on simulator or unsupported platforms
    }
  }
}
