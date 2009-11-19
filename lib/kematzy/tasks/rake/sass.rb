


namespace :sass do 
  
  namespace :page do
    
    desc "Create a NEW Sass page and include it in the loads"
    task :new, [:page] do |t, args|
      unless args.page
        msg = %Q[\nERROR:\n\n  You must define the :page variable like this:\n]
        msg << %Q[  rake sass:page:new page=admin:news \n\n]
        puts msg
      else
        app, page_name = args.page.split(':')
        # puts "args.page = [#{args.page.inspect}] and app=[#{app}], page_name=[#{page_name}]"
        
        sass_code = %Q[\n// \n=app-page-#{page_name}\n]
        sass_code << %Q[  /* #{page_name.upcase} PAGE OVERRIDES ----------------------\n]
        sass_code << %Q[  ##{page_name} \n]
        sass_code << %Q[    #main-content \n]
        sass_code << %Q[      /* should be defined \n]
        sass_code << %Q[        \n]
        sass_code << %Q[  /* /#{page_name.upcase} PAGE -------------------------------\n  \n]
        
        # add the sass_code to the sass page
        # sh %Q[echo "#{sass_code}" > apps/#{app}/sass/pages/#{page_name}.sass]
        `echo "#{sass_code}" > apps/#{app}/sass/pages/#{page_name}.sass`
        # now add the loader
        #  FIXME:: Need to look for loader and only add if NOT found 
        `echo "@import pages/#{page_name}.sass" >> apps/#{app}/sass/_pages.sass`
        puts "\n  Created Sass page [ apps/#{app}/sass/pages/#{page_name}.sass ]\n\n"
      end
    end
    
  end #/ namespace page
  
end #/ namespace sass

