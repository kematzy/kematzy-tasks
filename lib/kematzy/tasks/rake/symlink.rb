
namespace :symlink do
  
  desc "Symlink all shared directories to public"
  task :shared, [:dirs] do |t, args|
    unless args.dirs
      msg = %Q[\nERROR:\n\n  You must define the :dirs variable like this:\n]
      msg << %Q[  rake symlink:shared dirs="assets, downloads, images, photos, movies, system, uploads,..." \n\n]
      puts msg
    else
      PROJECT_ROOT = File.expand_path(Dir.pwd)
      args.dirs.split(',').each do |dir|
        dir = dir.strip
        `ln -s #{File.join(File.dirname(PROJECT_ROOT), 'shared', dir)} #{File.join(PROJECT_ROOT, 'public', dir)}`
        puts "symlinked  '../shared/#{dir}' => 'current/public/#{dir}'"
      end
    end
  end
  
end #/ namespace symlink
