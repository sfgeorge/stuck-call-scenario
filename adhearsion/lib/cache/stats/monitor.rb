module Cache
  module Stats

    class Monitor < Celluloid::SupervisionGroup
      INTERVAL = 30

      def monitor_call_tracking
        logger.info 'Starting long-running stats report'
        supervise_as 'stats_reporter', Stats::Reporter
        async.send_track_calls_to_actors!
      end

      private

      def send_track_calls_to_actors!
        logger.info "Initiating Stats::Report with actors: #{actors.inspect}"
        loop do
          actors.map(&:track_calls)
          sleep INTERVAL
        end
      end
    end
  end
end
