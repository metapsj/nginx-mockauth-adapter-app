module Routes

  class Yello < Cuba
    define do

      on root do
        log.info("GET /yello")

        test = req.params['test']

        res.text(<<~EOS)
          GET /yello

          test:
          #{test}
        EOS
      end

      on "protected" do
        log.info("GET /yello/protected")

        # halt unless logged_in?
        res.text(<<~EOS)
          GET /yello/protected

          Provider: #{req.env['HTTP_X_NGX_OMNIAUTH_PROVIDER']}
          User: #{req.env['HTTP_X_NGX_OMNIAUTH_USER']}
          Info: #{req.env['HTTP_X_NGX_OMNIAUTH_INFO'].unpack('m*')}
        EOS
      end

    end
  end

end
