
const nunjucks = require('nunjucks');
const path = require('path');

const arg = process.argv[2];
const p = path.resolve(arg);

nunjucks.configure(path.dirname(p), { autoescape: false });

const env = process.env;
delete env['_'];

const r = nunjucks.render(p, { env });

process.stdout.write(r);

