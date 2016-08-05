# encoding: utf-8

Adhearsion.config do |config|

  config.development do |dev|
    dev.platform.logging.level = :debug
  end

  ##
  # Use with Asterisk
  #
  config.punchblock.platform = :asterisk # Use Asterisk
end
