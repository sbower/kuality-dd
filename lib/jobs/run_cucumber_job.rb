require 'pty'

class RunCucumberJob 
  def perform

    puts "Running job"
    
    cmd = "/Users/srb55/.rvm/gems/jruby-1.7.11/gems/cucumber-1.3.12/bin/cucumber -r /Users/srb55/projects/kuality-kfs-cu/features /Users/srb55/projects/kuality-kfs-cu/features/financial_processing/auxiliary_voucher.feature" 

    begin
          PTY.spawn( cmd ) do |stdin, stdout, pid|
            begin
                            
              stdin.each { |line| 
                print line 
                Pusher['test_channel'].trigger('my_event', { message: line})
              }
            rescue Errno::EIO
              puts "Errno:EIO error, but this probably just means " +
                    "that the process has finished giving output"
            end
          end
        rescue PTY::ChildExited
          puts "The child process exited!"
        end
    
    #Requeue the job
    #Delayed::Job.enqueue RunCucumberJob.new, 0, 3.seconds.from_now
  end
  
  
  def self.queued?
    Delayed::Job.where(:handler => "--- !ruby/object:ParseFeaturesJob {}\n\n").count > 0
  end
end