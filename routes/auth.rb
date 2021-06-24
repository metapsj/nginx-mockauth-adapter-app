module Routes

  class Auth < Cuba
    define do

      on ":provider" do |provider|
        # GET /auth/:provider > 200 || 401
        # this must be POST when using OmniAuth
        on root do
          log.info("GET /auth/:provider")

          res.redirect(auth_mockauth_callback_url)
        end

        # GET /auth/:provider/callback > 302 || 403
        on "callback" do
          log.info("GET /auth/:provider/callback")

          res.redirect(adapter.callback)
        end
      end

    end
  end

end

