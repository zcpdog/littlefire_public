class Report < ActiveRecord::Base
  belongs_to  :deal
  belongs_to  :report_type
end
