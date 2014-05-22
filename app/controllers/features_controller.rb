class FeaturesController < InheritedResources::Base
  def show
    #super
    @feature = Feature.find(params[:id])
    gon.feature_id = @feature.id
  end
  
  def run
    @feature = Feature.find(params[:id])
    Delayed::Job.enqueue RunCucumberJob.new(@feature.uri), 0, 3.seconds.from_now
  end
end
