import express from "express";
import elmPagesMiddleware from "./middleware.mjs";

const app = express();
const port = 3000;

app.use(express.static("dist"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(elmPagesMiddleware);
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
