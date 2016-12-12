class Track < ActiveRecord::Base
    has_many :data
    has_attached_file :gpx
    do_not_validate_attachment_file_type :gpx

end
