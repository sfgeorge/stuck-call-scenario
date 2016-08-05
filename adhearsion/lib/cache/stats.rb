module Cache
  module Stats
    class << self
      @@monitor = nil

      def startup
        logger.info "Starting up Cache::Stats::Monitor"
        new_supervisor = Monitor.run!
        new_supervisor.monitor_call_tracking
        @@monitor = new_supervisor
      end

      def shutdown
        logger.info "Shutting down Cache::Stats::Monitor"
        @@monitor.terminate
      end
    end
  end
end
