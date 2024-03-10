import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class SharedController extends GetxController {
  List<String> points = [
    " Norge har over 1 000 fjorder for fantastiske kjøreturer.",
    " Å kjøre på Atlanterhavsveien gir en spennende opplevelse.",
    " Norges Trollstigen har 11 hårnålssvinger og fantastisk utsikt.",
    " Kystveien E39 kobler sammen over 1 000 broer og 25 fergeoverfarter.",
    " Norges Stalheimskleiva er Europas bratteste vei, en utfordring for sjåfører.",
    " Besøk Norges berømte Geirangerfjorden, et UNESCO-verdensarvsted.",
    " Norges naturskjønne veier tilbyr enestående skjønnhet og eventyr.",
    " Kjør til Lofoten-øyene for pittoreske fiskevær og dramatiske landskap.",
    " Opplev nordlyset i Norges arktiske region.",
    " Norges berømte Atlanterhavsveien er et must for adrenalinsøkere.",
    " Besøk ikoniske Bryggen i Bergen, et UNESCO-verdensarvsted.",
    " Kjøring gjennom Hardangervidda nasjonalpark er en naturelskers drøm.",
    " Utforsk Norges fantastiske Nasjonale Turistveger.",
    " Kjør langs den berømte Sognefjellvegen for fantastisk utsikt.",
    " Norges bilferier gir muligheter til å møte reinsdyr og annet dyreliv.",
    " Kjør til Flåm for å oppleve den fantastiske Flåmsbana-jernbanen.",
    " Norges naturskjønne veier gir rikelig med muligheter for fotturer og friluftsaktiviteter.",
    " Ta en biltur til den pittoreske landsbyen Reine på Lofoten-øyene.",
    " Norges Trolltunga byr på en utfordrende fottur med belønning i form av fantastisk utsikt.",
    " Kjør til Tromsø for å oppleve midnattssolen.",
    " Besøk den sjarmerende byen Ålesund, kjent for sin jugendstilarkitektur.",
    " Norges ikoniske Preikestolen gir fantastisk utsikt over Lysefjorden.",
    " Bilturer i Norge gir muligheter for fiske- og kajakkeventyr.",
    " Kjør gjennom den vakre Rondane nasjonalpark for å oppleve Norges villmark.",
    " Norske veier er godt vedlikeholdt og gir en behagelig kjøreopplevelse.",
  ];

  var randomPoint = "".obs;
  Timer? t;

  getText() {
    randomPoint.value = points[Random().nextInt(points.length)];
    update();
    if (t != null) {
      t!.cancel();
    }
    timeIntervalForRandomText();
  }

  timeIntervalForRandomText() {
    t = Timer(const Duration(seconds: 4), () {
      getText();
    });
    // if (t != null) {
    //   t!.cancel();
    // }
  }
}
