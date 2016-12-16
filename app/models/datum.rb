class Datum < ActiveRecord::Base
    belongs_to :track
    has_many :marks

end
