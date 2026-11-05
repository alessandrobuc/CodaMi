import assert from "node:assert/strict";
import {test} from "node:test";

import {
  isBot, pageLangOf, pageMetaOf, pageReportOf, renderReportPage, reportIdOfPath, shareInputOf, viewSourceOf,
} from "./sharing";

const data = {
  ownerId: "u1", ownerName: "Mario Rossi", type: "lost", status: "open", petName: "Luna", species: "dog",
  description: "Shy <b>dog</b>, red collar", city: "Milano", placeDetail: "Città Studi", areaRadius: 500,
  eventAt: "2026-11-03T08:00:00.000Z", reward: 100, contactPhone: "+39 333 1234567", contactEmail: "mario@example.com",
  lat: 45.47, lng: 9.22, photoUrls: ["x"],
};
const photo = "https://firebasestorage.googleapis.com/v0/b/b/o/reports%2Fu1%2Fa.jpg?alt=media&token=t";

test("share input is checked", () => {
  assert.deepEqual(shareInputOf({reportId: "abc", target: "whatsapp", kind: "announce"}), {reportId: "abc", target: "whatsapp", kind: "announce"});
  assert.equal(shareInputOf({reportId: "abc", target: "myspace", kind: "announce"}), null);
  assert.equal(shareInputOf({reportId: "a/b", target: "copy", kind: "announce"}), null);
  assert.equal(shareInputOf({reportId: "abc", target: "copy", kind: "party"}), null);
});

test("page paths, languages and sources", () => {
  assert.equal(reportIdOfPath("/r/abc123"), "abc123");
  assert.equal(reportIdOfPath("/r/abc123/"), "abc123");
  assert.equal(reportIdOfPath("/r/../x"), null);
  assert.equal(reportIdOfPath("/x/abc"), null);
  assert.equal(pageLangOf("it", "de-DE"), "it");
  assert.equal(pageLangOf("xx", "fr-FR,fr;q=0.9"), "fr");
  assert.equal(pageLangOf(undefined, "ja-JP"), "en");
  assert.equal(viewSourceOf("qr"), "qr");
  assert.equal(viewSourceOf("evil"), "direct");
  assert.equal(isBot("facebookexternalhit/1.1"), true);
  assert.equal(isBot("WhatsApp/2.23"), true);
  assert.equal(isBot("Mozilla/5.0 (iPhone; CPU iPhone OS 18_0)"), false);
});

test("the public page shows only public fields", () => {
  const r = pageReportOf("abc", data, [photo])!;
  const html = renderReportPage(r, {lang: "en", appStoreId: null, url: "https://codami-cd91e.web.app/r/abc?l=en"});
  for (const secret of ["333 1234567", "mario@example.com", "Mario Rossi", "45.47", "9.22"]) {
    assert.ok(!html.includes(secret), `page must not show ${secret}`);
  }
  assert.ok(html.includes("Shy &lt;b&gt;dog&lt;/b&gt;"), "typed HTML is escaped");
  assert.ok(html.includes(`property="og:image" content="${photo.replace(/&/g, "&amp;")}"`));
  assert.ok(html.includes("LOST: Luna · Dog · Milano"));
  assert.ok(html.includes("near Città Studi, Milano"));
  assert.ok(html.includes("€100"));
  assert.ok(html.includes("intent://report/abc#Intent;scheme=codami;package=com.codami.app"));
});

test("hidden reports are gone, resolved ones celebrate", () => {
  assert.equal(pageReportOf("abc", {...data, status: "hidden"}, []), null);
  assert.equal(pageReportOf("abc", undefined, []), null);
  const home = pageReportOf("abc", {...data, status: "resolved"}, [])!;
  assert.equal(home.reward, null, "no reward once resolved");
  assert.equal(pageMetaOf(home, "it").title, "Luna è tornato a casa grazie a CodaMi! 🎉");
  const gone = renderReportPage(null, {lang: "de", appStoreId: "123456789", url: "https://codami-cd91e.web.app"});
  assert.ok(gone.includes("nicht mehr verfügbar"));
  assert.ok(gone.includes("apps.apple.com/app/id123456789"));
});

test("found reports and other languages", () => {
  const found = pageReportOf("f", {...data, type: "found", petName: "", reward: 50}, [])!;
  assert.equal(found.reward, null, "found reports have no reward");
  assert.equal(pageMetaOf(found, "en").title, "FOUND: Dog · Milano");
  const ar = renderReportPage(found, {lang: "ar", appStoreId: null, url: "u"});
  assert.ok(ar.includes("dir=\"rtl\""));
});
