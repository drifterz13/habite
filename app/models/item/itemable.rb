module Item::Itemable
  extend ActiveSupport::Concern

  included do
    has_one :item, as: :itemable, touch: true
  end
end
