require 'pry'
require 'pry_debug'



def class? file
  info __method__ , file
  contents = file_to_string(file).squeeze(' ')
  contents.include?(camelize(file.chomp('.rb'))) && contents.include?('ActiveRecord')
end

def camelize name
  info __method__ , name
  name.chomp('.rb.').split('_').collect!{ |w| w.capitalize }.join
end

def file_to_string file
  info __method__ , file
  File.open(file, 'r').inject{ |str='',x| str << x}
end

def create_observer class_name
  info __method__ , class_name
  file_name = class_name + '_observer.rb'
  if File.exists?(file_name) == false
    File.open(file_name, File::WRONLY|File::CREAT|File::EXCL) do |file|
      file.write "require './lib/custom/active_audit.rb'\nclass #{camelize(class_name) + 'Observer'} < ActiveRecord::Observer\n  include ActiveAudit\nend"
    end
  end
end

def ruby_source? file
  info __method__ , file
  file.end_with? ".rb" 
end

def not_observer_class? file
  info __method__ , file
  !file.end_with? "Observer.rb" 
end

def info  method, text  
  #puts "#{method}  #{text}"
end

Dir.chdir("app/models")

Dir.entries(".").
  select{ |file1| ruby_source?(file1)                  }.
  select{ |file2| class?(file2)                        }.
  select{ |file3| not_observer_class?(file3)           }.
  each  { |file4| create_observer(file4.chomp(".rb"))  }

