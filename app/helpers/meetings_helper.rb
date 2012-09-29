
module MeetingsHelper
  def meeting_type_info_js
    result = "var meeting_types = {};\n"
    @meeting_types.each do |type|
      result = result + "  meeting_types[" + type.id.to_s + "] = [  " +   ("%02d" % type.hour) +   " , " + ("%02d" % type.minute)  + " ," +  type.am_pm + " ];\n"
    end
    result
  end
end
