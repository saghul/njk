
#include "quickjs/quickjs-libc.h"

extern const uint8_t mainjs[];
extern const uint32_t mainjs_size;
extern const uint8_t nunjucks[];
extern const uint32_t nunjucks_size;


int main(int argc, char **argv) {
    JSRuntime *rt;
    JSContext *ctx;

    rt = JS_NewRuntime();
    js_std_init_handlers(rt);

    ctx = JS_NewContext(rt);
    js_std_add_helpers(ctx, argc, argv);
    js_init_module_std(ctx, "std");
    js_init_module_os(ctx, "os");

    js_std_eval_binary(ctx, nunjucks, nunjucks_size, 0);
    js_std_eval_binary(ctx, mainjs, mainjs_size, 0);

    js_std_loop(ctx);

    JS_FreeContext(ctx);
    JS_FreeRuntime(rt);

  return 0;
}
