

class SelectList
  attr_reader :id, :text 
  def initialize id, text
    @id = id
    @text = text
  end
end

class SelectLists

  attr_accessor :meeting_type_select_list, :member_select_list,   :role_select_list

  def initialize cache, meeting_type
    @cache = cache 
    @member_select_list = cache.current_members
    @role_select_list = build_role_select_list
    @meeting_type_select_list = @cache.meeting_types

  end

private

  def member_of_group? role_id
    @cache.role_group_associations.map {|x| x.role_id }.include? role_id
  end

  def get_group_name role_group_id
    @cache.role_groups.find {|x| x.id == role_group_id }.description
  end

  def build_role_select_list
    
    selects = Array.new 
    
    @cache.roles.
      select {|x| !member_of_group? x.id }.
      each   {|x| selects << SelectList.new(x.id, x.description)}

    @cache.role_group_associations.
      select {|x| member_of_group? x.role_id }.
      each   {|x| selects << SelectList.new(x.role_group_id*-1, get_group_name(x.role_group_id))  if (selects.find{|y| y.id == (x.role_group_id*-1) }.nil?)   } 

    selects.sort_by(&:text)
    
  end
end
