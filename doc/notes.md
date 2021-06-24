# notes

---

# conclusion / determination

after working the the nginx-omniauth-adapter authentication flow...

dividing the nginx-mockauth-app into the /auth/:provider namespace
and /adapter namespace provides most the clearly into how the
authentication flow works and cleanly separates concerns of each area.

---

# steps

--

## /protected

description

## /auth/test

internal
stateless
no session cookie

## /auth/initiate

internal
stateless
no session cookie
redirects to /auth with querystring

## /auth

- should present a form that is post-able to /auth/:provider
- ?? rename to /auth/connect or /auth/login

public
receives parameters from /auth/initiate redirect
applied parameters to session cookie
redirects to /auth/:provider

## /auth/:provider

- under omniauth's control, do not override

public
omniauth/provider
redirects to /auth/:provider/callback

## /auth/:provider/callback

- under omniauth's control, do not override

public
omniauth/provider
redirects to /callback aka back_to

## /callback

- ?? rename to /back, /backto, /origin to avoid confusion with /auth/:provider/callback
- ?? or rename to /app/callback vs adapter/callback vs /auth/:provider/callback

public
redirects to /protected aka back_to

---
