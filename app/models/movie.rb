class Movie < ApplicationRecord
  belongs_to :shared_by, class_name: 'User', foreign_key: :shared_by_id
end
