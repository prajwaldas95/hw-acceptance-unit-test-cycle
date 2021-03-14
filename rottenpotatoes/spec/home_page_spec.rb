require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  scenario "Visiting the home page" do
    visit "/"
    expect(page).to have_title "Rotten Potatoes!" 
  end
end
describe 'Show index page when filter is set',:type => :feature do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas',rating:'PG') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott',rating:'PG') }
    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
  it 'filter is set' do
    visit "/movies?utf8=%E2%9C%93&ratings%5BPG%5D=1&click_button=1&commit=Refresh"
    expect(page).to have_content("Star Wars")
  end
end
describe 'Show index page when filter and rating is set',:type => :feature do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas',rating:'PG') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott',rating:'PG') }
    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
  it 'filter is set' do
    visit "/movies?ratings%5BPG%5D=1&sort_by=title"
    index1=page.body.index('Star Wars')
    index2=page.body.index('Alien')
    expect(index1>index2).to eq true
   # expect(page).to have_content("Star Wars")
  end
 end
  describe 'Show index page when no filter or rating is set',:type => :feature do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas',rating:'PG') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott',rating:'PG') }
    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
  it 'filter is set' do
    visit "/movies?click_button=1&commit=Refresh"
    bool=true
    index1=page.body.index('Star Wars')
    index2=page.body.index('Alien')
    index3=page.body.index('Blade Runner')
    index4=page.body.index('THX-1138')
    bool=true
    if (index1==nil or index2==nil or index3==nil or index4==nil)
      bool=false
    end
    expect(bool).to   eq(true)
  end

end