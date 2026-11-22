# Qur'an-Quellen für Athar: Lizenzlage (Stand 2026-11-22)

Nur Webrecherche, keine Rechtsberatung. Die Zitate sind kurz gehalten. Wo „gemeinfrei“ steht, folgt die Begründung. Unsicheres ist markiert.

## Empfehlung

| Sprache | Empfohlene Quelle | Lizenz / Bedingungen | Pflichten | Sicherheit |
|---|---|---|---|---|
| Arabisch | **Tanzil Quran Text** (Uthmani + Simple), https://tanzil.net/download/ | CC BY 3.0 mit Zusatz „CHANGING IT IS NOT ALLOWED“ ([Lizenz](https://tanzil.net/docs/text_license)) | wörtlich, keine Änderung; „Tanzil Project“ nennen und auf tanzil.net verlinken; Copyright-Hinweis in jeder Kopie bzw. Datei mitführen; Updates beachten | **hoch** |
| Englisch | **Saheeh International** über QuranEnc (`english_saheeh`, v1.1.2, „Noor International Center“) | QuranEnc-Bedingungen: „can be downloaded and re-published“ unter Auflagen ([Terms](https://quranenc.com/en/browse/english_saheeh)) | keine Änderung; Herausgeber und QuranEnc.com nennen; Versionsnummer anzeigen; Metadaten behalten; auf die neueste Version aktualisieren; keine unpassende Werbung | **mittel–hoch** |
| Englisch (gemeinfreie Alternative) | **Pickthall 1930** (Erstausgabe Knopf, London/New York) | gemeinfrei: EU (gest. 1936, life+70 → 2007); USA (1930 veröffentlicht, frei seit 1.1.2026) | keine Pflichten; den Text aber aus einem Scan der Ausgabe von 1930 nehmen, nicht aus der Tanzil-Datei (siehe unten) | **hoch** (Rechte) / **mittel** (Textherkunft) |
| Deutsch | **Bubenheim & Elyas** über QuranEnc (`german_bubenheim`, v1.1.5) | QuranEnc-Bedingungen ([Terms](https://quranenc.com/en/browse/german_bubenheim)) | wie oben | **mittel** (Rechtekette zum King Fahd Complex ist nicht dokumentiert) |
| Deutsch (gemeinfrei) | **Max Henning 1901** (Reclam Leipzig) | gemeinfrei (gest. 21.9.1927); Scan der ULB Halle mit Public Domain Mark | keine; Verse müssen von der Flügel-Zählung umgemappt werden | **hoch** (Rechte) / **niedrig** (Akzeptanz, Aufwand) |
| Türkisch | QuranEnc `turkish_shahin` (Dr. Ali Özek u. a.) oder `turkish_rwwad` | QuranEnc-Bedingungen | wie oben | **mittel** |
| Türkisch (gemeinfrei) | Elmalılı Hamdi Yazır, **nur Originaltext** | gemeinfrei in TR/EU (gest. 1942 → 2013); USA wahrscheinlich ebenfalls | eine wörtliche Originalfassung muss erst beschafft werden; vereinfachte Ausgaben sind geschützt | **niedrig–mittel** |
| Polnisch | **keine lizenzsaubere moderne Übersetzung gefunden** | Bielawski und Czachorowski sind geschützt | Erlaubnis einholen oder Polnisch vorerst weglassen | **niedrig** |

**Kurz:** Arabisch kommt von Tanzil. EN, DE und TR kommen von QuranEnc: eine Quelle mit einheitlichen, schriftlich veröffentlichten Bedingungen, SQLite-Downloads und Versionsnummern. Gemeinfreie Texte (Pickthall, Henning) eignen sich als Zusatz. Polnisch ist ungelöst.

---

## 1. Arabischer Text: Tanzil

- **Download:** https://tanzil.net/download/ (Uthmani, Simple, verschiedene Varianten; txt/xml/sql)
- **Lizenz:** https://tanzil.net/docs/text_license. Der Text steht unter „Creative Commons Attribution 3.0“. Weitere Zitate:
  - „Permission is granted to copy and distribute verbatim copies of this text, but CHANGING IT IS NOT ALLOWED.“
  - Nutzung in Websites und Apps ist erlaubt, „provided that its source (Tanzil Project) is clearly indicated, and a link is made to tanzil.net“.
  - Der Copyright-Hinweis muss in allen wörtlichen Kopien stehen und in abgeleiteten Dateien mit wesentlichen Teilen „appropriately“ wiedergegeben werden.
- **Was ist erlaubt?**
  - (a) Speichern in der eigenen DB: ja
  - (b) Bündeln in der App: ja
  - (c) Ausliefern über die öffentliche API: ja (wörtliche Weitergabe)
  - (d) Keine Klausel gegen kommerzielle Nutzung. Faktisch gilt aber ein **Änderungsverbot** („no-modification“). Darstellung, Schrift und Ayah-Aufteilung im UI sind unkritisch, Zeichen dürfen aber nicht verändert werden, auch keine Normalisierung. Suchnormalisierung nur als getrennter Index, der Originaltext bleibt unverändert.
- **Pflichten:**
  - In der App (Über/Credits) und im Web „Tanzil Project“ nennen und auf tanzil.net verlinken.
  - In der API eine Attribution in jede Antwort oder in die Metadaten legen.
  - Die Tanzil-Kopfzeilen bzw. den Copyright-Block in die gebündelte Datei übernehmen.
  - https://tanzil.net/updates/ beobachten.
- **Qualität:** Das ist der De-facto-Standard und wurde mit dem Medina-Mushaf abgeglichen. Eine Uthmani-taugliche Schrift wird gebraucht. Die Lizenz der Schrift ist getrennt zu prüfen.

## 2. quran.com / Quran Foundation API: für unseren Zweck NICHT geeignet

Quelle: https://api-docs.quran.foundation/legal/developer-terms/ (zuletzt aktualisiert am 2026-11-19).

- **Weitergabe:** „Quran Foundation Content is not sold, sublicensed, or redistributed“. Als Weitergabe gilt ausdrücklich „Offering Quran Foundation Content or raw API data to others as data“. Darunter fallen eine eigene API, ein Datensatz, ein Download sowie ein öffentliches Repo oder Paket.
- **Caching:** verboten ist, Inhalte „longer than 1 week“ zu cachen oder zu speichern.
- **Offline:** „Content Sync is the only permitted path for obtaining and maintaining an offline copy“. Es muss mindestens alle 7 Tage synchronisiert werden. Eine vorgepackte Datenbank deckt die Ausnahme ausdrücklich nicht ab.
- **Bündeln:** erlaubt sind nur Schriftdateien und Mushaf-Bilder, und nur „as an integrated part of the Application“.
- **Was ist erlaubt?** (a) dauerhaft in der eigenen DB: nein. (b) Bündeln in der App: nein, außer Schriften und Bilder. (c) öffentliche API: **ausdrücklich nein**. (d) Kommerzielle Nutzung ist erlaubt, der Qur'an-Text darf nicht verändert werden.
- Die Bedingungen weisen selbst darauf hin, dass die Rechte je Übersetzung verschieden sind: „rights holders and licensing terms vary by … translation edition“.
- **Fazit (sicher):** Diese Quelle ist mit „eigene DB plus öffentliche API“ unvereinbar.

## 3. Tanzil-Übersetzungen: nicht als Rechtsquelle nutzen

Quelle: https://tanzil.net/trans/

- Allgemeine Bedingungen:
  - „The translations provided at this page are for non-commercial purposes only.“
  - Für kommerzielle Nutzung braucht es die Erlaubnis des Übersetzers oder Verlags.
  - „Redistributing the following list in another website is not allowed“. Bei mehr als drei Übersetzungen ist ein Backlink Pflicht.
- **Keine** Übersetzung ist dort ausdrücklich zur Weitergabe freigegeben. Die Dateiköpfe (z. B. `en.pickthall`, `de.bubenheim`, `pl.bielawskiego`, `tr.yazir`) enthalten nur Name, Übersetzer, Datum und „Source: Tanzil.net“, aber keine Lizenz.
- Tanzil ist nicht Rechteinhaber der geschützten Übersetzungen. Ihre Erlaubnis für nicht-kommerzielle Nutzung überträgt deshalb keine Rechte der Übersetzer. Athar ist zwar nicht-kommerziell, eine öffentliche API ist aber Weitergabe an Dritte, die kommerziell sein können.
- Angeboten werden unter anderem:
  - EN: Pickthall, Yusuf Ali, Saheeh, Hilali-Khan, Arberry u. a.
  - DE: Abu Rida, Bubenheim & Elyas, Khoury, Zaidan
  - PL: nur Bielawski
  - TR: Diyanet İşleri, Diyanet Vakfı, Elmalılı, Ateş, Yıldırım, Öztürk u. a.

## 4. QuranEnc.com (Rowwad Translation Center / IslamHouse): beste Quelle für EN, DE, TR

- **Bedingungen** (identisch auf jeder Übersetzungsseite, z. B. https://quranenc.com/en/browse/english_saheeh). Einleitung: „Contents of the translations can be downloaded and re-published, with the following terms and conditions:“
  1. „No modification, addition, or deletion of the content.“
  2. „Clearly referring to the publisher and the source (QuranEnc.com).“
  3. „Mentioning the version number when re-publishing the translation.“
  4. „Keeping the transcript information inside the document.“
  5. „Notifying the source (QuranEnc.com) of any note on the translation.“
  6. „Updating the translation according to the latest version issued from the source.“
  7. „Inappropriate advertisements must not be included…“ (für Athar ohnehin kein Thema, die App hat keine Werbung)
- **Downloads und API:**
  - Liste aller Übersetzungen: https://quranenc.com/api/v1/translations/list
  - Je Übersetzung eine SQLite-Datei (`id, sura, aya, translation, footnotes`), z. B. https://quranenc.com/downloads/sqlite/german_bubenheim.zip
  - Außerdem CSV: https://quranenc.com/en/home/d/csv/english_saheeh
- **Was ist erlaubt?**
  - (a) Speichern in der eigenen DB: ja, „downloaded“
  - (b) Bündeln in der App: ja, „re-published“
  - (c) öffentliche API: sehr wahrscheinlich ja, „re-published“; nur die Bedingungen 1–6 müssen auch für unsere API-Nutzer gelten
  - (d) Keine Klausel gegen kommerzielle Nutzung, aber ein **Änderungsverbot**, das auch Fußnoten betrifft. Es gibt keine formale Lizenz (kein CC), nur diese Nutzungsbedingungen.
- **Technische Folgen:**
  - Die Versionsnummer muss in der App und in der API sichtbar sein.
  - Ein Update-Job ist nötig, der `last_update`/`version` aus der Liste abgleicht (Pflicht 6).
  - Fußnoten müssen mitgeführt werden oder zumindest abrufbar sein.
  - Die API-Antwort braucht ein Feld mit Attribution und Bedingungen.
- **Relevante Einträge (Stand der Liste heute):**
  - EN: `english_saheeh` v1.1.2 (Saheeh International / Noor International Center), `english_rwwad` v1.0.21, `english_hilali_khan` v1.1.3
  - DE: `german_bubenheim` v1.1.5 („‘Abdullah as-Sāmit (Frank Bubenheim) and Dr. Nadim Elias“), `german_rwwad` v1.0.16
  - TR: `turkish_rwwad` v1.0.4, `turkish_shaban` v1.1.0, `turkish_shahin` v1.0.0 („Dr. Ali Ozek and others“)
  - **PL: keine Übersetzung vorhanden.**
- **Einschränkung:** Bei Saheeh und Bubenheim liegen die Rechte ursprünglich bei Dritten: Saheeh International / Dar Abul-Qasim bzw. dem King Fahd Complex. Die Seite nennt nur „QuranEnc.com © 2026“ und belegt nicht, dass die Rechteinhaber diese Weitergabe erlaubt haben. QuranEnc ist eine etablierte saudische Stelle und die Übersetzungen werden dort offiziell herausgegeben. Das Risiko ist daher gering, aber nicht null. Siehe offene Fragen.
- **IslamHouse.com:** Eigene Nutzungsbedingungen wurden nicht gefunden, nur „© Islamhouse Website“. Für Qur'an-Übersetzungen ist QuranEnc das zuständige Portal.

## 5. Englisch: Details

| Kandidat | Rechte | Bemerkung |
|---|---|---|
| **Saheeh International** (QuranEnc) | QuranEnc-Bedingungen | Heute sehr verbreitet und respektiert, nah am Wortlaut, Standard auf quran.com |
| **Pickthall, *The Meaning of the Glorious Koran*, 1930** | **EU:** gest. 1936, frei seit 2007. **USA:** Erstveröffentlichung 1930, frei seit 1.1.2026 (95 Jahre) | Respektierter Klassiker in altertümlichem Englisch. Wikisource hat den Scan von 1930 (https://en.wikisource.org/wiki/Index:The_Meaning_of_the_Glorious_Koran_(1930).pdf), er ist aber **nur teilweise transkribiert** („To be proofread“, viele Seiten fehlen). Sacred-texts hat die **Hyderabad-Ausgabe von 1938**: sie ist in der EU frei, ihr Status in den USA wird dort selbst als zweifelhaft bezeichnet. Die Tanzil-Datei ist bequem, aber mit „non-commercial“ markiert und ihre Vorlage ist unklar. Sauberster Weg: Text aus dem Scan von 1930 nehmen und gegen Tanzil abgleichen. |
| **Yusuf Ali**, Erstausgabe 1934–38 (Lahore) | **EU:** gest. 1953, frei seit 1.1.2024. **USA: unsicher.** Möglicherweise durch den URAA wiederhergestellt und dann bis Ende 2029 bis 2033 geschützt. Laut WikiIslam nie registriert; die Quellen widersprechen sich. | **Die meisten Online-Texte stammen aus den revidierten Ausgaben** (Amana 1989, King Fahd Complex), und die sind geschützt. Projekt Gutenberg #16955 („Three Translations“, „public domain in the USA“) war nicht erreichbar (503), unklar welche Ausgabe. Nicht empfohlen. |
| Hilali-Khan, `english_rwwad` | QuranEnc | Hilali-Khan ist stark kommentierend und umstritten. Rowwad ist modern und weniger bekannt. |

## 6. Deutsch: Details

| Kandidat | Rechte | Bemerkung |
|---|---|---|
| **Bubenheim & Elyas** (QuranEnc, ursprünglich King Fahd Complex) | QuranEnc-Bedingungen | Bei deutschsprachigen Muslimen die meistgenutzte Übersetzung, inhaltlich verlässlich |
| `german_rwwad` | QuranEnc | Modern, aber weniger bekannt |
| **Max Henning 1901** (Reclam Leipzig) | Henning lebte von 1861 bis 21.9.1927 ([de.wikipedia](https://de.wikipedia.org/wiki/Max_Henning)). **EU und USA gemeinfrei.** | Scan der Ausgabe von 1901 über die Deutsche Digitale Bibliothek / ULB Sachsen-Anhalt mit Public Domain Mark 1.0 (https://opendata.uni-halle.de/handle/1981185920/99949). Der Text bei **Projekt Gutenberg ist Reclam 1970**, also möglicherweise eine bearbeitete Fassung; nicht ungeprüft übernehmen. **Geschützt** sind die Ausgabe mit Einleitung und Anmerkungen von Schimmel (1960; deren Beiträge, nicht der Henning-Text) und die Revision von Murad Hofmann (1998/99). Henning folgt der **Flügel-Verszählung**, deshalb ist ein Mapping auf die kufische Zählung (6236 Verse) nötig. Das Werk ist orientalistisch und bei Muslimen wenig verbreitet. Henning könnte zudem ein Pseudonym sein (Wikipedia: „nicht vollständig geklärt“); für die Schutzfrist ist das unkritisch, weil der vermutete Autor August Müller 1892 gestorben ist. |
| Rückert | gest. 1866, gemeinfrei | Nur Teilübersetzung, poetisch: für einen Volltext ungeeignet |
| Khoury, Zaidan, Abu Rida | geschützt | Bei Tanzil nur für nicht-kommerzielle Nutzung |

## 7. Türkisch: Details

| Kandidat | Rechte | Bemerkung |
|---|---|---|
| QuranEnc `turkish_shahin` („Dr. Ali Ozek and others“) | QuranEnc-Bedingungen | Vermutlich das Meal der Diyanet-Vakfı-Kommission (Özek, Karaman, Turgut, Çağrıcı, Dönmez, Gümüş), das gilt als respektiert. **Zuordnung prüfen.** Version 1.0.0 von 2017. |
| QuranEnc `turkish_rwwad` / `turkish_shaban` | QuranEnc | Modern, weniger bekannt in TR |
| **Diyanet İşleri Meali** | **keine offenen Bedingungen gefunden** | Bei Tanzil nur nicht-kommerziell. Diyanet verteidigt seine Rechte aktiv (Gerichtsverfahren gegen Meal-Herausgeber; „Diyanet“ ist als Name geschützt). Ohne schriftliche Erlaubnis nicht verwenden. |
| **Elmalılı Hamdi Yazır** (*Hak Dini Kur'an Dili*, 1935–38) | Lebte von 1878 bis 27.5.1942. TR life+70 → frei seit 1.1.2013; EU ebenso. USA: wahrscheinlich frei, wenn der Schutz in der Türkei 1996 schon abgelaufen war (damals life+50 → 1992); **nicht geprüft**. | Höchstes Ansehen in der Türkei. **Aber:** Fast alle digitalen Texte sind **vereinfachte Fassungen** („sadeleştirilmiş“), und daran haben die Bearbeiter eigene Rechte. Das Original ist stark osmanisch geprägt. Welche Fassung bei Tanzil (`tr.yazir`) liegt, ist unklar. Eine Ausgabe nach dem Original 1:1 abzuschreiben ist aufwendig. |
| Ömer Nasuhi Bilmen | gest. 1971, geschützt bis 2041 | Nicht gemeinfrei |

## 8. Polnisch: Details (ungelöst)

| Kandidat | Rechte | Bemerkung |
|---|---|---|
| **Józef Bielawski** (PIW 1986) | gest. 1997, geschützt bis Ende 2067 | Wissenschaftlicher Standard. Bei Tanzil nur nicht-kommerziell. Erlaubnis von PIW bzw. den Erben nötig. |
| **Musa Czachorowski** (Muzułmański Związek Religijny, Białystok 2018) | geschützt, Übersetzer lebt (geb. 1953) | Aus dem Russischen übersetzt. Herausgeber ist der Muslimische Religionsverband (MZR), laut einer Quelle von Diyanet gefördert. **Bester Kandidat für eine Anfrage beim MZR.** |
| „Buczacki“ 1858 (Warschau, 2 Bände) | eindeutig gemeinfrei | Die Urheberschaft ist umstritten (vermutlich die Wilnaer Philomaten). Archaisches Polnisch, Verszählung nach dem europäischen System. Wissenschaftlich überholt und praktisch nicht nutzbar. Digitalisate gibt es nur als Scans; eine freie Volltextfassung wurde nicht gefunden. |
| Jakub Szynkiewicz 1935 | gest. 1966, geschützt bis 2036 | **Nur eine Versauswahl** („Wersety z Koranu“), keine Vollübersetzung |

**Empfehlung PL:** Bis eine Erlaubnis vorliegt, keinen polnischen Qur'an-Text anbieten. Ahmad (nicht der Agent) könnte beim MZR (Czachorowski) und bei PIW (Bielawski) anfragen.

## 9. Weitere geprüfte Quellen

- **QUL (Quranic Universal Library, Tarteel)**, https://qul.tarteel.ai/faq: „The resources available on QUL vary in their copyright status“. Die Lizenz muss für jede Ressource einzeln geprüft werden. MIT gilt nur für den Code, nicht für die Daten. Nützlich als technische Quelle, aber kein Rechtenachweis.
- **King Fahd Complex (qurancomplex.gov.sa):** Keine offene Lizenz gefunden. Seine Übersetzungen (Bubenheim, Hilali-Khan) lassen sich praktisch nur über QuranEnc rechtlich belastbar nutzen.
- **„The Clear Quran“ (Khattab):** geschützt, keine offene Lizenz. Nicht verwenden.
- **Unter CC BY, CC BY-SA, CC0 oder GPL** wurde **für keine der fünf Sprachen** eine respektierte Vollübersetzung gefunden. Ausnahme ist der arabische Text von Tanzil (CC BY 3.0 mit Änderungsverbot).

## 10. Offene Fragen / rechtlich prüfen

1. **Rechtekette bei QuranEnc:** Hat QuranEnc für Saheeh (Noor International / Dar Abul-Qasim) und Bubenheim (King Fahd Complex) das Recht, die Weitergabe zu erlauben, auch über die öffentliche API eines Dritten? Es lohnt sich, sich das von QuranEnc schriftlich bestätigen zu lassen. Das ist eine Entscheidung für Ahmad; der Agent hat niemanden kontaktiert.
2. **„re-published“ und die öffentliche API:** Am sichersten ist es, die Bedingungen 1–6 in die API-Bedingungen von Athar zu übernehmen, also Weitergabe nur wörtlich, mit Version und Quellenangabe.
3. **Updatepflicht (QuranEnc Nr. 6):** Gilt sie auch für App-Versionen, die schon ausgeliefert sind? Praktisch heißt das: regelmäßig synchronisieren und die neue Version mit dem nächsten Release ausliefern. Die App selbst darf dafür keine Daten senden (Zusage „Data Not Collected“), also nur mit dem Release aktualisieren.
4. **Tanzil-Änderungsverbot und CC BY 3.0:** Das ist ein Widerspruch in der Lizenz selbst, praktisch also ein ND-artiges Verbot. Nichts normalisieren, Ausnahme nur ein getrennter Suchindex.
5. **Pickthall:** Kann man die Tanzil-Datei als Vorlage nutzen? Der Text selbst ist gemeinfrei. Die NC-Markierung von Tanzil ist eher eine Nutzungsbedingung als ein Urheberrecht; ein EU-Datenbankrecht ist für einen iranischen Betreiber unwahrscheinlich. Sauberer bleibt trotzdem ein eigener Abgleich mit dem Scan von 1930.
6. **Yusuf Ali in den USA** (URAA-Wiederherstellung) und die Frage, welche Ausgabe online kursiert: offen. Deshalb nicht verwenden.
7. **Elmalılı:** Den genauen Status in den USA prüfen und eine Originalausgabe ohne Bearbeiterrechte finden. Klären, ob Diyanet als Auftraggeber (1925 TBMM/Diyanet) Rechte beansprucht.
8. **`turkish_shahin`:** Klären, ob das wirklich das Diyanet-Vakfı-Meal ist und ob QuranEnc dafür eine Lizenz von TDV hat.
9. **Polnisch:** Es gibt keine lizenzsaubere Option. Eine Erlaubnis ist nötig (MZR/Czachorowski, PIW/Bielawski).
10. **Schriften** für Uthmani (z. B. KFGQPC Hafs, Amiri Quran unter OFL) separat prüfen; dieser Bericht deckt sie nicht ab.

### Quellen
- Tanzil-Textlizenz: https://tanzil.net/docs/text_license · Download: https://tanzil.net/download/ · Übersetzungen: https://tanzil.net/trans/
- Developer Terms der Quran Foundation: https://api-docs.quran.foundation/legal/developer-terms/
- QuranEnc-Bedingungen: https://quranenc.com/en/browse/english_saheeh · https://quranenc.com/en/browse/german_bubenheim · API: https://quranenc.com/api/v1/translations/list
- QUL-FAQ: https://qul.tarteel.ai/faq
- Pickthall 1930 auf Wikisource: https://en.wikisource.org/wiki/Index:The_Meaning_of_the_Glorious_Koran_(1930).pdf · Wikipedia: https://en.wikipedia.org/wiki/The_Meaning_of_the_Glorious_Koran
- Henning: https://de.wikipedia.org/wiki/Max_Henning · Scan von 1901: https://opendata.uni-halle.de/handle/1981185920/99949
- Yusuf Ali: https://en.wikipedia.org/wiki/The_Holy_Qur%27an:_Text,_Translation_and_Commentary
- Elmalılı: https://en.wikipedia.org/wiki/Muhammed_Hamdi_Yaz%C4%B1r
- Czachorowski: https://gloqur.de/quran-translation-of-the-week-15-translation-into-polish-by-musa-czachorowski/
- Buczacki 1858: https://repozytorium.amu.edu.pl/handle/10593/12583
