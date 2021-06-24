module Helpers
  module Auth

    TEN_MINUTES = 10*60
    TWENTY_MINUTES = 20*60
    TWENTY_FOUR_HOURS = 60*60*24

    # AUTHENTICATION
    def authenticate(username, password)
      return false unless username == password
      now = Time.now
      user = {
        session_id: SecureRandom.uuid,
        user_id: SecureRandom.uuid,       # x-ngx-omniauth-user
        name: username,
        role: 'role',
        provider: 'provider',             # x-ngx-omniauth-provider
        info: 'info',                     # ['x-ngx-omniauth-info'].pack('m*')
        authenticated_at: now,
        expires_at: now + TWENTY_MINUTES,
        updated_at: now
      }
      session[:user] = user
      true
    end

    def current_user
      session[:user]
    end

    def current_role
      current_user[:role] if current_user
    end

    def authenticated_at
      current_user[:authenticated_at] if current_user
    end

    def expires_at
      current_user[:expires_at] if current_user
    end

    def expired?
      Time.now > expires_at unless expires_at.nil?
    end

    def authenticated?
      # current_user && !expired?
      current_user
    end

    def touch_current_user
      now = Time.now
      current_user[:expires_at] = now + TWENTY_MINUTES
      current_user[:updated_at] = now
    end

    # AUTHORIZATION
    def authorize(role)
      true
    end

    def authorized?
      current_role
    end

    def authorized_at
      # TODO:
    end

    #
    # ROUTE HELPERS
    #
    def auth_mockauth_callback_path
      "auth/mockauth/callback"
    end

    def auth_mockauth_callback_url
      "#{adapter.host}/#{auth_mockauth_callback_path}"
    end

    def auth_mockauth_path
      "auth/mockauth"
    end

    def auth_mockauth_url
      "#{adapter.host}/#{auth_mockauth_path}"
    end

  end
end
