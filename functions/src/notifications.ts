type Json = Record<string, unknown>;

export type NotificationKind = "new_report" | "report_resolved";

export interface ReportSummary {
  id: string;
  ownerId: string;
  type: "lost" | "found";
  petName: string;
  city: string;
  cityKey: string;
  placeDetail: string | null;
  photoUrl: string | null;
  status: string;
}

export interface NotificationContent {
  kind: NotificationKind;
  title: string;
  body: string;
}

export function readReport(id: string, data: Json | undefined): ReportSummary | null {
  if (!data) return null;
  const text = (key: string) =>
    typeof data[key] === "string" && (data[key] as string).trim()
      ? (data[key] as string).trim()
      : null;
  const ownerId = text("ownerId");
  const cityKey = text("cityKey");
  if (!ownerId || !cityKey) return null;
  const photos = Array.isArray(data.photoUrls) ? data.photoUrls : [];
  return {
    id,
    ownerId,
    type: data.type === "found" ? "found" : "lost",
    petName: text("petName") ?? "A pet",
    city: text("city") ?? "",
    cityKey,
    placeDetail: text("placeDetail"),
    photoUrl: typeof photos[0] === "string" ? photos[0] : null,
    status: text("status") ?? "open",
  };
}

export function newReportContent(report: ReportSummary): NotificationContent {
  const where = report.placeDetail
    ? `near ${report.placeDetail}, ${report.city}`
    : `in ${report.city}`;
  return report.type === "lost"
    ? {
      kind: "new_report",
      title: `Lost pet in ${report.city}`,
      body: `${report.petName} was last seen ${where}. Keep an eye out!`,
    }
    : {
      kind: "new_report",
      title: `Pet found in ${report.city}`,
      body: `${report.petName} was found ${where}. Do you know the owner?`,
    };
}

export function resolvedContent(report: ReportSummary): NotificationContent {
  return report.type === "lost"
    ? {
      kind: "report_resolved",
      title: `${report.petName} is back home`,
      body: `Good news from ${report.city}: ${report.petName} has been found. Thank you for helping!`,
    }
    : {
      kind: "report_resolved",
      title: `${report.petName} is reunited`,
      body: `The pet found in ${report.city} is back with its family.`,
    };
}

export function becameResolved(before: Json | undefined, after: Json | undefined): boolean {
  return before?.status === "open" && after?.status === "resolved";
}

export function chunk<T>(items: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < items.length; i += size) out.push(items.slice(i, i + size));
  return out;
}
