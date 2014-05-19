class SearchController < ApplicationController

  def search
    q = params[:keyword]
    
    features = Feature.search(q)
    scenarios = Scenario.search(q)
    steps = Step.search(q)
    tags = Tag.search(q)

    @results = features + scenarios + steps + tags

  end

end
