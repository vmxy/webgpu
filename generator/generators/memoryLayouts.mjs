import fs from "fs";
import nunjucks from "nunjucks";

import pkg from "../../package.json" assert { type: "json" };

import {
  warn
} from "../utils.mjs";

let ast = null;

const H_TEMPLATE = fs.readFileSync(`${pkg.config.TEMPLATE_DIR}/memoryLayouts-h.njk`, "utf-8");

nunjucks.configure({ autoescape: true });

export default function(astReference) {
  ast = astReference;
  let out = {};
  let vars = {
    structures: ast.structures
  };
  // h
  {
    let template = H_TEMPLATE;
    let output = nunjucks.renderString(template, vars);
    out.header = output;
  }
  return out;
};
