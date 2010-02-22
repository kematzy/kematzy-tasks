

module Kematzy
  
  module Tasks
    VERSION = '0.1.0'
    def self.version
      "Kematzy::Tasks v#{VERSION}"
    end
    
    module Rake
      module DB
        
        #
        # TODO: add some comments here
        #  
        # ==== Examples
        # 
        # 
        # @api private
        def self.dump_all_dbs_and_wrap_dumps_with_comments(dump_dir = :backups) 
          # ensure we have that directory to dump into first
          FileUtils.mkdir_p("db/#{dump_dir.to_s}")
          
          Dir["db/*.db"].each do |db|
            if dump_dir == :bootstraps
              backup_file = "db/#{dump_dir}/#{File.basename(db)}.sql"
            else
              backup_file = "db/#{dump_dir}/#{Time.now.strftime("%Y%m%d-%H%M%S")}-#{File.basename(db)}.sql"
            end
            
            comment = %Q['-- ++++ ]
            if dump_dir == :bootstraps
              comment << %Q[\n-- BOOTSTRAP FILE FOR DB [ #{File.basename(db)} ] ]
            else
              comment << %Q[\n-- BACKUP OF DB [ #{File.basename(db)} ] ]
            end
            comment << %Q[\n-- IN APP [ #{Dir.pwd} ] ]
            comment << %Q[\n-- Created on [ #{Time.now.strftime("%Y-%m-%d at %H:%M:%S")} ] ]
            comment << %Q[\n-- ]
            comment << %Q[\n-- /++++ \n']
            
            `echo #{comment} > #{backup_file}`
            sh "sqlite3 #{db} .dump >> #{backup_file}"
            `echo '\n-- \n-- /EOF \n-- ' >> #{backup_file}`
          end
          
        end
        
      end #/module DB
      
    end #/module Rake
    
  end #/module Tasks
  
end #/module Kematzy
