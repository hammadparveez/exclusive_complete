
import 'package:sixvalley_ui_kit/data/model/response/tracking_model.dart';

class TrackingRepo {

  TrackingModel getTrackingInfo() {
    TrackingModel trackingModel = TrackingModel(id: 1, customerId: '1', customerType: 'user', paymentStatus: 'pending', orderStatus: 'pending', orderAmount: '10000', shippingAddress: 'Dhaka, Bangladesh', discountAmount: '1000', discountType: 'percent');
    return trackingModel;
  }
}