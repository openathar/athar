# Athar — LinkedIn-Posts zu den Blogartikeln (Nov. 2026)

**Stand:** Entwurf v1 (2026-11-17), wartet auf Ahmads Freigabe.
**Kanal:** Ahmads Profil (wie die bisherigen Athar-Posts), Link zum Artikel im ersten Kommentar.
**Termine:** Fr 20.11. (Artikel 1) · Mo 23.11. (Artikel 2, AR) · Do 26.11. (Artikel 3), jeweils 08:00 Berlin.
Die Artikel erscheinen auf openathar.org ab 17./19./21.11. (Datumssteuerung in `web/lib/blog.ts`).
**Regeln:** nur Aussagen aus den Artikeln (im Code geprüft), keine Nutzerzahlen, max. 3 Hashtags.

---

## Post 1 · Fr 20.11. (EN)

```text
Most prayer-time apps send your location to a server five times a day.

Athar does not. The calculation runs in your browser: prayer times, Qibla, the Hijri date, tonight's moon. Your coordinates are used on your device and stay there.

That was not hard to build. Prayer times are astronomy, a few hundred lines of careful mathematics. The hard part is making sure the local result is correct, and that is the next article.

No cookies, no analytics, no ads. Built as a Sadaqah Jariyah.

#OpenSource #SadaqahJariyah #Privacy
```
**Erster Kommentar:** `https://openathar.org/en/blog/prayer-times-on-your-device`

---

## Post 2 · Mo 23.11. (AR)

```text
حين يوجد الحساب نفسه في مكانين، سيخالف نفسه يومًا ما.

في أثر، حساب مواقيت الصلاة موجود في مكتبة واحدة مكتوبة بلغة Java ومنشورة على Maven Central. والموقع يستخدم نسخة منها بلغة TypeScript.

والنسخة لا تُصدَّق على كلامها: القيم المرجعية من اختبارات Java تُفحص عليها في كل عملية بناء. وإذا اختلفت النتيجتان، لا يصل شيء إلى الموقع.

المكتبتان مفتوحتا المصدر، لمن يبني شاشة لمسجد أو تطبيقًا خاصًا به.

#أثر #OpenSource #SadaqahJariyah
```
**Erster Kommentar:** `https://openathar.org/ar/blog/one-core-two-languages`

---

## Post 3 · Do 26.11. (EN)

```text
Every developer who builds for Muslims solves the same problems: prayer times, the Hijri date, the Qibla.

The Athar API is meant to be the boring alternative. Free, documented, no sign-up. Prayer times for a day, a range or many places, an iCalendar feed, Qibla, Hijri, moon phase, place search. Same open-source core as the website.

Fair use is counted per IP. Need more? Create a key yourself: a random value and a label. No name, no e-mail.

What is missing: Qur'an and adhkar content. We want a clearly licensed text source first, and would rather wait than guess.

#OpenSource #API #SadaqahJariyah
```
**Erster Kommentar:** `https://openathar.org/en/blog/a-free-public-api`
