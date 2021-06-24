module Helpers
  module Adapter
    #
    # Macro
    #
    def adapter
      @adapter ||= Macro::Helper.new(req)
    end

    module Macro
      class Helper
        attr_reader :req

        def initialize(req)
          @req = req
        end

        def config
          # adapter_host = adapter_config[:host] || ENV['NGX_OMNIAUTH_HOST']
          {host: 'http://localhost:5000'}
        end

        def host
          config[:host]
        end

        def flow_id
          session[:flow_id] ||= SecureRandom.uuid
        end

        def back_to
          _back_to = header[:back_to] || params[:back_to]
          session[:back_to] ||= _back_to
        end

        def callback
          _callback = header[:callback] || params[:callback]
          session[:callback] ||= _callback
        end

        # back_to and callback initialized
        def ready?
          back_to_present? && callback_present?
        end

        private

        def session
          req.env['rack.session']
        end

        def header
          {
            # host: 'http://localhost:5000',
            back_to: req.env['HTTP_X_NGX_OMNIAUTH_INITIATE_BACK_TO'],
            callback: req.env['HTTP_X_NGX_OMNIAUTH_INITIATE_CALLBACK']
          }
        end

        def params
          {
            back_to: req.params['back_to'],
            callback: req.params['callback']
          }
        end

        def back_to_present?
          !(back_to.nil? || back_to.empty?)
        end

        def callback_present?
          !(callback.nil? || callback.empty?)
        end
      end
    end

    #
    # ROUTES
    #
    def adapter_test_path
      'adapter/test'
    end

    def adapter_test_url
      adapter_test_path
    end

    def adapter_initiate_path
      'adapter/initiate'
    end

    def adapter_initiate_url
      "#{adapter.host}/#{adapter_initiate_path}"
    end

    def adapter_auth_path
      'adapter/auth'
    end

    def adapter_auth_url
      "#{adapter.host}/#{adapter_auth_path}"
    end

    def adapter_auth_url_with_callback
      back_to = encode(adapter.back_to)
      callback = encode(adapter.callback)
      "#{adapter_auth_url}?back_to=#{back_to}&callback=#{callback}"
    end

    def adapter_callback_path
      'adapter/callback'
    end

    def adapter_callback_url
      "#{adapter.host}/#{adapter_callback_path}"
    end

    def adapter_logout_path
      'adapter/logout'
    end

    def adapter_logout_url
      "#{adapter.host}/#{adapter_logout_path}"
    end

  end
end
