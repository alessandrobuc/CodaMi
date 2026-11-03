import {defineSecret} from "firebase-functions/params";

// Set with `firebase functions:secrets:set PLACES_API_KEY`; the emulator reads functions/.secret.local.
export const placesApiKey = defineSecret("PLACES_API_KEY");
export const placesSecret = {secrets: [placesApiKey]};
