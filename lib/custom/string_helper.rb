class StringHelper

	def self.is_i?(param)
    !!(param =~ /^[-+]?[1-9]([0-9]*)?$/)
  end
end
