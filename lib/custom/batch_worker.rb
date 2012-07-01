
require 'iron_worker'
require 'open-uri'



class BatchWorker  < IronWorker::Base

  attr_accessor :x 

  def initialize
    IronWorker.configure do |config|     
      config.token = ENV['IRON_WORKER_TOKEN']
      config.project_id = ENV['IRON_WORKER_PROJECT_ID']
    end

  end 

  def configure(target)
    @target = target
  end

  def run
    x=0
    open(@target) do |f|
    end
  end

  
end
