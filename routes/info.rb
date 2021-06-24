module Routes
  class Info < Cuba
    define do

      on root do
        log.info("GET /info")

        res.text(info)
      end

    end
  end
end
