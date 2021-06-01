
const { nunjucks } = globalThis;

const res = nunjucks.renderString('Hello {{ something }}', { something: 'World!' });

console.log(res);
