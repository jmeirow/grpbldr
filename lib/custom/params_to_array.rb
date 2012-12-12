
class ParamsToArray 
  def self.do prefix, params 
    params.keys.select { |param| param.start_with? prefix }.
      collect { |matched_param| matched_param.gsub(/#{prefix}/,'').to_i }
  end
end
