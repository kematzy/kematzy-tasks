
namespace :symlink do
  
  desc "Symlink all shared directories to public"
  task :shared, [:dirs] do |t, args|
    unless args.dirs
      msg = %Q[\nERROR:\n\n  You must define the :dirs variable like this:\n]
      msg << %Q[  rake symlink:shared dirs=assets, downloads, images, photos, movies, system, uploads,... \n\n]
      puts msg
    else
      PROJECT_ROOT = File.dirname(File.expand_path(__FILE__))
      dirs.each do |dir|
        `ln -s #{File.join(File.dirname(PROJECT_ROOT), 'shared', dir)} #{File.join(PROJECT_ROOT, 'public', dir)}`
        puts "symlinked  '../shared/#{dir}' => 'current/public/#{dir}'"
      end
    end
  end
  
end #/ namespace symlink
# 
# namespace :symlink do
#   
#   desc "Symlink shared directories to current/public"
#   task :shared do 
#     PROJECT_ROOT = File.dirname(File.expand_path(__FILE__))
#     %w(assets downloads images photos movies system uploads).each do |dir|
#       `ln -s #{File.join(File.dirname(PROJECT_ROOT), 'shared', dir)} #{File.join(PROJECT_ROOT, 'public', dir)}`
#       puts "symlinked  '../shared/#{dir}' => 'current/public/#{dir}'"
#     end
#   end
#   
# end #/ namespace symlink
