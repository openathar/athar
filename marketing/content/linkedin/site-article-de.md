# Athar — die Seite ist da

*(LinkedIn-Folge-Artikel, ca. 1 Woche nach dem arabischen Launch-Post.
Register: Tech/Build, Deutsch. EN/AR-Fassung bei Bedarf adaptieren.
Ordner: `business/athar/marketing/content/linkedin/`.)*

---

## 1. Was letzte Woche begann

Vor einer Woche habe ich auf Arabisch geschrieben, warum ich Athar baue: Code, der seinen Autor überlebt. Ein Geschenk, das weiterwirkt, wenn der Autor längst weg ist — eine Sadaqah Jariyah.

Heute geht es um das Was. Die Seite steht: Gebetszeiten, Qibla, Hidschri-Datum, dreisprachig (Deutsch, Englisch, Arabisch). Und sie rechnet an einigen Stellen anders, als man es von Apps gewohnt ist.

## 2. Gebetszeiten, die im Browser rechnen

Die meisten Islam-Apps holen ihre Zeiten von einem Server: Standort raus, Antwort rein.

Athar rechnet lokal. Der Algorithmus läuft als TypeScript direkt im Browser — ein Port meines eigenen Java-Kerns (athan-core), derselbe Code, der auf Maven Central liegt. Mein Experience-Wert aus dem Portieren: Wenn die Referenzwerte stimmen, ist der Rest Disziplin. 200 Testfälle gegen die Java-Implementierung gesichert, dann stimmen die Zeiten auf beide Seiten.

Dein Standort verlässt dein Gerät nicht.

## 3. Zwei Lichter, eine Uhr

Auf der Seite gibt es ein Observatorium: Erde und Mond, Tag- und Nachtseite, Zoom, drehbare Kugel. Der Mond läuft dort auf seiner Bahn, mit der echten Elongation zur Sonne, in einem geneigten Orbit.

Das heißt: Die Mondphase ist nicht gemalt. Sie entsteht aus Geometrie, jeden Tag neu. Mondalter, Beleuchtungsgrad, nächster Neu- und Vollmond — alles wird aus der Stellung der beiden Lichter berechnet, nicht aus einer Tabelle.

Die Gebetszeiten schreibt die Sonne. Die Monate schreibt der Mond. Zwei Lichter, eine Uhr — älter als jede Rechnung von uns.

## 4. Zwei Bücher

Unter dem Observatorium steht täglich ein Vers, daneben eine Beobachtung vom Himmel über dir. Das geschriebene Buch und das sichtbare Buch. Wer weiterklickt, bekommt das nächste Zeichen.

Mehr nicht. Kein Feed, der unten weiterläuft. Es ist eine Einladung zum Schauen.

## 5. Was weiterhin gilt

Keine Werbung. Kein Tracking. Keine Daten, die verkauft werden. Kostenlos, dauerhaft.

Und weil ich weiß, wie das klingt: Diesmal ist der Beweis die Architektur selbst. Die Berechnung passiert auf deinem Gerät. Eine öffentliche API (api.openathar.org) für jeden Entwickler, der darauf aufbauen will. Der Quellcode öffnet zum MVP-Launch.

## Fazit

Heute Abend, wenn der Himmel frei ist: Öffne die Mondansicht, lies Alter und Beleuchtung — und vergleich danach mit dem echten Mond über dir.

Wenn die Zahlen übereinstimmen, weißt du, warum ich das gebaut habe.

---

## Posting notes (nicht Teil des Posts)

- **Link in den ersten Kommentar** (openathar.org), nicht in den Body — sonst Reach-Verlust.
- **Timing:** Di–Do, 08:00–10:00 CET (DE-Netzwerk) oder 14:00–16:00 (US-Overlap).
- **Nach 10 Minuten nicht mehr editieren** (Algorithmus-Reset).
- **Erste 5 Kommentare in 2 Stunden beantworten.**
- Gepinnten Kommentar mit Link + API-Hinweis (api.openathar.org) auf Dev-Audience vorbereiten.
- Hashtags: 3, konsistent zum Launch-Post.

#openathar #OpenSource #SadaqahJariyah
