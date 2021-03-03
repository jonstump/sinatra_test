
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => 'Yellow Submarine')
    click_on('Go!')
    expect(page).to have_content('Yellow Submarine')
    click_on('Yellow Submarine')
    click_on('Edit album')
    fill_in('name', :with => 'Purple Submarine')
    click_on('Update')
    expect(page).to have_content('Purple Submarine')
    click_on('Purple Submarine')
    click_on('Edit album')
    click_on('Delete album')
    expect(page).to have_no_content('Purple Submarine')
  end
end

describe('Checks that you can search for an album', {:type => :feature}) do
  it('navigates to the search page and searches for an album') do
    album = Album.new("Yellow Submarine", nil, nil, nil, nil)
    album.save
    visit("/albums")
    click_on('Search for an album')
    fill_in('search_term', :with => '')
    click_on('Go!')
    expect(page).to have_content('There are currently no records to display.')
  end
end

describe('create a song path', {:type => :feature}) do
  it('creates an album and then goes to the album page and adds a song') do
    album = Album.new("Yellow Submarine", nil, nil, nil, nil)
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    expect(page).to have_content('All You Need Is Love')
  end
end

describe('adds song name and writer to song', {:type => :feature}) do
  it('creates an album and then goes to the album page then adds songwriter and song') do
    album = Album.new("Yellow Submarine", nil, nil, nil, nil)
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'Living on a prayer')
    fill_in('song_writer', :with => 'Bon Jovi')
    fill_in('song_lyrics', :with => 'Living on a prayer!')
    click_on('Add song')
    click_on('Living on a prayer')
    expect(page).to have_content('Bon Jovi')
    expect(page).to have_content('Living on a prayer!')
    fill_in('lyrics', :with => 'We are half way there')
    click_on('Update song')
    click_on('Living on a prayer')
    expect(page).to have_content('We are half way there')
    click_on('Delete song')
    expect(page).to have_no_content('Living on a prayer')
  end
end

# describe('adds song name and writer to song', {:type => :feature}) do
#   it('creates an album and then goes to the album page then adds songwriter and song') do
#     album = Album.new("Yellow Submarine", nil, nil, nil, nil)
#     album.save
#     visit("/albums/#{album.id}")
#     fill_in('song_name', :with => 'Living on a prayer')
#     fill_in('song_writer', :with => 'Bon Jovi')
#     fill_in('song_lyrics', :with => 'Living on a prayer!')
#     click_on('Add song')
#     click_on('Living on a prayer')
#     fill_in('lyrics', :with => 'We are half way there')
#     click_on('Update song')
#     click_on('Living on a prayer')
#     expect(page).to have_content('We are half way there')
#   end
# end

# describe('adding song lyrics', {:type => :feature}) do
#   it('creates an album and then goes to the album page') do
#     album = Album.new("Yellow Submarine", nil, nil, nil, nil)
#     album.save
#     visit("/albums/#{album.id}")
#     fill_in('song_name', :with => 'Living on a prayer')
#     fill_in('song_lyrics', :with => 'Living on a prayer!')
#     click_on('Add song')
#     click_on('Living on a prayer')
#     expect(page).to have_content('Living on a prayer!')
#   end
# end