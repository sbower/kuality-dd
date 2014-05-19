class FeaturesController < InheritedResources::Base
  def run
    Delayed::Job.enqueue RunCucumberJob.new, 0, 3.seconds.from_now
  end
end
