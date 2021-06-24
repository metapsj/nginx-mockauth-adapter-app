require 'logger'

# format:
# timestamp={time}
# level={severity}
# source_class={class_name} || progname={progname}
# user_id={email}
# message={log_message}
# tag=#{tag}
module Helpers
  module Log
    extend self

    def log
      @log ||= Logger.new(log_path)
    end

    def environment
      raise NameError, 'ENVIRONMENT is not defined' unless defined?(ENVIRONMENT)
      ENVIRONMENT
    end

    def root_path
      raise NameError, 'ROOT_PATH is not defined' unless defined?(ROOT_PATH)
      ROOT_PATH
    end

    def log_folder_path
      File.join(root_path, 'log')
    end

    def log_path
      File.join(log_folder_path, "#{environment}.log")
    end

  end
end

