class Admin::OptionValuesController < Admin::BaseController
  resource_controller
  belongs_to :option_types # what does this do?
end
