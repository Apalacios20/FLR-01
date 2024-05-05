// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CryptoData {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final List tags;
  final int? maxSupply;
  final double circulatingSupply;
  final double totalSupply;
  final bool infiniteSupply;
  final int cmcRank;
  final double price;
  final double twentyFourHrVolume;
  final double twentyFourHrVolumeChange;
  final double oneHrPercentChange;
  final double twentyFourHrPercentChange;
  final double sevenDayPercentChange;
  final double thirtyDayPercentChange;
  final double sixtyDayPercentChange;
  final double ninetyDayPercentChange;
  final double marketCap;
  final double marketCapDominance;
  final double fullyDilutedMarketCap;

  CryptoData({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.tags,
    required this.maxSupply,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.infiniteSupply,
    required this.cmcRank,
    required this.price,
    required this.twentyFourHrVolume,
    required this.twentyFourHrVolumeChange,
    required this.oneHrPercentChange,
    required this.twentyFourHrPercentChange,
    required this.sevenDayPercentChange,
    required this.thirtyDayPercentChange,
    required this.sixtyDayPercentChange,
    required this.ninetyDayPercentChange,
    required this.marketCap,
    required this.marketCapDominance,
    required this.fullyDilutedMarketCap,
  });

  CryptoData copyWith({
    int? id,
    String? name,
    String? symbol,
    String? slug,
    List? tags,
    int? maxSupply,
    double? circulatingSupply,
    double? totalSupply,
    bool? infiniteSupply,
    int? cmcRank,
    double? price,
    double? twentyFourHrVolume,
    double? twentyFourHrVolumeChange,
    double? oneHrPercentChange,
    double? twentyFourHrPercentChange,
    double? sevenDayPercentChange,
    double? thirtyDayPercentChange,
    double? sixtyDayPercentChange,
    double? ninetyDayPercentChange,
    double? marketCap,
    double? marketCapDominance,
    double? fullyDilutedMarketCap,
  }) {
    return CryptoData(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      slug: slug ?? this.slug,
      tags: tags ?? this.tags,
      maxSupply: maxSupply ?? this.maxSupply,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      infiniteSupply: infiniteSupply ?? this.infiniteSupply,
      cmcRank: cmcRank ?? this.cmcRank,
      price: price ?? this.price,
      twentyFourHrVolume: twentyFourHrVolume ?? this.twentyFourHrVolume,
      twentyFourHrVolumeChange:
          twentyFourHrVolumeChange ?? this.twentyFourHrVolumeChange,
      oneHrPercentChange: oneHrPercentChange ?? this.oneHrPercentChange,
      twentyFourHrPercentChange:
          twentyFourHrPercentChange ?? this.twentyFourHrPercentChange,
      sevenDayPercentChange:
          sevenDayPercentChange ?? this.sevenDayPercentChange,
      thirtyDayPercentChange:
          thirtyDayPercentChange ?? this.thirtyDayPercentChange,
      sixtyDayPercentChange:
          sixtyDayPercentChange ?? this.sixtyDayPercentChange,
      ninetyDayPercentChange:
          ninetyDayPercentChange ?? this.ninetyDayPercentChange,
      marketCap: marketCap ?? this.marketCap,
      marketCapDominance: marketCapDominance ?? this.marketCapDominance,
      fullyDilutedMarketCap:
          fullyDilutedMarketCap ?? this.fullyDilutedMarketCap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
      'slug': slug,
      'tags': tags,
      'maxSupply': maxSupply,
      'circulatingSupply': circulatingSupply,
      'totalSupply': totalSupply,
      'infiniteSupply': infiniteSupply,
      'cmcRank': cmcRank,
      'price': price,
      'twentyFourHrVolume': twentyFourHrVolume,
      'twentyFourHrVolumeChange': twentyFourHrVolumeChange,
      'oneHrPercentChange': oneHrPercentChange,
      'twentyFourHrPercentChange': twentyFourHrPercentChange,
      'sevenDayPercentChange': sevenDayPercentChange,
      'thirtyDayPercentChange': thirtyDayPercentChange,
      'sixtyDayPercentChange': sixtyDayPercentChange,
      'ninetyDayPercentChange': ninetyDayPercentChange,
      'marketCap': marketCap,
      'marketCapDominance': marketCapDominance,
      'fullyDilutedMarketCap': fullyDilutedMarketCap,
    };
  }

  // factory CryptoData.fromMap(Map<String, dynamic> map) {
  //   return CryptoData(
  //     id: map['id'] as int,
  //     name: map['name'] as String,
  //     symbol: map['symbol'] as String,
  //     slug: map['slug'] as String,
  //     tags: map['tags'] as List,
  //     maxSupply: map['max_supply'] as int,
  //     circulatingSupply: map['circulating_supply'] as double,
  //     totalSupply: map['total_supply'] as double,
  //     infiniteSupply: map['infinite_supply'] as bool,
  //     cmcRank: map['cmc_rank'] as int,
  //     price: map['quote']['USD']['price'] as double,
  //     twentyFourHrVolume: map['quote']['USD']['volume_24h'] as double,
  //     twentyFourHrVolumeChange:
  //         map['quote']['USD']['volume_change_24h'] as double,
  //     oneHrPercentChange: map['quote']['USD']['percent_change_1h'] as double,
  //     twentyFourHrPercentChange:
  //         map['quote']['USD']['percent_change_24h'] as double,
  //     sevenDayPercentChange: map['quote']['USD']['percent_change_7d'] as double,
  //     thirtyDayPercentChange:
  //         map['quote']['USD']['percent_change_30d'] as double,
  //     sixtyDayPercentChange:
  //         map['quote']['USD']['percent_change_60d'] as double,
  //     ninetyDayPercentChange:
  //         map['quote']['USD']['percent_change_90d'] as double,
  //     marketCap: map['quote']['USD']['market_cap'] as double,
  //     marketCapDominance: map['quote']['USD']['market_cap_dominance'] as double,
  //     fullyDilutedMarketCap:
  //         map['quote']['USD']['fully_diluted_market_cap'] as double,
  //   );
  // }
  factory CryptoData.fromMap(Map<String, dynamic> map) {
    return CryptoData(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      slug: map['slug'] as String,
      tags: List<String>.from(map['tags']),
      maxSupply: map['max_supply'] != null ? map['max_supply'] as int : null,
      circulatingSupply: map['circulating_supply'] as double,
      totalSupply: map['total_supply'] as double,
      infiniteSupply: map['infinite_supply'] as bool,
      cmcRank: map['cmc_rank'] as int,
      price: (map['quote']['USD']['price'] as num).toDouble(),
      twentyFourHrVolume: (map['quote']['USD']['volume_24h'] as num).toDouble(),
      twentyFourHrVolumeChange:
          (map['quote']['USD']['volume_change_24h'] as num).toDouble(),
      oneHrPercentChange:
          (map['quote']['USD']['percent_change_1h'] as num).toDouble(),
      twentyFourHrPercentChange:
          (map['quote']['USD']['percent_change_24h'] as num).toDouble(),
      sevenDayPercentChange:
          (map['quote']['USD']['percent_change_7d'] as num).toDouble(),
      thirtyDayPercentChange:
          (map['quote']['USD']['percent_change_30d'] as num).toDouble(),
      sixtyDayPercentChange:
          (map['quote']['USD']['percent_change_60d'] as num).toDouble(),
      ninetyDayPercentChange:
          (map['quote']['USD']['percent_change_90d'] as num).toDouble(),
      marketCap: (map['quote']['USD']['market_cap'] as num).toDouble(),
      marketCapDominance:
          (map['quote']['USD']['market_cap_dominance'] as num).toDouble(),
      fullyDilutedMarketCap:
          (map['quote']['USD']['fully_diluted_market_cap'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoData.fromJson(String source) =>
      CryptoData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CryptoData(id: $id, name: $name, symbol: $symbol, slug: $slug, tags: $tags, maxSupply: $maxSupply, circulatingSupply: $circulatingSupply, totalSupply: $totalSupply, infiniteSupply: $infiniteSupply, cmcRank: $cmcRank, price: $price, twentyFourHrVolume: $twentyFourHrVolume, twentyFourHrVolumeChange: $twentyFourHrVolumeChange, oneHrPercentChange: $oneHrPercentChange, twentyFourHrPercentChange: $twentyFourHrPercentChange, sevenDayPercentChange: $sevenDayPercentChange, thirtyDayPercentChange: $thirtyDayPercentChange, sixtyDayPercentChange: $sixtyDayPercentChange, ninetyDayPercentChange: $ninetyDayPercentChange, marketCap: $marketCap, marketCapDominance: $marketCapDominance, fullyDilutedMarketCap: $fullyDilutedMarketCap)';
  }

  @override
  bool operator ==(covariant CryptoData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.slug == slug &&
        listEquals(other.tags, tags) &&
        other.maxSupply == maxSupply &&
        other.circulatingSupply == circulatingSupply &&
        other.totalSupply == totalSupply &&
        other.infiniteSupply == infiniteSupply &&
        other.cmcRank == cmcRank &&
        other.price == price &&
        other.twentyFourHrVolume == twentyFourHrVolume &&
        other.twentyFourHrVolumeChange == twentyFourHrVolumeChange &&
        other.oneHrPercentChange == oneHrPercentChange &&
        other.twentyFourHrPercentChange == twentyFourHrPercentChange &&
        other.sevenDayPercentChange == sevenDayPercentChange &&
        other.thirtyDayPercentChange == thirtyDayPercentChange &&
        other.sixtyDayPercentChange == sixtyDayPercentChange &&
        other.ninetyDayPercentChange == ninetyDayPercentChange &&
        other.marketCap == marketCap &&
        other.marketCapDominance == marketCapDominance &&
        other.fullyDilutedMarketCap == fullyDilutedMarketCap;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        slug.hashCode ^
        tags.hashCode ^
        maxSupply.hashCode ^
        circulatingSupply.hashCode ^
        totalSupply.hashCode ^
        infiniteSupply.hashCode ^
        cmcRank.hashCode ^
        price.hashCode ^
        twentyFourHrVolume.hashCode ^
        twentyFourHrVolumeChange.hashCode ^
        oneHrPercentChange.hashCode ^
        twentyFourHrPercentChange.hashCode ^
        sevenDayPercentChange.hashCode ^
        thirtyDayPercentChange.hashCode ^
        sixtyDayPercentChange.hashCode ^
        ninetyDayPercentChange.hashCode ^
        marketCap.hashCode ^
        marketCapDominance.hashCode ^
        fullyDilutedMarketCap.hashCode;
  }
}
