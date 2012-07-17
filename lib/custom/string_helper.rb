class StringHelper

	def self.is_integer?(param)
    true if Integer(param.to_s.gsub(/"/,'')) rescue false
	end

end
