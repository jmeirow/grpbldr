module ActiveBuilder


  def gb_set_attribute_methods_from_attributes
    attributes.each do |name, value|
        send("#{name}=", value)
    end
  end


  def get_state
    result = Array.new
    attributes.each do |name, value|
      result << ":#{name}=>'#{value}'" if name != 'created_at' && name != 'updated_at'
    end
    "{#{result.join(',')}}"
  end




end
