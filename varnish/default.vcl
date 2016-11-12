# define our first nginx server
backend nginx01 {
    .host = "nginx1.rmdc.root.hwxint.site";
    .port = "10000";
}

# define our second nginx server
backend nginx02 {
    .host = "nginx2.rmdc.root.hwxint.site";
    .port = "10000";
}

# configure the load balancer
director nginx round-robin {
    { .backend = nginx01;}
    { .backend = nginx02;}
}

# When a request is made set the backend to the round-robin director named nginx
sub vcl_recv {
    set req.backend = nginx;
}

# Use more backends
sub vcl_fetch {
  # Varnish determined the object was not cacheable
  if (!(beresp.ttl > 0s)) {
    set beresp.http.X-Cacheable = "NO:Not Cacheable";
    return(hit_for_pass);
  }
  elseif (req.http.Cookie) {
    set beresp.http.X-Cacheable = "NO:Got cookie";
    return(hit_for_pass);
  }
  elseif (beresp.http.Cache-Control ~ "private") {
    set beresp.http.X-Cacheable = "NO:Cache-Control=private";
    return(hit_for_pass);
  }
  elseif (beresp.http.Cache-Control ~ "no-cache" || beresp.http.Pragma ~ "no-cache") {
    set beresp.http.X-Cacheable = "Refetch forced by user";
    return(hit_for_pass);
  # You are extending the lifetime of the object artificially
  }
  elseif (beresp.ttl < 1s) {
    set beresp.ttl   = 5s;
    set beresp.grace = 5s;
    set beresp.http.X-Cacheable = "YES:FORCED";
  # Varnish determined the object was cacheable
  } else {
    set beresp.http.X-Cacheable = "YES";
  }
}
