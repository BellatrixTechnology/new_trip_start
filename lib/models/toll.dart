import 'package:json_annotation/json_annotation.dart';

part 'toll.g.dart';

@JsonSerializable(createToJson: false)
class Toll {
  Toll({
    required this.vegobjekt,
  });

  final Vegobjekt? vegobjekt;

  factory Toll.fromJson(Map<String, dynamic> json) => _$TollFromJson(json);

  @override
  String toString() {
    return "$vegobjekt, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegobjekt {
  Vegobjekt({
    required this.id,
    required this.href,
    required this.metadata,
    required this.egenskaper,
    required this.geometri,
    required this.lokasjon,
    required this.vegsegmenter,
    required this.relasjoner,
  });

  final String? id;
  final String? href;
  final Metadata? metadata;
  final Egenskaper? egenskaper;
  final VegobjektGeometri? geometri;
  final Lokasjon? lokasjon;
  final Vegsegmenter? vegsegmenter;
  final Relasjoner? relasjoner;

  factory Vegobjekt.fromJson(Map<String, dynamic> json) =>
      _$VegobjektFromJson(json);

  @override
  String toString() {
    return "$id, $href, $metadata, $egenskaper, $geometri, $lokasjon, $vegsegmenter, $relasjoner, ";
  }
}

@JsonSerializable(createToJson: false)
class Egenskaper {
  Egenskaper({
    required this.egenskap,
  });

  final List<EgenskapElement>? egenskap;

  factory Egenskaper.fromJson(Map<String, dynamic> json) =>
      _$EgenskaperFromJson(json);

  @override
  String toString() {
    return "$egenskap, ";
  }
}

@JsonSerializable(createToJson: false)
class EgenskapElement {
  EgenskapElement({
    required this.id,
    required this.navn,
    required this.egenskapstype,
    required this.datatype,
    required this.stedfestingstype,
    required this.veglenkesekvensid,
    required this.relativPosisjon,
    required this.retning,
    required this.kjrefelt,
    required this.innhold,
    required this.verdi,
    required this.enumId,
    required this.enhet,
  });

  final String? id;
  final String? navn;
  final String? egenskapstype;
  final String? datatype;
  final String? stedfestingstype;
  final String? veglenkesekvensid;
  final String? relativPosisjon;
  final String? retning;

  @JsonKey(name: 'kjørefelt')
  final Kjrefelt? kjrefelt;
  final Innhold? innhold;
  final String? verdi;

  @JsonKey(name: 'enum_id')
  final String? enumId;
  final Enhet? enhet;

  factory EgenskapElement.fromJson(Map<String, dynamic> json) =>
      _$EgenskapElementFromJson(json);

  @override
  String toString() {
    return "$id, $navn, $egenskapstype, $datatype, $stedfestingstype, $veglenkesekvensid, $relativPosisjon, $retning, $kjrefelt, $innhold, $verdi, $enumId, $enhet, ";
  }
}

@JsonSerializable(createToJson: false)
class Enhet {
  Enhet({
    required this.id,
    required this.navn,
    required this.kortnavn,
  });

  final String? id;
  final String? navn;
  final String? kortnavn;

  factory Enhet.fromJson(Map<String, dynamic> json) => _$EnhetFromJson(json);

  @override
  String toString() {
    return "$id, $navn, $kortnavn, ";
  }
}

@JsonSerializable(createToJson: false)
class Innhold {
  Innhold({
    required this.egenskap,
  });

  final InnholdEgenskap? egenskap;

  factory Innhold.fromJson(Map<String, dynamic> json) =>
      _$InnholdFromJson(json);

  @override
  String toString() {
    return "$egenskap, ";
  }
}

@JsonSerializable(createToJson: false)
class InnholdEgenskap {
  InnholdEgenskap({
    required this.id,
    required this.navn,
    required this.egenskapstype,
    required this.datatype,
    required this.verdi,
  });

  final String? id;
  final String? navn;
  final String? egenskapstype;
  final String? datatype;
  final String? verdi;

  factory InnholdEgenskap.fromJson(Map<String, dynamic> json) =>
      _$InnholdEgenskapFromJson(json);

  @override
  String toString() {
    return "$id, $navn, $egenskapstype, $datatype, $verdi, ";
  }
}

@JsonSerializable(createToJson: false)
class Kjrefelt {
  Kjrefelt({
    required this.felt,
  });

  final List<String>? felt;

  factory Kjrefelt.fromJson(Map<String, dynamic> json) =>
      _$KjrefeltFromJson(json);

  @override
  String toString() {
    return "$felt, ";
  }
}

@JsonSerializable(createToJson: false)
class VegobjektGeometri {
  VegobjektGeometri({
    required this.wkt,
    required this.srid,
    required this.egengeometri,
  });

  final String? wkt;
  final String? srid;
  final String? egengeometri;

  factory VegobjektGeometri.fromJson(Map<String, dynamic> json) =>
      _$VegobjektGeometriFromJson(json);

  @override
  String toString() {
    return "$wkt, $srid, $egengeometri, ";
  }
}

@JsonSerializable(createToJson: false)
class Lokasjon {
  Lokasjon({
    required this.kommuner,
    required this.fylker,
    required this.kontraktsomrder,
    required this.gater,
    required this.vegsystemreferanser,
    required this.stedfestinger,
    required this.geometri,
  });

  final Kommuner? kommuner;
  final Fylker? fylker;

  @JsonKey(name: 'kontraktsområder')
  final Kontraktsomrder? kontraktsomrder;
  final LokasjonGater? gater;
  final Vegsystemreferanser? vegsystemreferanser;
  final Stedfestinger? stedfestinger;
  final LokasjonGeometri? geometri;

  factory Lokasjon.fromJson(Map<String, dynamic> json) =>
      _$LokasjonFromJson(json);

  @override
  String toString() {
    return "$kommuner, $fylker, $kontraktsomrder, $gater, $vegsystemreferanser, $stedfestinger, $geometri, ";
  }
}

@JsonSerializable(createToJson: false)
class Fylker {
  Fylker({
    required this.fylke,
  });

  final String? fylke;

  factory Fylker.fromJson(Map<String, dynamic> json) => _$FylkerFromJson(json);

  @override
  String toString() {
    return "$fylke, ";
  }
}

@JsonSerializable(createToJson: false)
class LokasjonGater {
  LokasjonGater({
    required this.gater,
  });

  final GaterGater? gater;

  factory LokasjonGater.fromJson(Map<String, dynamic> json) =>
      _$LokasjonGaterFromJson(json);

  @override
  String toString() {
    return "$gater, ";
  }
}

@JsonSerializable(createToJson: false)
class GaterGater {
  GaterGater({
    required this.gatekode,
    required this.navn,
  });

  final String? gatekode;
  final String? navn;

  factory GaterGater.fromJson(Map<String, dynamic> json) =>
      _$GaterGaterFromJson(json);

  @override
  String toString() {
    return "$gatekode, $navn, ";
  }
}

@JsonSerializable(createToJson: false)
class LokasjonGeometri {
  LokasjonGeometri({
    required this.wkt,
    required this.srid,
  });

  final String? wkt;
  final String? srid;

  factory LokasjonGeometri.fromJson(Map<String, dynamic> json) =>
      _$LokasjonGeometriFromJson(json);

  @override
  String toString() {
    return "$wkt, $srid, ";
  }
}

@JsonSerializable(createToJson: false)
class Kommuner {
  Kommuner({
    required this.kommune,
  });

  final String? kommune;

  factory Kommuner.fromJson(Map<String, dynamic> json) =>
      _$KommunerFromJson(json);

  @override
  String toString() {
    return "$kommune, ";
  }
}

@JsonSerializable(createToJson: false)
class Kontraktsomrder {
  Kontraktsomrder({
    required this.kontraktsomrde,
  });

  @JsonKey(name: 'kontraktsområde')
  final List<Kontraktsomrde>? kontraktsomrde;

  factory Kontraktsomrder.fromJson(Map<String, dynamic> json) =>
      _$KontraktsomrderFromJson(json);

  @override
  String toString() {
    return "$kontraktsomrde, ";
  }
}

@JsonSerializable(createToJson: false)
class Kontraktsomrde {
  Kontraktsomrde({
    required this.id,
    required this.nummer,
    required this.navn,
  });

  final String? id;
  final String? nummer;
  final String? navn;

  factory Kontraktsomrde.fromJson(Map<String, dynamic> json) =>
      _$KontraktsomrdeFromJson(json);

  @override
  String toString() {
    return "$id, $nummer, $navn, ";
  }
}

@JsonSerializable(createToJson: false)
class Stedfestinger {
  Stedfestinger({
    required this.stedfesting,
  });

  final Stedfesting? stedfesting;

  factory Stedfestinger.fromJson(Map<String, dynamic> json) =>
      _$StedfestingerFromJson(json);

  @override
  String toString() {
    return "$stedfesting, ";
  }
}

@JsonSerializable(createToJson: false)
class Stedfesting {
  Stedfesting({
    required this.type,
    required this.veglenkesekvensid,
    required this.relativPosisjon,
    required this.kortform,
    required this.retning,
    required this.kjrefelt,
  });

  final String? type;
  final String? veglenkesekvensid;
  final String? relativPosisjon;
  final String? kortform;
  final String? retning;

  @JsonKey(name: 'kjørefelt')
  final Kjrefelt? kjrefelt;

  factory Stedfesting.fromJson(Map<String, dynamic> json) =>
      _$StedfestingFromJson(json);

  @override
  String toString() {
    return "$type, $veglenkesekvensid, $relativPosisjon, $kortform, $retning, $kjrefelt, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegsystemreferanser {
  Vegsystemreferanser({
    required this.vegsystemreferanse,
  });

  final Vegsystemreferanse? vegsystemreferanse;

  factory Vegsystemreferanser.fromJson(Map<String, dynamic> json) =>
      _$VegsystemreferanserFromJson(json);

  @override
  String toString() {
    return "$vegsystemreferanse, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegsystemreferanse {
  Vegsystemreferanse({
    required this.vegsystem,
    required this.strekning,
    required this.kortform,
  });

  final Vegsystem? vegsystem;
  final Strekning? strekning;
  final String? kortform;

  factory Vegsystemreferanse.fromJson(Map<String, dynamic> json) =>
      _$VegsystemreferanseFromJson(json);

  @override
  String toString() {
    return "$vegsystem, $strekning, $kortform, ";
  }
}

@JsonSerializable(createToJson: false)
class Strekning {
  Strekning({
    required this.id,
    required this.versjon,
    required this.strekning,
    required this.delstrekning,
    required this.arm,
    required this.adskilteLp,
    required this.trafikantgruppe,
    required this.meter,
    required this.retning,
  });

  final String? id;
  final String? versjon;
  final String? strekning;
  final String? delstrekning;
  final String? arm;

  @JsonKey(name: 'adskilte_løp')
  final String? adskilteLp;
  final String? trafikantgruppe;
  final String? meter;
  final String? retning;

  factory Strekning.fromJson(Map<String, dynamic> json) =>
      _$StrekningFromJson(json);

  @override
  String toString() {
    return "$id, $versjon, $strekning, $delstrekning, $arm, $adskilteLp, $trafikantgruppe, $meter, $retning, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegsystem {
  Vegsystem({
    required this.id,
    required this.versjon,
    required this.vegkategori,
    required this.fase,
    required this.nummer,
  });

  final String? id;
  final String? versjon;
  final String? vegkategori;
  final String? fase;
  final String? nummer;

  factory Vegsystem.fromJson(Map<String, dynamic> json) =>
      _$VegsystemFromJson(json);

  @override
  String toString() {
    return "$id, $versjon, $vegkategori, $fase, $nummer, ";
  }
}

@JsonSerializable(createToJson: false)
class Metadata {
  Metadata({
    required this.type,
    required this.versjon,
    required this.sistModifisert,
    required this.startdato,
  });

  final Type? type;
  final String? versjon;

  @JsonKey(name: 'sist_modifisert')
  final DateTime? sistModifisert;
  final DateTime? startdato;

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  @override
  String toString() {
    return "$type, $versjon, $sistModifisert, $startdato, ";
  }
}

@JsonSerializable(createToJson: false)
class Type {
  Type({
    required this.id,
    required this.navn,
  });

  final String? id;
  final String? navn;

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  @override
  String toString() {
    return "$id, $navn, ";
  }
}

@JsonSerializable(createToJson: false)
class Relasjoner {
  Relasjoner({
    required this.barn,
  });

  final RelasjonerBarn? barn;

  factory Relasjoner.fromJson(Map<String, dynamic> json) =>
      _$RelasjonerFromJson(json);

  @override
  String toString() {
    return "$barn, ";
  }
}

@JsonSerializable(createToJson: false)
class RelasjonerBarn {
  RelasjonerBarn({
    required this.barn,
  });

  final BarnBarn? barn;

  factory RelasjonerBarn.fromJson(Map<String, dynamic> json) =>
      _$RelasjonerBarnFromJson(json);

  @override
  String toString() {
    return "$barn, ";
  }
}

@JsonSerializable(createToJson: false)
class BarnBarn {
  BarnBarn({
    required this.listeid,
    required this.id,
    required this.type,
    required this.vegobjekter,
  });

  final String? listeid;
  final String? id;
  final Type? type;
  final Vegobjekter? vegobjekter;

  factory BarnBarn.fromJson(Map<String, dynamic> json) =>
      _$BarnBarnFromJson(json);

  @override
  String toString() {
    return "$listeid, $id, $type, $vegobjekter, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegobjekter {
  Vegobjekter({
    required this.id,
  });

  final String? id;

  factory Vegobjekter.fromJson(Map<String, dynamic> json) =>
      _$VegobjekterFromJson(json);

  @override
  String toString() {
    return "$id, ";
  }
}

@JsonSerializable(createToJson: false)
class Vegsegmenter {
  Vegsegmenter({
    required this.segment,
  });

  final Segment? segment;

  factory Vegsegmenter.fromJson(Map<String, dynamic> json) =>
      _$VegsegmenterFromJson(json);

  @override
  String toString() {
    return "$segment, ";
  }
}

@JsonSerializable(createToJson: false)
class Segment {
  Segment({
    required this.veglenkesekvensid,
    required this.relativPosisjon,
    required this.retning,
    required this.veglenkeType,
    required this.detaljniv,
    required this.typeVeg,
    required this.typeVegSosi,
    required this.startdato,
    required this.geometri,
    required this.kommune,
    required this.fylke,
    required this.vegsystemreferanse,
  });

  final String? veglenkesekvensid;
  final String? relativPosisjon;
  final String? retning;
  final String? veglenkeType;

  @JsonKey(name: 'detaljnivå')
  final String? detaljniv;
  final String? typeVeg;

  @JsonKey(name: 'typeVeg_sosi')
  final String? typeVegSosi;
  final DateTime? startdato;
  final LokasjonGeometri? geometri;
  final String? kommune;
  final String? fylke;
  final Vegsystemreferanse? vegsystemreferanse;

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

  @override
  String toString() {
    return "$veglenkesekvensid, $relativPosisjon, $retning, $veglenkeType, $detaljniv, $typeVeg, $typeVegSosi, $startdato, $geometri, $kommune, $fylke, $vegsystemreferanse, ";
  }
}
