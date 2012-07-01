class SysConfiguration < ActiveRecord::Base
    attr_accessible :config_key, :config_value, :config_description
end
