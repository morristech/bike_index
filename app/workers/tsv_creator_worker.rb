class TsvCreatorWorker
  include Sidekiq::Worker
  require 'tsv_creator'
  require 'tsv_maintainer'
  sidekiq_options queue: 'updates'
  sidekiq_options backtrace: true
    
  def perform(tsv_method, true_and_false=false)
    creator = TsvCreator.new
    if true_and_false
      creator.send(tsv_method, true) 
      creator.send(tsv_method, false) 
    else
      creator.send(tsv_method)
    end
  end

end