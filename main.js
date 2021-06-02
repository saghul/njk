
import * as std from 'std';
import * as os from 'os';


// Utility functions.
//

function printError(msg) {
    std.err.puts(`${msg}\n`);
}

function exitIfError(errno) {
    if (errno !== 0) {
        std.err.puts(`Error: ${errno} ${std.strerror(errno)}\n`);
        std.exit(1);
    }
}


// Template loader for Nunjucks.
//

class FSLoader {
    constructor(searchPath, opts = {}) {
        this.searchPath = searchPath;
        this.opts = opts;
    }

    getSource(name) {
        const fullPath = `${this.searchPath}/${name}`;
        const data = std.loadFile(fullPath);

        if (data === null) {
            return null;
        }

        return {
            src: data,
            path: fullPath,
            noCache: Boolean(this.opts.noCache)
        };
    }
}


// The meat and potatoes.
//

const { nunjucks, scriptArgs } = globalThis;
const fname = scriptArgs[1];

if (!fname) {
    printError('A file must be specified');
    std.exit(1);
}

// Normalize path and make susre it's a regular file.

const [ realpath, realpathErr ] = os.realpath(fname);

exitIfError(realpathErr);

const [ stat, statErr ] = os.stat(realpath);

exitIfError(statErr);

if ((stat.mode & os.S_IFREG) !== os.S_IFREG) {
    printError('Not a regular file');
    std.exit(1);
}

// Split into dirname and basename.

const idx = realpath.lastIndexOf('/');
const templateDir = realpath.slice(0, idx);
const templateName = realpath.slice(idx + 1);

// Render with Nunjucks. The context is an object with a single key: "env".
const nenv = new nunjucks.Environment(new FSLoader(templateDir, { noCache: true }));
const res = nenv.render(templateName, { env: std.getenviron() });

std.out.puts(res);
std.out.flush();

std.exit(0);
