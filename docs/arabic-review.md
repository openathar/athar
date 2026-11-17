# Arabisch — Proofread-Paket (Stand 2026-11-17)

Alle arabischen Texte, die ohne muttersprachliche Prüfung geschrieben wurden. Quelle jeweils angegeben.

**Gelesen und freigegeben von Ahmad Al Zoubi am 2026-11-17** (Abschnitte 1–4, unverändert).

**Nicht in diesem Paket (weiterhin ungeprüft):** die 18 arabischen Beobachtungstexte des Seeds
(`web/data/reflections.json`, `arabicApproved: false`) und das ältere App-Wörterbuch
(`mobile/src/lib/i18n.ts`, Block `ar`, ausser den hier gelisteten Schlüsseln).

## 1. Webseite: neue Beschriftungen

| Arabisch | Bedeutung |
|---|---|
| دعاء اليوم | Du'a des Tages (Überschrift) |
| اسم اليوم | Name des Tages (Überschrift) |
| من ٩٩ | … von 99 |
| قمرك | Dein Mond (Überschrift) |
| التاريخ الهجري | Hijri-Datum |
| مضاء | beleuchtet |
| مشاركة | Teilen (Knopf) |
| الخصوصية | Datenschutz (Footer-Link) |
| اختر تاريخًا — يوم ميلادك أو أي يوم يهمّك. | Hinweis unter "Dein Mond" |

## 2. Datenschutzseite (`web/lib/privacy-copy.ts`)

**الخصوصية** — آخر تحديث: ١٦ نوفمبر ٢٠٢٦

«أثر» مبنيّ صدقةً جارية: مجاني، بلا إعلانات، بلا حسابات، وبلا تتبّع. توضّح هذه الصفحة بالضبط ما يعنيه ذلك عمليًا — للموقع والتطبيق وواجهة البرمجة العامة.

### باختصار

لا نشغّل إعلانات ولا أدوات تحليل ولا تتبّع. لا توجد حسابات ولا تسجيل. تُحسب مواقيت الصلاة والقبلة والتقويم الهجري والقمر على جهازك أنت. موقعك لا يُرسَل إلينا أبدًا.

### الموقع (openathar.org)

لا ملفات تعريف ارتباط، ولا تحليلات، ولا إعلانات، ولا أدوات تواصل اجتماعي، ولا سكربتات من أطراف ثالثة. تُقدَّم الخطوط والصور من خادمنا نحن — متصفحك لا يتصل بغوغل ولا بأي خدمة خطوط أو صور أخرى.

يُحفظ اختيارك للوضع الفاتح أو الداكن في متصفحك (التخزين المحلي، المفتاح «athar-theme»). يبقى على جهازك ولا يُرسَل إلينا.

إذا سمحتَ لمتصفحك بمشاركة موقعك (للعدّاد التنازلي أو «استخدم موقعي») فيُستخدم داخل المتصفح لحساب المواقيت فقط، ولا يُنقل.

يجلب خادمنا آيات القرآن من quran.com؛ متصفحك لا يتصل بـ quran.com. يُرسَل رقم الآية فقط. الروابط إلى quran.com وGitHub ومواقع أخرى تخرج من هذا الموقع، وتسري هناك سياسات خصوصيتها.

### تطبيق الجوال

تجري كل الحسابات على هاتفك. موقعك يبقى على الهاتف. تنبيهات الأذان إشعارات محلية — بلا خدمة دفع وبلا حساب.

الشيء الوحيد الذي يرسله التطبيق عبر الشبكة هو النص الذي تكتبه في بحث المدن، إلى api.openathar.org، للعثور على مكان. ولا يرسل إحداثياتك. لا يحتوي التطبيق على أي مكوّن للتحليل أو تقارير الأعطال أو الإعلانات.

إعداداتك (طريقة الحساب، اللغة، المظهر، مفاتيح التنبيه، آخر المدن) تُحفظ على جهازك فقط.

الأذونات: الموقع أثناء استخدام التطبيق (لحساب المواقيت لمكانك؛ ويمكنك اختيار مدينة بدلًا منه)، والإشعارات (لتنبيهات الأذان)، وعلى أندرويد المنبّهات الدقيقة (ليرنّ التنبيه في الدقيقة المضبوطة).

### واجهة البرمجة العامة (api.openathar.org)

ما ترسله (إحداثيات، تواريخ، نص بحث) يُستخدم للردّ على طلبك. لا نبني منه ملفات تعريفية للمستخدمين.

لفرض حدّ الطلبات نعدّ الطلبات لكل عنوان IP — أو لكل مفتاح API إن أرسلتَ مفتاحًا — ضمن نافذة مدتها دقيقة في مخزن مؤقت.

مفتاح API هو قيمة عشوائية مع وسم اختياري تختاره (حتى ٦٤ حرفًا) ووقت الإنشاء وعدّاد للطلبات. لا اسم ولا بريد إلكتروني. تبقى المفاتيح محفوظة حتى تطلب حذفها.

### السجلات التقنية

كأي خدمة ويب، تعالج Cloudflare — الموضوعة أمام الموقع والواجهة — بيانات تقنية مثل عنوان IP والعنوان المطلوب والوقت، من أجل تقديم الصفحات والحماية من إساءة الاستخدام.

يحتفظ خادمنا بسجلّ وصول: الوقت والعنوان المطلوب بمعاملاته (مثل المدينة التي بحثتَ عنها) وحالة الردّ. لا يتضمن عنوان IP الخاص بك لأن الطلبات تصل إلى خادمنا عبر Cloudflare. تُحذف هذه السجلات بعد ٣٠ يومًا. نستخدمها فقط لتشغيل الخدمة وتأمينها — لا للتحليل ولا للإعلان ولا لبناء ملفات تعريفية.

### حقوقك والتواصل

يحق لك أن تسأل عمّا نحتفظ به عنك، وأن تطلب تصحيحه أو حذفه (مثل مفتاح API أنشأتَه)، وأن تشتكي إلى سلطة حماية البيانات. وبما أننا لا نحتفظ بحسابات فغالبًا لا يوجد شيء مرتبط بك — لكن اسأل وسنتحقق.

المسؤول: أحمد الزعبي (مشروع openathar). للتواصل: افتح بلاغًا (issue) على github.com/openathar.

## 3. App (`mobile/src/lib/i18n.ts`, Block `ar`)

| Schlüssel | Text |
|---|---|
| `alarmsExplainTitle` | تنبيهات الأذان |
| `alarmsExplainBody` | يضبط «أثر» التنبيهات على هاتفك نفسه — بلا خادم ولا حساب ولا رسائل دفع. ولكي يرنّ في الدقيقة المضبوطة يحتاج إلى إذنك بإرسال الإشعارات. اسمح به في النافذة التالية. |
| `alarmsExplainContinue` | متابعة |
| `alarmsExplainLater` | ليس الآن |
| `reliabilityTitle` | حافظ على دقّة التنبيهات |
| `reliabilityBody` | بعض الهواتف توقف التطبيقات في الخلفية فتتأخر التنبيهات. افتح إعدادات التطبيق واسمح لأثر بالعمل دون قيود البطارية؛ ومنذ أندرويد ١٢ اسمح أيضًا بـ «المنبّهات والتذكيرات». |
| `openSettings` | فتح إعدادات التطبيق |
| `qiblaCalibrate` | الإبرة تقفز؟ حرّك هاتفك على شكل رقم ٨ عدة مرات وأبعده عن المعادن والمغانط. |
| `notificationsOff` | الإشعارات متوقفة — فعّلها من إعدادات النظام لتصلك تنبيهات الأذان. |

## 4. Store-Eintrag (`mobile/docs/store-listing.md`)

- **App-Name:** أثر: مواقيت الصلاة والقبلة
- **Untertitel:** مجاني. بلا إعلانات.
- **Keywords:** صلاة,أذان,قبلة,هجري,قمر,رمضان,مسلم,دعاء,مواقيت,اتجاه القبلة,تقويم
- **Werbetext:** مواقيت وقبلة تعمل بلا إنترنت. بلا إعلانات ولا حسابات ولا تتبّع — مفتوح المصدر.
- **Play-Kurzbeschreibung:** مواقيت الصلاة والقبلة والأذان. مجاني بلا إعلانات ولا تتبّع ويعمل دون إنترنت.

**Ausführliche Beschreibung:**

«أثر» هو الأثر الذي تتركه. تطبيق مواقيت صلاة مبنيّ صدقةً جارية: مجاني دائمًا، بلا إعلانات، بلا حسابات، وبلا تتبّع. مفتوح المصدر.

ماذا ستجد
• مواقيت الصلاة لمكانك، تُحسب على هاتفك — دون حاجة إلى إنترنت.
• تنبيهات الأذان لكل صلاة، تُضبط محليًا على جهازك. بلا خدمة دفع وبلا خادم وسيط.
• بوصلة القبلة مع تصحيح الشمال الحقيقي.
• التاريخ الهجري والمناسبات الإسلامية القادمة.
• القمر الحقيقي الليلة: طوره وعمره وموعد المحاق والبدر القادمين.
• دعاء لكل وقت من اليوم، منقول من كتب الحديث مع مصدره.
• اختيار طريقة الحساب (رابطة العالم الإسلامي، ISNA، مصر، أم القرى، كراتشي، طهران).
• العربية، English، Deutsch، Polski، Türkçe — مع دعم كامل للكتابة من اليمين إلى اليسار.

خصوصيتك
يبقى موقعك على هاتفك. الشيء الوحيد الذي يرسله التطبيق هو اسم المدينة الذي تكتبه في البحث. لا تحليلات ولا إعلانات ولا حسابات.

مفتوح المصدر
يُبنى «أثر» علنًا برخصة MIT. يشترك التطبيق في محرّك الحساب مع الموقع وواجهة برمجة عامة — انظر openathar.org.

ملاحظة: كُتبت معاني الأدعية لأجل «أثر» وما زالت قيد المراجعة. المواقيت حسابات؛ أما بداية رمضان والعيد فاتّبع فيها جهة رؤية الهلال في بلدك.


## 5. Neu seit dem 17.11. abend — NOCH ZU PRÜFEN (nicht freigegeben)

### 5a. Neue App-Strings (`mobile/src/lib/i18n.ts`, Block `ar`)

| Schlüssel | Arabisch | Bedeutung |
|---|---|---|
| `namesTitle` | أسماء الألوهية | Überschrift der 99-Namen-Ansicht (Titel ist aus dem PDF, nicht generiert) |
| `namesSource` | بطاقات alhosna.net التسع والتسعون، لأمين صبري | Quellenzeile (von mir geschrieben, zu prüfen) |
| `namesAll` | الأسماء التسعة والتسعون | Link „Alle 99 Namen" |
| `namesToday` | اليوم | „Heute" |
| `namesDraft` | الترجمة مسودة بانتظار المراجعة. | Hinweis „Übersetzung ist Entwurf" |
| `namesPrev` | الاسم السابق | „Voriger Name" |
| `namesNext` | الاسم التالي | „Nächster Name" |
| `dayShort` | اليوم | „Tag" |
| `monthShort` | الشهر | „Monat" |
| `yearShort` | السنة | „Jahr" |

Wiederverwendet und bereits freigegeben (Abschnitt 1): `nameOfDay` اسم اليوم, `nameOfN` من ٩٩,
`yourMoon` قمرك, `yourMoonHint` اختر تاريخًا — … , `hijriDate` التاريخ الهجري.

### 5b. 99 Namen (`mobile/src/data/divine-names.ts`)

- **Arabisch + Reihenfolge:** wörtlich aus dem PDF `alhosna-divine-2026-11-11.pdf`
  (alhosna.net, Amin Sabry) — kuratiert, NICHT generiert. Keine Sprachprüfung nötig.
- **`en` / `de` Übersetzungen:** Entwürfe von mir (`TRANSLATIONS_APPROVED = false`), nicht
  redaktionell geprüft. `pl`/`tr` zeigen Englisch, `ar` keine Übersetzung (Text ist schon arabisch).

### 5c. Weiterhin ungeprüft (unverändert)

- Die 18 arabischen Beobachtungstexte des Seeds (`web/data/reflections.json`,
  `arabicApproved: false`).
- Der restliche `ar`-Block von `mobile/src/lib/i18n.ts`, ausser den Schlüsseln aus Abschnitt 3
  und 5a.
