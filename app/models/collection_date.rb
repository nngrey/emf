class CollectionDate < ApplicationRecord
  belongs_to :performance_indicator, inverse_of: :collection_dates
end
