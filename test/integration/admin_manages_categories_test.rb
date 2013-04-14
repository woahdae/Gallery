require_relative '../minitest_helper'

class AdminManagesCategories < IntegrationTest
  let(:cycling)   { Factory.create(:category, name: 'cycling', user: admin) }
  let(:year_2012) { Factory.create(:category, name: '2012',
                                   parent: cycling,
                                   user:   admin,
                                   photos: [photo1, photo2, photo3]) }
  let(:year_2013) { Factory.create(:category, name: '2013',
                                   user:   admin,
                                   parent: cycling) }
  let(:plants)    { Factory.create(:category, name: 'plants', user: admin) }
  let(:veggies)   { Factory.create(:category, name: 'veggies',
                                   user:   admin,
                                   parent: plants) }
  let(:flowers)   { Factory.create(:category, name: 'flowers',
                                   user:   admin,
                                   parent: plants) }

  let(:photo1) { Factory.create(:photo) }
  let(:photo2) { Factory.create(:photo) }
  let(:photo3) { Factory.create(:photo) }

  let(:admin)  { Factory.create(:admin) }

  before do
    year_2012; year_2013; veggies; flowers; admin

    sign_in(admin)
    visit admin_root_path
  end

  it 'can create categories' do
    click_link 'New Category'
    fill_in 'Name', with: 'Crashes Gallore!'
    select year_2013.name, from: 'Parent'
    click_button 'Create Category'

    crashes = Category.last
    crashes.must_be(:present?)
    crashes.name.must_equal('Crashes Gallore!')
    crashes.parent.must_equal(year_2013)
  end

  it 'can drag and drop categories', js: true do
    from = find(css_id(veggies)).find('a')
    to   = find(css_id(cycling))

    # drop to the right and down to make it a subcategory
    drag_and_drop(from, to, right: 30, down: 20)

    sleep(1)
    veggies.reload.parent.must_equal(cycling)
  end
end
