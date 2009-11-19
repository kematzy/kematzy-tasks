

namespace :passenger do
  
  desc "Initialize tmp/restart"
  task :init => ['passenger:restart']
  
  desc "Restart Passenger (touch tmp/restart.txt)"
  task :restart do 
    sh "touch tmp/restart.txt"
  end
  
  namespace :always do
    
    desc "Turn ON always restart Passenger (touch tmp/always_restart.txt)"
    task :on do 
      sh "touch tmp/always_restart.txt"
    end
    
    desc "Turn OFF always restart Passenger (rm tmp/always_restart.txt)"
    task :off do 
      sh "rm -f tmp/always_restart.txt"
    end
    
  end #/ namespace always
  
end #/ namespace passenger

desc "Shortcut to :passenger:restart"
task :psr => ['passenger:restart']

desc "Shortcut to :passenger:always:on"
task :pson => ['passenger:always:on']

desc "Shortcut to :passenger:always:off"
task :psoff => ['passenger:always:off']
