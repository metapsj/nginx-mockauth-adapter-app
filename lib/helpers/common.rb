module Helpers
  module Common

    # RACK
    def session_options
      req.env['rack.session.options']
    end

    def destroy_session
      # prevent delete_session from generating a new sid
      session_options[:drop] = true
      # destroy calls session.clear
      session.destroy
      # rack sends a cookie with an empty session,
      # but let's tell the browser to actually delete the cookie
      res.delete_cookie(
        'rack.session',
        domain: session_options[:domain],
        path: session_options[:path]
      )
    end

    # FORM
    def encode(url)
      URI.encode_www_form_component(url)
    end

    # 4XX RESPONSES
    def bad_request
      log.info(">> bad request")

      res.status = 400
      res.text("Bad Request")
      halt(res.finish)
    end

    def unauthorized
      log.info(">> unauthorized")

      # 401 unauthorized
      # x-ngx-omniauth-original-uri
      # unless current_user
      # if app_authorization_expired?
      res.status = 401
      res.text("Unauthorized")
      halt(res.finish)

      #unless session[:back_to]
      #  res.status = 401
      #  res.text("Unauthorized")
      #  halt(res.finish)
      #end
    end

    def forbidden
      log.info(">> forbidden")

      # 403: &policy_proc
      res.status = 403
      res.text("Forbidden")
      halt(res.finish)
    end

    # CRYPTOGRAPHY
    def encrypt_param(param)
      # TODO:
    end

    def decrypt_param(param)
      # TODO:
    end

  end
end
