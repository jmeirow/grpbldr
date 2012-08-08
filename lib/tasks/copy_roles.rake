namespace  :db do

  task :copy_roles => :environment do

    accessible = [:description, :assignable,   :minimum_required_experience, :meetings_to_skip_before_assigning_again]


    Role.where("club_id = ?", 6).each do |role|
      new_role = Role.new
      new_role.club_id = 10
      role.attributes.each do |name, value|
        if accessible.include? name.to_sym
          if name == 'description'
            new_role.description = value.to_s
          else
            new_role.attributes[name.to_sym] = value
          end
        end
      end
      x = new_role.save
      if x == false 
        puts errors[:description]
      end

    end

  end
end
