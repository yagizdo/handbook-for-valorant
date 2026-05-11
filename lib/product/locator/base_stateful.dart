import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/product/locator/base_container.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

mixin BaseStateful<T extends StatefulWidget> on State<T> {
  ProductNetworkModel get networkModel => BaseContainer.instance.networkModel;
}
