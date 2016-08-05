# encoding: utf-8

Adhearsion::Events.draw do

  after_initialized do
    logger.info 'Simon App initialized!'

    Cache::Stats.startup
  end

  shutdown do
    Cache::Stats.shutdown
  end

end
