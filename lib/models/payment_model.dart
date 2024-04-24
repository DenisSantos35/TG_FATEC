
import 'package:scoped_model/scoped_model.dart';

class PaymentModel extends Model{
  String? paymentType;
  List<String> typePyment = ["A Vista", "A Prazo"];
  PaymentModel();
  static PaymentModel of(context) => ScopedModel.of<PaymentModel>(context);

}