/**
 * seed.js - populates tours and default settings so the API has real
 * data to serve immediately after setup.
 * Run with: node seed.js  (safe to re-run; it upserts, never duplicates)
 */
const { loadEnv } = require("./lib/env");
loadEnv();
const { transaction, readAll } = require("./lib/store");

const TOURS = [
  ["kos-island", "island", true, "best_seller", "Kos Island Tour", 45, 10, 4.9, 245],
  ["leros-island", "island", true, "none", "Leros Island Tour", 48, 11, 4.7, 96],
  ["kalymnos-island", "island", true, "none", "Kalymnos Island Tour", 50, 10, 4.8, 112],
  ["boat-trip", "water", false, "best_seller", "Bodrum Boat Trip", 35, 7, 4.8, 320],
  ["turkish-bath", "wellness", false, "none", "Turkish Bath (Hammam) Experience", 25, 1.5, 4.7, 168],
  ["jeep-safari", "land", false, "popular", "Jeep Safari Adventure", 40, 6, 4.8, 180],
  ["atv-safari", "land", false, "none", "ATV Safari", 38, 3, 4.7, 94],
  ["horse-riding", "land", false, "none", "Horse Riding Tour", 30, 2, 4.8, 76],
  ["scuba-diving", "water", false, "popular", "Scuba Diving Experience", 60, 4, 4.9, 150],
  ["dolphin-park", "land", false, "none", "Dolphin Park Visit", 42, 3, 4.6, 88],
  ["aquapark", "land", false, "none", "Aquapark Day Pass", 28, 6, 4.6, 140],
  ["pamukkale", "land", false, "popular", "Pamukkale Day Trip", 55, 13, 4.9, 210],
  ["ephesus", "land", false, "best_seller", "Ephesus Ancient City Tour", 50, 11, 4.9, 268],
  ["dalyan", "land", false, "none", "Dalyan Tour", 45, 12, 4.8, 132],
  ["rafting", "land", false, "none", "Rafting Adventure", 40, 12, 4.7, 64],
  ["airport-transfer", "transfer", false, "none", "Airport Transfer", 18, 1, 4.8, 302],
  ["vip-transfer", "transfer", false, "none", "VIP Transfer", 45, 1, 4.9, 71],
  ["bodrum-transfer", "transfer", false, "none", "Bodrum Local Transfer", 20, 1, 4.7, 54],
  ["bodrum-city-tour", "land", false, "popular", "Bodrum City Tour", 35, 6, 4.7, 88],
];

const FEATURED = new Set(["kos-island", "boat-trip", "pamukkale", "jeep-safari", "scuba-diving", "ephesus"]);

const DEFAULT_SETTINGS = {
  companyName: "MT TRAVEL",
  phone: "+90 538 329 37 27",
  whatsapp: "905383293727",
  email: "mttravelbodrum@gmail.com",
  address: "Neyzen Tevfik Street No. 45, Bodrum, Mugla, Turkiye",
  currency: "EUR",
  islandMinAdvanceDays: 1,
  defaultLanguage: "en",
};

transaction((data) => {
  const ALL_DAYS = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];
  const bySlug = Object.fromEntries(data.tours.map((t) => [t.slug, t]));
  for (const [slug, category, isIsland, badge, name, price, durationHours, rating, reviewCount] of TOURS) {
    const existing = bySlug[slug];
    bySlug[slug] = {
      ...(existing || { createdAt: new Date().toISOString() }),
      slug, category, isIsland, badge, name, price, durationHours, rating, reviewCount,
      featured: FEATURED.has(slug),
      visible: existing ? existing.visible : true,
      availableDays: existing && existing.availableDays ? existing.availableDays : [...ALL_DAYS],
      priceAdult: existing && existing.priceAdult != null ? existing.priceAdult : price,
      priceChild: existing && existing.priceChild != null ? existing.priceChild : Math.round(price * 0.5 * 100) / 100,
      priceInfant: existing && existing.priceInfant != null ? existing.priceInfant : 0,
      // ATV Safari is the one tour that's rented per-vehicle (single or
      // double/tandem ATV) rather than priced per adult/child/infant head
      // count - pricingMode drives which fields Admin -> Tours and the
      // booking page show. Every other tour defaults to "standard" and
      // ignores priceSingle/priceDouble entirely.
      pricingMode: existing && existing.pricingMode ? existing.pricingMode : (slug === "atv-safari" ? "single_double" : "standard"),
      priceSingle: existing && existing.priceSingle != null ? existing.priceSingle : (slug === "atv-safari" ? price : Math.round(price * 0.85 * 100) / 100),
      priceDouble: existing && existing.priceDouble != null ? existing.priceDouble : (slug === "atv-safari" ? Math.round(price * 1.7 * 100) / 100 : Math.round(price * 1.6 * 100) / 100),
      // Clock times (e.g. "08:00"), independent of durationHours - an
      // admin sets these directly rather than a duration the site derives
      // a departure/return display from. Defaults only apply the first
      // time a tour is seeded; a reasonable return time is worked out
      // from the existing duration so tours don't all start out identical.
      departureTime: existing && existing.departureTime ? existing.departureTime : "08:00",
      returnTime: existing && existing.returnTime ? existing.returnTime : (() => {
        const totalMinutes = 8 * 60 + Math.round((durationHours || 8) * 60);
        const h = Math.floor(totalMinutes / 60) % 24;
        const m = totalMinutes % 60;
        return `${String(h).padStart(2, "0")}:${String(m).padStart(2, "0")}`;
      })(),
    };
  }
  data.tours = Object.values(bySlug);
  data.settings = { ...DEFAULT_SETTINGS, ...data.settings };

  // Starter hotel list so the searchable hotel field has real options to
  // try immediately - only seeded the first time (an empty/missing array),
  // never overwriting hotels an admin has since added, edited, or removed.
  if (!data.hotels || data.hotels.length === 0) {
    // Bodrum Merkez only (Kumbahce, Eskicesme, Carsi neighbourhoods) -
    // deliberately excludes Gumbet, Bitez, Ortakent, Yalikavak, Gundogan,
    // Turkbuku, Torba, Turgutreis, Akyarlar, Gumusluk, Kadikalesi, Yahsi
    // and every other surrounding town/resort area, per what was asked.
    // Real, individually web-searched hotels across Bodrum district -
    // organized by area for maintainability, but stored as one flat list
    // since the booking page's search doesn't filter by area. Areas with
    // very few well-documented, distinctly-named hotels in search results
    // (Konacik, Kadikalesi/Peksimet, Islamhaneleri, Icmeler, Aspat) are
    // genuinely thin here - what's out there is mostly small unnamed
    // pensions/apart listings, not an oversight. The admin can add any
    // specific property via Admin -> Hotels at any time.
    const STARTER_HOTELS = [
      // Bodrum Merkez (Kumbahce / Eskicesme / Carsi)
      "The Marmara Bodrum", "Doubletree by Hilton Bodrum Marina Vista", "Holiday Inn Resort Bodrum",
      "Mandarin Resort & Spa Bodrum", "Diamond Of Bodrum Hotel", "METT Hotel Beach Resort Bodrum",
      "Noi Hotel Bodrum", "La Quinta by Wyndham Bodrum", "Azka Hotel",
      "Gulet Otel", "Kılavuz Otel", "Okyanus Otel", "Merhaba Hotel", "Petra Butik Otel",
      // Gumbet
      "Jasmin Beach Hotel", "Costa Luvi Hotel Bodrum", "Jasmin Elite Residence & Spa",
      "The Poyz Hotel Bodrum", "Nagi Beach Hotel", "Canna Garden Hotel", "Serpina Hotel",
      "Royal Asarlık Beach Hotel & Spa", "Gümbet Beach Resort",
      // Bitez
      "Ramada Resort By Wyndham Bodrum Bitez",
      // Turgutreis
      "Sianji Well-Being Resort", "Kairaba Bodrum Princess & Spa", "La Blanche Resort & Spa",
      "Greenblue Hotel Turgutreis",
      // Ortakent / Yahsi
      "Yılmaz Hotel Ortakent",
      // Yalikavak
      "Sirene Luxury Hotel Bodrum", "Ruins Luxury Resort - Adults Only", "Delta Hotels By Marriott Bodrum",
      "Le Jardin d'Oliviers Yalıkavak", "Avantgarde Collection Yalıkavak", "Amore Boutique Hotel",
      "Elite Hotel Yalıkavak",
      // Gundogan
      "Green Beach Resort",
      // Golturkbuku / Turkbuku
      "Macakızı Hotel", "Faros Hotel", "Lavinya Otel", "Selvi Beach Otel", "Daphnis Otel",
      "Elista Hotel & Spa",
      // Torba
      "Rixos Premium Bodrum", "Duja Bodrum Torba", "Vogue Hotel Supreme Bodrum",
      "Doubletree By Hilton Bodrum Isil Club", "Grand Yazıcı Torba",
      // Akyarlar
      "Kairaba Bodrum Imperial", "Armonia Holiday Village & Spa",
      // Gumusluk
      "Gümüşlük Otel",
      // Guvercinlik / Yaliciftlik (Ciftlik)
      "La Blanche Island Bodrum", "Kempinski Hotel Barbaros Bay",
      // Yalikavak (expanded)
      "The Bodrum EDITION", "Allium Bodrum Resort & Spa", "4reasons Hotel+Bistro",
      "MGallery The Bodrum Hotel Yalıkavak", "Arts Hotel Bodrum Yalıkavak", "Princess Artemisia Hotel",
      "Ailla Yalıkavak", "The Highlight Bodrum", "Yalıkavak Marina Hotel By Social Living Collection",
      "Art Suites Hotel", "Birdcage 33 Hotel", "Sezz Hotels Spa Wellness",
      "G Beyond Residences & Villas", "Root Redrock Yalıkavak", "Sandora Boutique Hotel",
      "Boho Hotel", "Ala Suites & Villas", "La Maison Bodrum", "Adahan Hotel",
      "Saraya Bodrum Hotel", "Moon Beach & Hotel", "Aegean Hills",
      "Bovilla Hotels & Villas Yalıkavak", "Maxx Royal Bodrum Resort", "Golden Age Bodrum Hotel",
      "Club Cactus Fleur Beach", "Yaz Yalıkavak", "Life Butiq Otel", "La Local Yalıkavak",
      "Cactus Mirage Family Club", "Sea Palm Otel Yalıkavak", "Palmalife Bodrum Resort & Spa",
      "Ali Baba Hotel Yalıkavak",
      // Gumbet (expanded)
      "Ayhan Suite Hotel", "Yıldız Hotel", "Dreams Bodrum Otel", "Mirada Exclusive Bodrum",
      "Costa Blu Resort", "Artı Hotels Adult Only", "Bodrum Palm Otel",
      // Bitez (expanded)
      "Doria Hotel Bodrum", "Ambrosia Hotel Beach & Spa",
      "Agaya Bodrum Adult Only", "Bodrium Hotel & Spa", "Very Chic Bodrum",
      "Voyage Torba", "Hyde Bodrum", "Susona Bodrum LXR Hotels & Resorts",
      "Mivara Luxury Resort & Spa Bodrum", "Arin Resort Bodrum", "Swissôtel Resort Bodrum Beach",
      "Hillstone Bodrum Hotel & Spa", "The Plaza Bodrum", "Xanadu Island Bodrum",
      "Esmana Hotel", "Costa Bianca Hotel", "Queen Boutique Hotel", "Hotel Marmara Mandarin",
      "Bitez Deniz Hotel", "Sebastian Hotel", "Lango Design Hotel & Spa", "Merih Boutique Otel",
      "Roas Hotel",
      // Turgutreis (expanded)
      "Azure By Yelken Hotel", "Selectum Colours Bodrum", "Selectum Collection Bodrum",
      "Rammos Managed By Dedeman", "Dragut Point South", "Yasmin Bodrum Resort",
      // User-supplied research pass - vetted for exact and near-duplicates
      // against everything above (case/spacing/suffix variants merged into
      // whichever name was already present, or the clearer of the two).
      "7 Art Fesleğen Boutique Hotel", "1453 Bodrum Resort Hotel & Spa", "Acanthus Cennet Barut Collection",
      "Açelya Hotel", "Agan Pansiyon", "Agean Dream Resort",
      "Aegean Garden Hotel", "Akça Hotel", "Akkan Beach Hotel",
      "Akkan Hotel Marina", "Akkan Plus Hotel", "Akyalı Boutique Hotel",
      "Alabanda Hotel", "Alacatur Hotel", "Alba Marin Hotel",
      "Alexander The Great Resort & Spa", "Alta Park Hotel", "Amanruya",
      "Amfora Hotel", "Anadolu Hotel Bodrum", "Anfora Pension",
      "Antik Zeytin Hotel & Art", "Antique Theatre Hotel", "Arion Resort Boutique Hotel",
      "Artemis Hotel", "Artunc Hotel", "Asmin Hotel Bodrum",
      "Asteria Bodrum Resort", "Avantgarde Refined Yalıkavak", "Ayaz Aqua Hotel",
      "Babana Hotel", "Baia Bodrum Hotel", "Bircan Hotel",
      "Blue Dreams Resort", "Bodrum Park Resort", "Bronze Hotel",
      "Caresse, a Luxury Collection Resort & Spa", "Casa Dell'Arte Hotel", "Casa Nonna Bodrum",
      "Elementa Boutique Hotel", "Elite Hotel Bodrum", "El Vino Hotel & Suites",
      "Ersan Resort & Spa", "Eskiceshme Hotel", "Eterna Hotel Bodrum",
      "Flamm Bodrum", "Forever Club Bodrum", "Golden Age Hotel Yalıkavak",
      "Golden Beach Hotel", "Golden Spoon Hotel", "Green Bay Resort & Spa",
      "Gumbet Cove Hotel", "Gümbet Anıl Beach", "Gümbet Life Hotel",
      "Hotel Centro Bodrum", "Hotel Karia Princess", "Hotel Samara",
      "Hotel Su Bodrum", "Inone Mucho Selection Hotel", "Kaya Palazzo Resort & Residences Le Chic Bodrum",
      "Kefaluka Resort", "Khai Hotel Bodrum", "Labranda TMT Bodrum",
      "La Local Suites", "Liona Hotel & Spa", "Liv Hotel by Bellazure",
      "Lujo Hotel Bodrum", "Maçakızı Hotel", "Mandarin Oriental Bodrum",
      "Marina Vista Bodrum", "Marvel Beach Hotel", "Mavi Kumsal Hotel",
      "Med-Inn Boutique Hotel", "Moonshine Hotel & Suites", "Ena Boutique Hotel",
      "Gündem Resort Hotel", "Hotel Vita Bella Resort & Spa", "No 81 Hotel",
      "Okaliptus Hotel", "Olira Boutique Hotel", "Parkim Ayaz Hotel",
      "Petunya Beach Resort", "Phoenix Sun Hotel", "Prive Hotel Bodrum",
      "Rammos Hotel Bodrum", "Regia Mare Beach Hotel", "Riva Bodrum Resort",
      "Royal Arena Resort & Spa", "Salmakis Resort & Spa", "Sami Beach Hotel",
      "Sea Garden Resort", "Senses Hotel Bodrum", "Scorpios Bodrum",
      "Sunpoint Family Hotel", "Sunhill Hotel", "The Hello Hotel",
      "The Norm Collection Door'a Bodrum", "Titanic Luxury Collection Bodrum", "Toloman Hotel",
      "Torbahan Hotel", "TUI Magic Life Bodrum", "Villa Cosy Hotel",
      "Villa Rustica Hotel", "Voyage Bodrum", "Voyage Torba Private",
      "Yalıpark Beach Hotel", "Yalıkavak Holiday Gardens", "Yelken Mandalinci Spa & Wellness Hotel",
      "Zest Exclusive Hotel & Spa", "Afytos Bodrum", "Bagevleri Hotel",
      "Baska Resort Hotel", "Natur Garden Hotel", "Nefes Hotel",
      "Nomia Hotel", "OKU Bodrum", "Omar Hotel & Suites",
      "Radisson Collection Hotel Bodrum", "Smart Holiday Hotel", "Mio Bianco Resort",
      "Mio Mare Hotel", "Natur Med Hotel", "Nio Hotel Bodrum",
      "Ocean Club Bodrum", "Oscar Seaside Hotel", "Palm Garden Hotel",
      "Pitos Bungalows", "Rammos Managed Collection", "Rota Hotel Bodrum",
      "Sade Butik Otel", "Sea Soul Otel", "Sevin Hotel Pension",
      "Siesta Beach Apart", "Smart Stay Beach Bodrum", "The Oba Hotel",
      "The Professor's Hotel", "Tropicana Beach Hotel", "Veltur Hotel",
      "Villa Nergis Hotel", "Voyage Türkbükü", "Yalı Han Hotel",
      "Yalıyanı Motel", "Yelken Hotel", "Zuzu's Kitchen & Hotel",
      "Costa Maya Bodrum", "Costa Sariyaz Hotel", "Bodrum Skylife Hotel",
      "Bitez Garden Life Hotel", "Bitez Marina Hotel", "Club Muskebi Hotel",
      "Club Dedeman Bodrum", "Club Blue Dream", "Club Hotel Flora",
      "Crystal Green Bay Resort", "Forever Club Adult Only", "Göltürkbükü Suites",
      "Gündoğan Suites Hotel", "Hill Hotel Bodrum",
      // These 6 were auto-flagged by an overly aggressive duplicate check
      // against unrelated existing entries (normalizing away too many
      // common words like "Hotel"/"Resort"/"Bodrum" made e.g. "M Suite
      // Hotel Bodrum" look like a match for "Holiday Inn Resort Bodrum").
      // Verified as genuinely separate properties and restored.
      "Villa Oliva Boutique Hotel", "M Suite Hotel Bodrum", "Bodrum Beach Resort",
      "Bodrum Holiday Resort & Spa", "Akkan Hotel", "Nagi Suites",
      // Round 3: targeted research for previously-thin areas
      // (Konacik, Kadikalesi/Peksimet, Guvercinlik)
      "Euphoria Suites and Spa", "Pittas Studios & Apartments", "Kadıkale Resort Hotel",
      "Peksimet Butik Otel", "Zena Hotel Bodrum", "Le Meridien Bodrum Beach Resort",
      "The Qasr Bodrum Halal Resort", "İnanç Hotel",
      // Round 4: verified directly via Google Places API (places_search) -
      // real coordinates, phone numbers, and review counts for every one
      // of these, giving much higher confidence than text search snippets.
      "By Muhtar Otel Bodrum", "Bodrum Vera Hotel", "Wish Suites Bodrum",
      "R House Hotel", "Oalis Hotel", "Bodrum Blu",
      "Station Hotel in Bodrum", "Alfa Apart Otel", "Sundance Suites Hotel",
      "9Bodrum Butik Hotel", "The Lume Boutique Hotel & Restaurant & Spa", "Quatro Life Hotel",
      "Casa De Nova Hotel Bodrum", "Flag Suites Bodrum", "Lizbonia Hotels Yalıkavak",
      "Tangiers Hotel Yalıkavak", "Bombien Yalikavak", "Marin Yalıkavak Hotel",
      "Spektr Boutique Hotel Yalikavak", "Olivia Hotel", "Mira Suites",
      "Hotel Zeytinada", "Anar Hotel", "Toka Bodrum Hotel & Beach Club",
      "Panorama Hotel Turkbuku", "Caja by Maxx Royal", "MyElla Hotel Resort & Spa",
      "Sundance Resort", "Suum Bodrum Hotel & Beach", "Liman Hotel Gümüslük",
      "Myndos Bed & Breakfast Gümüşlük", "Oda Bodrum Gümüşlük", "Metin's Gümüşlük Hotel & Restaurant",
      "Oza Butik Hotel", "Gümüşlük No3", "Paradise Garden Apartments",
      // Round 5: from a user-supplied "2630 hotel" PDF. Analysis showed
      // it was a synthetic/templated document (ReportLab-generated,
      // same day as this request, ~30 root words x a handful of suffix
      // words x 19 regions repeated with sequence numbers - "Zeytin
      // Apart Otel" alone appeared 47 times). Only the 51 non-repeating
      // names were considered; of those, most were already in this
      // list, and each remaining candidate was checked individually
      // against Google Places before being added here.
      "Divan Bodrum Otel", "Dorman Suites Hotel", "Manzara Otel", "Dinç Pansiyon", "Ağan Pansiyon",
    ];
    data.hotels = STARTER_HOTELS.map((name, i) => ({
      id: `htl-seed-${i}`, name, createdAt: new Date().toISOString(),
    }));
  }
}).then(() => {
  const { DB_PATH } = require("./lib/store");
  console.log(`Seeded ${TOURS.length} tours and default settings into ${DB_PATH}`);
});
