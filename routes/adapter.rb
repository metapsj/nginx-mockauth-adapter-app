module Routes
  class Adapter < Cuba
    define do

      # internal: GET /adapter/test -> 200 || 401 || 403
      on "test" do
        log.info("GET /adapter/test")

        unauthorized unless authenticated?
        unauthorized if expired?
        forbidden unless authorized?

        # adapter.ready? or adapter.back_to_present?
        # originally session[:back_to] must be present
        res.headers.merge!(
          'x-ngx-omniauth-provider' => current_user[:provider],
          'x-ngx-omniauth-user' => current_user[:user_id],
          'x-ngx-omniauth-info' => current_user[:info]
        )
        res.text("OK")
      end

      # internal: GET /adapter/initiate -> 302 || 400
      on "initiate" do
        log.info("GET /adapter/initiate")

        bad_request unless adapter.ready?

        # initiating client authentication
        res.redirect(adapter_auth_url_with_callback)
      end

      # GET /adapter/auth || login -> 302 || 302 || 400
      on "auth" do
        log.info("GET /adapter/auth")

        username = 'd00d!'  # req.params['username']
        password = 'd00d!'  # req.params['password']

        authenticate('d00d!', 'd00d!') unless authenticated?

        bad_request unless adapter.ready?
        unauthorized unless authenticated?

        # update_session! >> ?? authorized_at, authenticated_at
        # set_flow_id, common session, adapter session, app session
        # send app session to app
        # delete back_to, app_callback
        res.redirect(adapter.callback) if authenticated? && !expired?

        # handoff client authentication to auth/:provider
        res.redirect(auth_mockauth_url)
      end

      # GET /adapter/callback -> 302
      on "callback" do
        log.info("GET /adapter/callback")

        # res.redirect(session.delete(:back_to))
        res.redirect(adapter.back_to)
      end

      # GET /adapter/logout -> 200
      on "logout" do
        log.info("GET /adapter/logout")

        destroy_session

        res.text("GET /adapter/logout")
      end

    end
  end
end
