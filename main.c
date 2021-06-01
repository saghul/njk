
#include "quickjs/quickjs-libc.h"


int main(int argc, char **argv) {
    JSRuntime *rt;
    JSContext *ctx;

    rt = JS_NewRuntime();
    js_std_init_handlers(rt);

    ctx = JS_NewContext(rt);
    js_std_add_helpers(ctx, argc, argv);

    js_std_loop(ctx);

    JS_FreeContext(ctx);
    JS_FreeRuntime(rt);

  return 0;
}
