require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do
    visit '/television_shows'
    click_link ("Add New Show")
    fill_in "Title", with: "Grey's Anatomy"
    fill_in "Network", with: "ABC"
    fill_in "Starting Year", with: 2004
    fill_in "Ending Year", with: 2016
    select('Drama', :from => 'Genre')
    fill_in "Synopsis", with: "Focuses on a group of surgeons with main character being Meredith Grey"
    click_button ("Add TV Show")
    click_on ('Grey\'s Anatomy (ABC)')
    expect(page).to have_content("ABC")
    expect(page).to have_content("Grey's Anatomy")
    expect(page).to have_content("2004")
    expect(page).to have_content("2016")
    expect(page).to have_content("Drama")
    expect(page).to have_content("Focuses on a group of surgeons with main character being Meredith Grey")
  end

  scenario "fail to add a show with invalid information" do
    visit '/television_shows/new'
    fill_in "Title", with: "Friends"
    fill_in "Network", with: ""
    click_button ("Add TV Show")
    expect(page).to have_content("Add Show")
  end

end
