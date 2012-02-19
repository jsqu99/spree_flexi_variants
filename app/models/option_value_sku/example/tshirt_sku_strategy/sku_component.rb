module OptionValueSku
  module Example
    module TshirtSkuComponent

      # represents one of the following:

      # option_value / amount
      # product_option_value / amount

      class SkuComponent < ActiveRecord::Base
        set_table_name 'tshirt_sku_components'

        belongs_to :strategy, :class_name => 'OptionValueSku::Example::TshirtSkuStrategy::Strategy'
        belongs_to :option_value, :polymorphic => true
      end
    end
  end
end
