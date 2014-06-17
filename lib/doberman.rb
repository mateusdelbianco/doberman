require "doberman/version"

module Doberman
  class WatchDog
    class Timeout < StandardError; end

    attr_reader :error_message, :timeout

    def initialize(options = {})
      @error_message = options[:error_message] || "WatchDog timeout reached"
      @timeout = options[:timeout] || 60
      @resolution = options[:resolution] || 0.1
      @current = Thread.current
    end

    def start
      if @watchdog.nil?
        reset_ttl
        create_thread
      end
    end

    def ping
      if @watchdog.nil?
        start
      else
        @reset = true
      end
    end

    def stop
      kill_thread
    end

    private

    def create_thread
      @watchdog = Thread.new do
        while @ttl > 0
          sleep @resolution
          if @reset
            reset_ttl
          else
            @ttl -= @resolution
          end
        end
        @current.raise Timeout.new(@error_message)
      end
    end

    def reset_ttl
      @ttl = timeout.to_f
      @reset = false
    end

    def kill_thread
      unless @watchdog.nil?
        @watchdog.kill
        @watchdog = nil
      end
    end
  end
end
