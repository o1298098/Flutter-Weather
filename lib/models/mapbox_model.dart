import 'dart:convert' show json;

class MapBoxModel {
  String attribution;
  String type;
  List<FeatureData> features;
  List<double> query;

  MapBoxModel.fromParams(
      {this.attribution, this.type, this.features, this.query});

  factory MapBoxModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MapBoxModel.fromJson(json.decode(jsonStr))
          : new MapBoxModel.fromJson(jsonStr);

  MapBoxModel.fromJson(jsonRes) {
    attribution = jsonRes['attribution'];
    type = jsonRes['type'];
    features = jsonRes['features'] == null ? null : [];

    for (var featuresItem in features == null ? [] : jsonRes['features']) {
      features.add(
          featuresItem == null ? null : new FeatureData.fromJson(featuresItem));
    }

    query = jsonRes['query'] == null ? null : [];

    for (var queryItem in query == null ? [] : jsonRes['query']) {
      query.add(queryItem);
    }
  }

  @override
  String toString() {
    return '{"attribution": ${attribution != null ? '${json.encode(attribution)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"features": $features,"query": $query}';
  }
}

class FeatureData {
  int relevance;
  String id;
  String placeName;
  String text;
  String type;
  List<double> bbox;
  List<double> center;
  List<ContextData> context;
  List<String> placeType;
  Geometry geometry;
  Properties properties;

  FeatureData.fromParams(
      {this.relevance,
      this.id,
      this.placeName,
      this.text,
      this.type,
      this.bbox,
      this.center,
      this.context,
      this.placeType,
      this.geometry,
      this.properties});

  FeatureData.fromJson(jsonRes) {
    relevance = jsonRes['relevance'];
    id = jsonRes['id'];
    placeName = jsonRes['place_name'];
    text = jsonRes['text'];
    type = jsonRes['type'];
    bbox = jsonRes['bbox'] == null ? null : [];

    for (var bboxItem in bbox == null ? [] : jsonRes['bbox']) {
      bbox.add(bboxItem);
    }

    center = jsonRes['center'] == null ? null : [];

    for (var centerItem in center == null ? [] : jsonRes['center']) {
      center.add(double.parse(centerItem.toString() ?? '0.0'));
    }

    context = jsonRes['context'] == null ? null : [];

    for (var contextItem in context == null ? [] : jsonRes['context']) {
      context.add(
          contextItem == null ? null : new ContextData.fromJson(contextItem));
    }

    placeType = jsonRes['place_type'] == null ? null : [];

    for (var placeTypeItem in placeType == null ? [] : jsonRes['place_type']) {
      placeType.add(placeTypeItem);
    }

    geometry = jsonRes['geometry'] == null
        ? null
        : new Geometry.fromJson(jsonRes['geometry']);
    properties = jsonRes['properties'] == null
        ? null
        : new Properties.fromJson(jsonRes['properties']);
  }

  @override
  String toString() {
    return '{"relevance": $relevance,"id": ${id != null ? '${json.encode(id)}' : 'null'},"place_name": ${placeName != null ? '${json.encode(placeName)}' : 'null'},"text": ${text != null ? '${json.encode(text)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"bbox": $bbox,"center": $center,"context": $context,"place_type": $placeType,"geometry": $geometry,"properties": $properties}';
  }
}

class Properties {
  String wikidata;

  Properties.fromParams({this.wikidata});

  Properties.fromJson(jsonRes) {
    wikidata = jsonRes['wikidata'];
  }

  @override
  String toString() {
    return '{"wikidata": ${wikidata != null ? '${json.encode(wikidata)}' : 'null'}}';
  }
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry.fromParams({this.type, this.coordinates});

  Geometry.fromJson(jsonRes) {
    type = jsonRes['type'];
    coordinates = jsonRes['coordinates'] == null ? null : [];

    for (var coordinatesItem
        in coordinates == null ? [] : jsonRes['coordinates']) {
      coordinates.add(double.parse(coordinatesItem.toString() ?? '0.0'));
    }
  }

  @override
  String toString() {
    return '{"type": ${type != null ? '${json.encode(type)}' : 'null'},"coordinates": $coordinates}';
  }
}

class ContextData {
  String id;
  String shortCode;
  String text;
  String wikidata;

  ContextData.fromParams({this.id, this.shortCode, this.text, this.wikidata});

  ContextData.fromJson(jsonRes) {
    id = jsonRes['id'];
    shortCode = jsonRes['short_code'];
    text = jsonRes['text'];
    wikidata = jsonRes['wikidata'];
  }

  @override
  String toString() {
    return '{"id": ${id != null ? '${json.encode(id)}' : 'null'},"short_code": ${shortCode != null ? '${json.encode(shortCode)}' : 'null'},"text": ${text != null ? '${json.encode(text)}' : 'null'},"wikidata": ${wikidata != null ? '${json.encode(wikidata)}' : 'null'}}';
  }
}
