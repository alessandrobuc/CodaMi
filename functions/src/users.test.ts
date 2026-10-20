import assert from "node:assert/strict";
import {test} from "node:test";

import {searchFieldsOf} from "./users";

test("search fields are lowercase and only written when they change", () => {
  assert.deepEqual(
    searchFieldsOf({name: " Mario Rossi ", email: "Mario@Example.com"}),
    {searchName: "mario rossi", searchEmail: "mario@example.com"},
  );
  assert.equal(
    searchFieldsOf({name: "Mario", email: "m@x.it", searchName: "mario", searchEmail: "m@x.it"}),
    null,
  );
  assert.deepEqual(searchFieldsOf({}), {searchName: "", searchEmail: ""});
});
