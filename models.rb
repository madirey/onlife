class Player < ActiveRecord::Base
end

class PlayerYear < ActiveRecord::Base
  belongs_to :player
end
