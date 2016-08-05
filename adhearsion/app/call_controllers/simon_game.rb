# encoding: utf-8

class SimonGame < Adhearsion::CallController

  attr_accessor :number, :attempt

  def run
    logger.info 'App CallController: entered'
    answer
    logger.info 'App CallController: answered'
    hangup
    logger.info 'App CallController: hungup'
  end

end
