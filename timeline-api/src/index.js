export default {
  async fetch(request, env) {
    const origin = request.headers.get("Origin");
    const allowedOrigin = env.ALLOWED_ORIGIN;
    let corsOrigin = allowedOrigin;

    if (allowedOrigin.includes("localhost") && (origin && origin.includes("127.0.0.1"))) {
      corsOrigin = origin;
    } else if (origin !== allowedOrigin) {
      corsOrigin = null;
    }

    const corsHeaders = {
      "Access-Control-Allow-Origin": corsOrigin || "",
      "Access-Control-Allow-Methods": "GET, HEAD, POST, OPTIONS",
      "Access-Control-Allow-Headers": "*",
    };

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    try {
      const list = await env.MY_BUCKET.list({ limit: 100, prefix: 'photos/' });
      const baseUrl = "https://pub-f9783e61b5a24204aeb4b2690d873059.r2.dev";

      const files = list.objects
        .filter((obj) => !obj.key.endsWith('/'))
        .map((obj) => {
          return {
            filename: obj.key,
            url: `${baseUrl}/${obj.key}`,
            uploadedAt: obj.uploaded,
          };
        });

      return new Response(JSON.stringify(files), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });

    } catch (e) {
      return new Response(JSON.stringify({ error: e.message }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" }
      });
    }
  },
};