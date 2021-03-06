require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "City, State"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end

  test 'Destroy' do
    visit companies_path

    companies_count = find('.list-group').all('li').size
    first('.list-group li a.btn-danger').click

    page.driver.browser.switch_to.alert.accept

    assert_text 'The company has been destroyed successfully.'
    assert_equal find('.list-group').all('li').size, (companies_count - 1)
  end

  test 'Set City and State' do
    visit edit_company_path(@company)

    within('form#company-form') do
      fill_in('company_zip_code', with: '384151', fill_options: { clear: :backspace })
      click_button 'Update Company'
    end

    @company.reload
    assert_equal 'Siddhpur',    @company.city
    assert_equal 'Gujarat', @company.state
  end

  test 'Set Brand Color' do
    visit edit_company_path(@company)

    within('form#company-form') do
      fill_in('company_brand_color', with: '#000000', fill_options: { clear: :backspace })
      click_button 'Update Company'
    end

    @company.reload
    assert_equal '#000000', @company.brand_color
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

end
