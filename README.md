# njk: Powerful templating in a small package

*njk* is a single binary command like application designed to providfe powerful
templating capabilities using environment variables.

It's primary use is to build configuration files at boot time in containerized
environments.

*njk* stands on shoulders of giants. It uses [Nunjucks](https://mozilla.github.io/nunjucks/)
as the templating library and [QuickJS](https://bellard.org/quickjs/) as the
runtime. The result is a statically linked binary which is < 1MB.

**NOTE:** Windows is not currently supported.

## Usage

```bash
./njk /path/to/template-file.njk > /config/your-config-file
```

## Documentation

Check the [Nunjucks documentation on templating](https://mozilla.github.io/nunjucks/templating.html).

## Similar tools

* [frep](https://github.com/subchen/frep)
