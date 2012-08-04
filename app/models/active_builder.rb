module ActiveBuilder


  def gb_set_attribute_methods_from_attributes
    attributes.each do |name, value|
        send("#{name}=", value)
    end
  end

  
end
