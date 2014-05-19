require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'multi_json'

class ParseFeaturesJob 
  def perform

    puts "Running job"
    
    io = StringIO.new
    formatter = Gherkin::Formatter::JSONFormatter.new(io)
    parser = Gherkin::Parser::Parser.new(formatter)
    
    sources = ["/Users/srb55/projects/kuality-kfs-cu/features/financial_processing/disbursement_voucher.feature", 
               "/Users/srb55/projects/kuality-kfs-cu/features/financial_processing/auxiliary_voucher.feature"]
    sources.each do |s|
      parser.parse(IO.read(s), s, 0)
    end
    
    formatter.done
    #puts io.string
    
    #:symbolize_keys => true
    MultiJson.load(io.string).each do |hash|
      
      puts "name: #{hash['name']}"
      json_id = hash['id']
      
      feature = Feature.where(json_id: json_id).first_or_create
      
      feature.name = hash['name']
      feature.line = hash['line']
      feature.description = hash['description']
      feature.json_id = json_id
      
      feature.save
      
      hash['elements'].each do |element|
        if element['type'].eql?("scenario") then
          update_scenario(element, feature.id)
        end
      end
      
      puts "\n\n"
    end
    
    
    #puts MultiJson.dump(MultiJson.load(io.string), :pretty => true)

    
    #Requeue the job
    #Delayed::Job.enqueue ParseFeaturesJob.new, 0, 3.seconds.from_now
  end
  
  
  def self.queued?
    Delayed::Job.where(:handler => "--- !ruby/object:ParseFeaturesJob {}\n\n").count > 0
  end
  
  private
  
  def update_scenario(scenario_hash, feature_id)
    puts "\tname: #{scenario_hash['name']}"
    json_id = scenario_hash['id'].split(";")[1]
    
    scenario = Scenario.where(json_id: json_id).first_or_create

    scenario.name = scenario_hash['name']
    scenario.line = scenario_hash['line']
    scenario.description = scenario_hash['description']
    scenario.json_id = json_id
    scenario.feature_id = feature_id
    
    scenario.save
    
    scenario_hash['tags'].each do |tag_hash|
      puts "\t\tname: #{tag_hash['name']}"
      
      tag = Tag.where(name: tag_hash['name']).first_or_create

      tag.name = tag_hash['name']      
      tag.save
      
      scenario_tag = ScenarioTag.where(scenario_id: scenario.id, tag_id: tag.id).first_or_create
      scenario_tag.save
      
    end
    
    scenario_hash['steps'].each do |step_hash|
      puts "\t\tname: #{step_hash['name']}"
      
      step = Step.where(name: step_hash['name']).first_or_create
      step.name = step_hash['name']      
      step.save
      
      scenarios_step = ScenariosStep.where(scenario_id: scenario.id, step_id: step.id).first_or_create
      scenarios_step.keyword = step_hash['keyword']
      scenarios_step.line = step_hash['line']
      scenarios_step.save
      
    end
    
  end
  
end