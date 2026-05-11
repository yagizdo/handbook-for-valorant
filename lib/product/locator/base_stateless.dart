import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/product/locator/base_container.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

mixin BaseStateless on StatelessWidget {
  ProductNetworkModel get networkModel => BaseContainer.instance.networkModel;
}
