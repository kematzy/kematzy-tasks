

desc "Copy file/dir(s) :from => :to (from=path/2/.., to=path/2/..)"
task :copy, [:from, :to] do |t, args|
  unless args.from && args.to
    msg = %Q[\nERROR:\n\n  You must define the :from, :to variable like this:\n]
    msg << %Q[  rake copy from=path/2/something/ to=path/2/something \n\n]
    msg << %Q[  NB! remember to add a trailing '/' to the end of :from \n]
    msg << %Q[  when you want to copy the contents only \n\n]
    puts msg
  else
    # do task here
    sh "mkdir -p #{args.to}" unless test(?e, "#{Dir.pwd}/#{args.to}")
    sh "cp -r #{args.from} #{args.to}"
  end
end

desc "Move file/dir(s) :from => :to (from=path/2/.., to=path/2/..)"
task :move, [:from, :to] do |t, args|
  unless args.from && args.to
    msg = %Q[\nERROR:\n\n  You must define the :from, :to variable like this:\n]
    msg << %Q[  rake move from=path/2/something/ to=path/2/something \n\n]
    msg << %Q[  NB! remember to add a trailing '/' to the end of :from \n]
    msg << %Q[  when you want to move the contents only \n\n]
    puts msg
  else
    # do task here
    sh "mkdir -p #{args.to}" unless test(?e, "#{Dir.pwd}/#{args.to}")
    sh "mv #{args.from} #{args.to}"
  end
end


namespace :create do 
  
  namespace :dir do 
    
    desc "Creates Models directory at (path=path/2/dir)"
    task :models, [:path] do |t, args| 
      unless args.path
        msg = %Q[\nERROR:\n\n  You must define the :path variable like this:\n]
        msg << %Q[  rake create:dir:models path=path/2/dir \n\n]
        puts msg
      else
        # do task here
        sh "mkdir -p #{Dir.pwd}/#{args.path}models"
      end
    end
    
    desc "Creates Helpers directory at (path=path/2/dir)"
    task :helpers, [:path] do |t, args| 
      unless args.path
        msg = %Q[\nERROR:\n\n  You must define the :path variable like this:\n]
        msg << %Q[  rake create:dir:helpers path=path/2/dir \n\n]
        puts msg
      else
        # do task here
        sh "mkdir -p #{Dir.pwd}/#{args.path}helpers"
      end
    end
    
    desc "Creates Routes directory at (path=path/2/dir)"
    task :routes, [:path] do |t, args| 
      unless args.path
        msg = %Q[\nERROR:\n\n  You must define the :path variable like this:\n]
        msg << %Q[  rake create:dir:routes path=path/2/dir \n\n]
        puts msg
      else
        # do task here
        sh "mkdir -p #{Dir.pwd}/#{args.path}routes"
      end
    end
    
    desc "Create a New directory at (path=path/2/new/dir)"
    task :new, [:path] do |t, args| 
      unless args.path
        msg = %Q[\nERROR:\n\n  You must define the :path variable like this:\n]
        msg << %Q[  rake create:dir:new path=path/2/new/dir \n\n]
        puts msg
      else
        sh "mkdir -p #{Dir.pwd}/#{args.path}"
      end
    end
    
  end # namespace :dir
  
end #/ namespace :create
