// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';

class Hotel {
  const Hotel({
    @required this.id,
    @required this.stars,
    @required this.name,
    @required this.number,
    @required this.description,
    @required this.location,

  })  : assert(id != null),
        assert(stars != null),
        assert(name != null),
        assert(number != null),
        assert(location != null),
        assert(description != null);

  final int id;
  final String name;
  final String description;
  final String number;
  final int stars;
  final String location;


  String get assetName => 'assets/images/$id-0.jpg';

  @override
  String toString() => "$name (id=$id)";
}
