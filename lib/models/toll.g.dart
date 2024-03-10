// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Toll _$TollFromJson(Map<String, dynamic> json) => Toll(
      vegobjekt: json['vegobjekt'] == null
          ? null
          : Vegobjekt.fromJson(json['vegobjekt'] as Map<String, dynamic>),
    );

Vegobjekt _$VegobjektFromJson(Map<String, dynamic> json) => Vegobjekt(
      id: json['id'] as String?,
      href: json['href'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      egenskaper: json['egenskaper'] == null
          ? null
          : Egenskaper.fromJson(json['egenskaper'] as Map<String, dynamic>),
      geometri: json['geometri'] == null
          ? null
          : VegobjektGeometri.fromJson(
              json['geometri'] as Map<String, dynamic>),
      lokasjon: json['lokasjon'] == null
          ? null
          : Lokasjon.fromJson(json['lokasjon'] as Map<String, dynamic>),
      vegsegmenter: json['vegsegmenter'] == null
          ? null
          : Vegsegmenter.fromJson(json['vegsegmenter'] as Map<String, dynamic>),
      relasjoner: json['relasjoner'] == null
          ? null
          : Relasjoner.fromJson(json['relasjoner'] as Map<String, dynamic>),
    );

Egenskaper _$EgenskaperFromJson(Map<String, dynamic> json) => Egenskaper(
      egenskap: (json['egenskap'] as List<dynamic>?)
          ?.map((e) => EgenskapElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

EgenskapElement _$EgenskapElementFromJson(Map<String, dynamic> json) =>
    EgenskapElement(
      id: json['id'] as String?,
      navn: json['navn'] as String?,
      egenskapstype: json['egenskapstype'] as String?,
      datatype: json['datatype'] as String?,
      stedfestingstype: json['stedfestingstype'] as String?,
      veglenkesekvensid: json['veglenkesekvensid'] as String?,
      relativPosisjon: json['relativPosisjon'] as String?,
      retning: json['retning'] as String?,
      kjrefelt: json['kjørefelt'] == null
          ? null
          : Kjrefelt.fromJson(json['kjørefelt'] as Map<String, dynamic>),
      innhold: json['innhold'] == null
          ? null
          : Innhold.fromJson(json['innhold'] as Map<String, dynamic>),
      verdi: json['verdi'] as String?,
      enumId: json['enum_id'] as String?,
      enhet: json['enhet'] == null
          ? null
          : Enhet.fromJson(json['enhet'] as Map<String, dynamic>),
    );

Enhet _$EnhetFromJson(Map<String, dynamic> json) => Enhet(
      id: json['id'] as String?,
      navn: json['navn'] as String?,
      kortnavn: json['kortnavn'] as String?,
    );

Innhold _$InnholdFromJson(Map<String, dynamic> json) => Innhold(
      egenskap: json['egenskap'] == null
          ? null
          : InnholdEgenskap.fromJson(json['egenskap'] as Map<String, dynamic>),
    );

InnholdEgenskap _$InnholdEgenskapFromJson(Map<String, dynamic> json) =>
    InnholdEgenskap(
      id: json['id'] as String?,
      navn: json['navn'] as String?,
      egenskapstype: json['egenskapstype'] as String?,
      datatype: json['datatype'] as String?,
      verdi: json['verdi'] as String?,
    );

Kjrefelt _$KjrefeltFromJson(Map<String, dynamic> json) => Kjrefelt(
      felt: (json['felt'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

VegobjektGeometri _$VegobjektGeometriFromJson(Map<String, dynamic> json) =>
    VegobjektGeometri(
      wkt: json['wkt'] as String?,
      srid: json['srid'] as String?,
      egengeometri: json['egengeometri'] as String?,
    );

Lokasjon _$LokasjonFromJson(Map<String, dynamic> json) => Lokasjon(
      kommuner: json['kommuner'] == null
          ? null
          : Kommuner.fromJson(json['kommuner'] as Map<String, dynamic>),
      fylker: json['fylker'] == null
          ? null
          : Fylker.fromJson(json['fylker'] as Map<String, dynamic>),
      kontraktsomrder: json['kontraktsområder'] == null
          ? null
          : Kontraktsomrder.fromJson(
              json['kontraktsområder'] as Map<String, dynamic>),
      gater: json['gater'] == null
          ? null
          : LokasjonGater.fromJson(json['gater'] as Map<String, dynamic>),
      vegsystemreferanser: json['vegsystemreferanser'] == null
          ? null
          : Vegsystemreferanser.fromJson(
              json['vegsystemreferanser'] as Map<String, dynamic>),
      stedfestinger: json['stedfestinger'] == null
          ? null
          : Stedfestinger.fromJson(
              json['stedfestinger'] as Map<String, dynamic>),
      geometri: json['geometri'] == null
          ? null
          : LokasjonGeometri.fromJson(json['geometri'] as Map<String, dynamic>),
    );

Fylker _$FylkerFromJson(Map<String, dynamic> json) => Fylker(
      fylke: json['fylke'] as String?,
    );

LokasjonGater _$LokasjonGaterFromJson(Map<String, dynamic> json) =>
    LokasjonGater(
      gater: json['gater'] == null
          ? null
          : GaterGater.fromJson(json['gater'] as Map<String, dynamic>),
    );

GaterGater _$GaterGaterFromJson(Map<String, dynamic> json) => GaterGater(
      gatekode: json['gatekode'] as String?,
      navn: json['navn'] as String?,
    );

LokasjonGeometri _$LokasjonGeometriFromJson(Map<String, dynamic> json) =>
    LokasjonGeometri(
      wkt: json['wkt'] as String?,
      srid: json['srid'] as String?,
    );

Kommuner _$KommunerFromJson(Map<String, dynamic> json) => Kommuner(
      kommune: json['kommune'] as String?,
    );

Kontraktsomrder _$KontraktsomrderFromJson(Map<String, dynamic> json) =>
    Kontraktsomrder(
      kontraktsomrde: (json['kontraktsområde'] as List<dynamic>?)
          ?.map((e) => Kontraktsomrde.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Kontraktsomrde _$KontraktsomrdeFromJson(Map<String, dynamic> json) =>
    Kontraktsomrde(
      id: json['id'] as String?,
      nummer: json['nummer'] as String?,
      navn: json['navn'] as String?,
    );

Stedfestinger _$StedfestingerFromJson(Map<String, dynamic> json) =>
    Stedfestinger(
      stedfesting: json['stedfesting'] == null
          ? null
          : Stedfesting.fromJson(json['stedfesting'] as Map<String, dynamic>),
    );

Stedfesting _$StedfestingFromJson(Map<String, dynamic> json) => Stedfesting(
      type: json['type'] as String?,
      veglenkesekvensid: json['veglenkesekvensid'] as String?,
      relativPosisjon: json['relativPosisjon'] as String?,
      kortform: json['kortform'] as String?,
      retning: json['retning'] as String?,
      kjrefelt: json['kjørefelt'] == null
          ? null
          : Kjrefelt.fromJson(json['kjørefelt'] as Map<String, dynamic>),
    );

Vegsystemreferanser _$VegsystemreferanserFromJson(Map<String, dynamic> json) =>
    Vegsystemreferanser(
      vegsystemreferanse: json['vegsystemreferanse'] == null
          ? null
          : Vegsystemreferanse.fromJson(
              json['vegsystemreferanse'] as Map<String, dynamic>),
    );

Vegsystemreferanse _$VegsystemreferanseFromJson(Map<String, dynamic> json) =>
    Vegsystemreferanse(
      vegsystem: json['vegsystem'] == null
          ? null
          : Vegsystem.fromJson(json['vegsystem'] as Map<String, dynamic>),
      strekning: json['strekning'] == null
          ? null
          : Strekning.fromJson(json['strekning'] as Map<String, dynamic>),
      kortform: json['kortform'] as String?,
    );

Strekning _$StrekningFromJson(Map<String, dynamic> json) => Strekning(
      id: json['id'] as String?,
      versjon: json['versjon'] as String?,
      strekning: json['strekning'] as String?,
      delstrekning: json['delstrekning'] as String?,
      arm: json['arm'] as String?,
      adskilteLp: json['adskilte_løp'] as String?,
      trafikantgruppe: json['trafikantgruppe'] as String?,
      meter: json['meter'] as String?,
      retning: json['retning'] as String?,
    );

Vegsystem _$VegsystemFromJson(Map<String, dynamic> json) => Vegsystem(
      id: json['id'] as String?,
      versjon: json['versjon'] as String?,
      vegkategori: json['vegkategori'] as String?,
      fase: json['fase'] as String?,
      nummer: json['nummer'] as String?,
    );

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      versjon: json['versjon'] as String?,
      sistModifisert: json['sist_modifisert'] == null
          ? null
          : DateTime.parse(json['sist_modifisert'] as String),
      startdato: json['startdato'] == null
          ? null
          : DateTime.parse(json['startdato'] as String),
    );

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: json['id'] as String?,
      navn: json['navn'] as String?,
    );

Relasjoner _$RelasjonerFromJson(Map<String, dynamic> json) => Relasjoner(
      barn: json['barn'] == null
          ? null
          : RelasjonerBarn.fromJson(json['barn'] as Map<String, dynamic>),
    );

RelasjonerBarn _$RelasjonerBarnFromJson(Map<String, dynamic> json) =>
    RelasjonerBarn(
      barn: json['barn'] == null
          ? null
          : BarnBarn.fromJson(json['barn'] as Map<String, dynamic>),
    );

BarnBarn _$BarnBarnFromJson(Map<String, dynamic> json) => BarnBarn(
      listeid: json['listeid'] as String?,
      id: json['id'] as String?,
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      vegobjekter: json['vegobjekter'] == null
          ? null
          : Vegobjekter.fromJson(json['vegobjekter'] as Map<String, dynamic>),
    );

Vegobjekter _$VegobjekterFromJson(Map<String, dynamic> json) => Vegobjekter(
      id: json['id'] as String?,
    );

Vegsegmenter _$VegsegmenterFromJson(Map<String, dynamic> json) => Vegsegmenter(
      segment: json['segment'] == null
          ? null
          : Segment.fromJson(json['segment'] as Map<String, dynamic>),
    );

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
      veglenkesekvensid: json['veglenkesekvensid'] as String?,
      relativPosisjon: json['relativPosisjon'] as String?,
      retning: json['retning'] as String?,
      veglenkeType: json['veglenkeType'] as String?,
      detaljniv: json['detaljnivå'] as String?,
      typeVeg: json['typeVeg'] as String?,
      typeVegSosi: json['typeVeg_sosi'] as String?,
      startdato: json['startdato'] == null
          ? null
          : DateTime.parse(json['startdato'] as String),
      geometri: json['geometri'] == null
          ? null
          : LokasjonGeometri.fromJson(json['geometri'] as Map<String, dynamic>),
      kommune: json['kommune'] as String?,
      fylke: json['fylke'] as String?,
      vegsystemreferanse: json['vegsystemreferanse'] == null
          ? null
          : Vegsystemreferanse.fromJson(
              json['vegsystemreferanse'] as Map<String, dynamic>),
    );
