module Helpers
  module Info

    def info
      <<~EOS
        GET /info

        environment:
        #{ENVIRONMENT}

        root path:
        #{ROOT_PATH}

        log folder path:
        #{log_folder_path}

        cuba env:
        #{env}
      EOS
    end

  end
end
