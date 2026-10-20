import {setGlobalOptions} from "firebase-functions/options";

// Imported first by every file that defines functions, so they all get these.
setGlobalOptions({region: "europe-west1", maxInstances: 10});
