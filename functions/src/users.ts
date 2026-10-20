type Json = Record<string, unknown>;

export function searchText(value: unknown): string {
  return typeof value === "string" ? value.trim().toLowerCase() : "";
}

// The lowercase copies admins search by, or null when they are already current.
export function searchFieldsOf(user: Json): {searchName: string; searchEmail: string} | null {
  const searchName = searchText(user.name);
  const searchEmail = searchText(user.email);
  if (user.searchName === searchName && user.searchEmail === searchEmail) return null;
  return {searchName, searchEmail};
}
