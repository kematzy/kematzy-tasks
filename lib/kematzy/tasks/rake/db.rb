require "kematzy/tasks"

namespace :db do 
  
  desc "Backup database to .tar.gz file (=> db:backup:db)"
  task :backup  => ['db:backup:db']
  
  desc "Backups DBs into .sql files (=> db:backup:sql)"
  task :backups => ['db:backup:sql']
  
  namespace :backup do 
    
    desc "Backups DBs into .sql file"
    task :sql => ['db:dump']
    
    desc "Backups DB .db file and compresses it"
    task :db, [:db] do |t, args| 
      unless args.db
        puts %Q[\nERROR:\n\n  You must define the DB variable like this:\n  rake db:backup:db db=db/name-of-database.db\n\n]
      else
        db_name = args.db.sub(/^db\//,'')
        `cd db/ && tar zcf ../db/backups/#{Time.now.strftime("%Y%m%d-%H%M%S")}-#{db_name}.tar.gz #{db_name} `
        puts "\n-- created a compressed backup version of [ #{args.db} ]\n\n"
      end
    end
    
  end #/namespace :backup
  
  
  desc "Bootstrap database with .sql files (db=db/name.db)"
  task :bootstrap, [:db] do |t, args| 
    # To put the data into a SQLite database from a sql file use:
    # sqlite database < database.sql
    unless args.db
      msg = %Q[\nERROR:\n\n  You must define the :db variable like this:\n]
      msg << %Q[  rake db:bootstrap db=db/name-of-database.db\n\n]
      puts msg
    else
      sh "sqlite3 #{args.db} < db/bootstraps/#{args.db.sub(/^db\//,'')}.sql"
      puts "-- DB [ #{args.db}] bootstrapped with [ db/bootstraps/#{args.db.sub(/^db\//,'')}.sql ]l\n\n"
      # if test(?d, '.git/config')
      #   sh "git add db/bootstraps/#{args.db.sub(/^db\//,'')}.sql"
      #   sh %Q{git commit -m "#{Time.now.strftime("%Y-%d-%m at %H:%M:%S")} : updated DB bootstraps for #{args.db}" }
      # end
    end
    
  end
  
  namespace :bootstrap do 
    
    desc "Bootstrap NEW DB (db=db/name.db, bf=db/bootstraps/name.sql)"
    task :new, [:db, :bf] do |t, args| 
      unless args.db && args.bf
        msg = %Q[\nERROR:\n\n  You must define the DB variable like this:\n]
        msg << %Q[  rake db:bootstrap:new db=db/name-of-database.db\n]
        msg << %Q[  bf=db/bootstraps/name.sql \n\n]
        puts msg
      else
        sh "sqlite3 #{args.db} < #{args.bf}"
        puts "-- created new DB [ #{args.db} ]\n"
        puts "-- - bootstrapped with [ #{args.bf} ]\n\n"
      end
    end
    
  end #/namespace :bootstrap
  
  desc "Dump database(s) to .sql file(s)"
  task :dump do 
    # In order to dump a SQLite database you can use the following command:
    # sqlite database .dump > database.sql
    Kematzy::Tasks::Rake::DB.dump_all_dbs_and_wrap_dumps_with_comments(:backups)
    puts "-- dumped all DBs into .sql files\n\n"
  end
  
  namespace :dump do 
    
    desc "Dump current database as a bootstrap .sql file"
    task :bootstrap do 
      Kematzy::Tasks::Rake::DB.dump_all_dbs_and_wrap_dumps_with_comments(:bootstraps)
    end
    
  end #/ namespace :dump
  
  namespace :production do 
    
    desc "Convert development.db into production.db"
    task :setup do 
      # step 1: backup current production db
      db_name = 'production.db'
      `cd db/ && tar zcf ../db/backups/#{Time.now.strftime("%Y%m%d-%H%M%S")}-#{db_name}.tar.gz #{db_name} `
      puts "\n-- created a compressed backup version of [ production.db ]\n"
      
      sh "cp db/development.db db/production.db"
    end
  end #/ namespace production
  
  desc "Init DB directory structure, for use by these Rake commands"
  task :setup do 
    sh "mkdir -p db/bootstraps"
    sh "mkdir -p db/backups"
  end
  
  
end #/ namespace :db
