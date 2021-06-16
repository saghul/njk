# njk: powerful portable templating

*njk* is a single binary command line application designed to provide powerful
templating capabilities using environment variables.

Its primary use is to build configuration files at boot time in containerized
environments.

*njk* stands on shoulders of giants. It uses [Nunjucks](https://mozilla.github.io/nunjucks/)
as the templating engine and [QuickJS](https://bellard.org/quickjs/) as the
runtime. The result is **a statically linked binary which is < 1MB**.

**NOTE:** Windows is not currently supported.

## Usage

```bash
./njk /path/to/template-file.njk > /config/your-config-file
```

Example:

```
Hello, {{ env.USER }}
```

## Documentation

Check the [Nunjucks documentation on templating](https://mozilla.github.io/nunjucks/templating.html).

**NOTE:** Templates get a single context variable: `env` containing the environment
variables.

## Similar tools

* [frep](https://github.com/subchen/frep)
