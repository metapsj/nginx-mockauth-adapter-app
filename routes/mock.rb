module Routes

  class Mock < Cuba
    define do

      # deprecate root, only for verification purposes
      on root do
        log.info("GET /mock")

        res.text("GET /mock")
      end

    end
  end

end
