vcl 4.1;

backend default {
    # your application
    .host = "127.0.0.1";
    .port = "80";
}

acl localnetwork {
  "10.0.0.0"/8;
  "localhost";
}

sub vcl_recv {
  if (req.method == "PURGE") {
    if (client.ip ~ localnetwork) {
        ban("req.http.host == " + req.http.host + " && req.url ~ " + req.url);
        return(synth(200, "Purge OK : " + req.http.host + req.url));
    }
    return(synth(403, "Purge NG : " + req.http.host + req.url));
  }

  if (req.method != "GET" && req.method != "HEAD") {
    return (pipe);
  }

  if (req.http.Authenticate || req.http.Authorization) {
    return (pipe);
  }

  if (req.method != "GET" &&
    req.method != "HEAD" &&
    req.method != "PUT" &&
    req.method != "POST" &&
    req.method != "TRACE" &&
    req.method != "OPTIONS" &&
    req.method != "PATCH" &&
    req.method != "DELETE") {
    /* Non-RFC2616 or CONNECT which is weird. */
    return (pipe);
  }

  return(hash);
}

sub vcl_hash {}

sub vcl_backend_response {}

sub vcl_deliver {
  unset resp.http.X-Varnish;
  unset resp.http.Via;
  unset resp.http.Etag;

  if (obj.hits > 0) {
    set resp.http.X-Cache = "HIT";
  } else {
    set resp.http.X-Cache = "MISS";
  }

  unset resp.http.x-url;
}
