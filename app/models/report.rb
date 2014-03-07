class Report < ActiveRecord::Base
  belongs_to  :reportable, polymorphic: true
  validates   :ip, uniqueness: {scope: [ :reportable_type, :reportable_id ]}
end
