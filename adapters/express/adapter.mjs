// An elm-pages-v3 adapter for express.js
// See <https://elm-pages-v3.netlify.app/docs/adapters/>

import * as fs from "fs";

export default async function run({
  renderFunctionFilePath,
  // routePatterns,
  // apiRoutePatterns,
}) {
  console.log("Running elm pages express adapter");
  ensureDirSync("dist-server");
  fs.copyFileSync(renderFunctionFilePath, "./dist-server/elm-pages.mjs");
  fs.copyFileSync("./adapters/express/server.mjs", "./dist-server/server.mjs");
  fs.copyFileSync(
    "./adapters/express/middleware.mjs",
    "./dist-server/middleware.mjs"
  );
}

function ensureDirSync(dirpath) {
  try {
    fs.mkdirSync(dirpath, { recursive: true });
  } catch (err) {
    if (err.code !== "EEXIST") throw err;
  }
}
