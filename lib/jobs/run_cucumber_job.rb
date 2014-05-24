require 'pty'
require 'ansisys'

class RunCucumberJob
  
  def initialize(uri)
    @uri = uri
  end
  
  def perform

    puts "Running job"
    puts "#{@uri}"
    
    cmd = "cucumber -r #{ENV['FEATURE_PATH']} #{@uri}" 
    
                    
    begin
          PTY.spawn( cmd ) do |stdin, stdout, pid|
            begin
                            
              stdin.each { |line| 
                print line 
                terminal = AnsiSys::Terminal.new
                terminal.echo(line)
                
                if !line.include?("INFO:")
                  Pusher['test_channel'].trigger('my_event', { message: terminal.render.gsub(ENV['FEATURE_PATH'], '') })
                end
              }
            rescue Errno::EIO
              puts "Errno:EIO error, but this probably just means " +
                    "that the process has finished giving output"
            end
          end
        #rescue #PTY::ChildExited
        #  puts "The child process exited!"
        end
    
    #Requeue the job
    #Delayed::Job.enqueue RunCucumberJob.new, 0, 3.seconds.from_now
  end
  
  
  def self.queued?
    Delayed::Job.where(:handler => "--- !ruby/object:RunCucumberJob {}\n\n").count > 0
  end
end