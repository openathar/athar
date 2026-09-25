# Athar — an observatory in a browser tab

*(English follow-up to the Arabic launch post from last week. Register:
tech/build, English academic-ish, "we" voice. German version:
`site-article-de.md` in this folder.)*

---

## 1. A week ago

Last week I wrote, in Arabic, why I build Athar: code that outlives its
authors. A Sadaqah Jariyah — a gift that keeps paying after the giver is
gone.

This week the idea grew its body. Prayer times, Qibla, the Hijri date — in
German, English, Arabic. And one page that does something I haven't seen
anywhere else. So today is about the what.

## 2. The moon is not painted

Open the observatory and you find the Earth turning, day side and night
side, cities lit. Beside it the Moon, orbiting on a tilted plane, lit by
one shared sun.

Not an image. A geometry.

The phase you see is computed from the moon's true elongation to the sun,
tonight, from where you stand. Its age in days. Illumination in percent.
The next new moon, the next full moon — numbers the sky has to agree
with, because they come from the same arrangement the sky is in.

Prayer times are written by the sun. The months are written by the moon.
Two lights, one clock. I wanted a page that doesn't just tell you the
time — it shows you the clock.

## 3. Prayer times that never phone home

Most apps work like this: your location goes up, an answer comes down.

Athar computes in the browser. The algorithm runs as TypeScript — a port
of athan-core, my own Java library, the same code that sits on Maven
Central. The reference suite travels with it: every test value from the
Java core holds in the port, so the two implementations cannot drift
apart.

Your location never leaves your device. There is no server to send it to.

## 4. Two books

Below the observatory, one verse each day — the written book. Next to it,
an observation of the actual sky — the visible book. Click, and the next
sign appears. No feed below it. Nothing scrolls further.

The page ends where the sky begins.

## 5. The covenant, unchanged

No ads. No tracking. No trade in data. A public API (api.openathar.org)
for any developer who would rather build than start from zero. The source
opens at MVP.

Last week I wrote that the promise comes before growth. This week the
first proof shipped: privacy you can verify in the network tab.

## Conclusion

Tonight, if your sky is clear: open the moon view, read its age and its
illumination. Then step outside and look up.

If the numbers match, you know why I built this.

---

## Posting notes (not part of the post)

- **Link in the first comment**, not the body — in-body links reduce feed reach.
- Pinned first comment (draft): `openathar.org — and for developers: api.openathar.org (REST, rate-limited, no key needed yet).`
- **Timing:** Tue–Thu, 08:00–10:00 CET or 14:00–16:00 CET (US overlap). Not Friday afternoon.
- **Never edit after 10 minutes** (algorithm reset). Answer the first 5 comments within 2 hours.
- Hashtags: 3, consistent with the launch post: `#openathar #OpenSource #SadaqahJariyah`
- Optional micro-task before posting: add `id="cosmos"` to the observatory
  section, then pin `openathar.org/#cosmos` — the link scrolls straight to
  the moon, which is the post's deed. (Anchors today: only `#main`, `#athar`.)

#openathar #OpenSource #SadaqahJariyah
