module Cache
  module Stats
    class Reporter
      include Celluloid

      def track_calls
        logger.info "Adhearsion active call count: #{Adhearsion.active_calls.size}"
      end

    end
  end
end
