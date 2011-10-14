class UserGeneratedProductOptionValue < ProductOptionValue
  before_create :create_option_value
  attr_writer :option_type_id
  attr_writer :user_generated_text

  private
  def create_option_value
    # create the dynamic option value
    ov= OptionValue.create!(:option_type_id => @option_type_id, :presentation => @user_generated_text)

    # add it to our model
    self.option_value_id = ov.id
  end
end
