module IntegrationHelpers

  def login_user(user = nil, options = {})
    options[:password] ||= 'secret'
    user ||= create(:user)

    visit spree.root_path
    click_link 'Login'
    fill_in 'spree_user[email]', with: user.email
    fill_in 'spree_user[password]', with: options[:password]
    click_button 'Login'
    page.should_not have_content 'Login'
  end

end
