require 'rails_helper'
 describe MoviesController do


  describe 'When we send GET request to index' do
    let!(:movie) {FactoryGirl.create(:movie)}

    it 'Should go to homepage' do
      get :index
      expect(response).to render_template('index')
    end
    it 'sort functionality should work when sorted by title' do
      get :index, { sort_by: 'title'}
      expect(assigns(:title_header)).to eql('sorttitle')
    end
    it 'sort functionality should work when sorted by date' do
      get :index, { sort_by: 'release_date'}
      expect(assigns(:date_header)).to eql('sortdate')
    end
  end

#  describe 'Show index page when filter is set' do
#    let!(:movie1) { FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas',rating:'PG') }
#    let!(:movie2) { FactoryGirl.create(:movie, title: 'Blade Runner', director: 'Ridley Scott') }
#    let!(:movie3) { FactoryGirl.create(:movie, title: 'Alien', director: 'Ridley Scott',rating:'PG') }
#    let!(:movie4) { FactoryGirl.create(:movie, title: 'THX-1138') }
#  it 'filter is set' do
#    get :index,{ ratings: {'PG'=>'1'}}
#    expect(page).have_content('Star Wars').is eql(true)
#  end
#end

  describe 'Same director movies' do
     it 'should return Movie.similar_movies' do
      expect(Movie).to receive(:director_movies).with('Star Wars')
      get :search, { title: 'Star Wars' }
    end
     it 'If director exists then return similar movies' do
      movies = ['Blade Runner', 'Star Wars']
      Movie.stub(:director_movies).with('Star Wars').and_return(movies)
      get :search, { title: 'Star Wars' }
      expect(assigns(:director_movies)).to eql(movies)
    end
     it "If director is not known then should go to home page" do
      Movie.stub(:director_movies).with('None').and_return(nil)
      get :search, { title: 'None' }
      expect(response).to redirect_to(root_url) 
    end
  end
  describe 'for updates run PUT request' do
    let(:movie1) { FactoryGirl.create(:movie) }
    before(:each) do
      put :update, id: movie1.id, movie: FactoryGirl.attributes_for(:movie, title: 'Modified')
    end

    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Modified')
    end

    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1))
    end
  end
  
  describe 'GET #edit' do
    let!(:movie) { FactoryGirl.create(:movie) }
    before do
      get :edit, id: movie.id
    end

    it 'should find the movie' do
      expect(assigns(:movie)).to eql(movie)
    end

    it 'should render the edit template' do
      expect(response).to render_template('edit')
    end
  end
  
  
  describe 'Movie should be Deleted' do
    let!(:movie1) { FactoryGirl.create(:movie) }

    it 'delete a movie' do
      expect { delete :destroy, id: movie1.id
      }.to change(Movie, :count).by(-1)
    end

    it 'should go to homepage after delete is done' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end
  
  describe 'new template GET request' do
    let!(:movie) { Movie.new }

    it 'new template should show up' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST to create a new movie' do
    it 'New movie would be created' do
      expect {post :create, movie: FactoryGirl.attributes_for(:movie)
      }.to change { Movie.count }.by(1)
    end

    it 'redirects to the movie index page' do
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to(movies_url)
    end
  end

  describe 'show movies GET request' do
    let!(:movie) { FactoryGirl.create(:movie) }
    before(:each) do
      get :show, id: movie.id
    end

    it 'That moview should show up' do
      expect(assigns(:movie)).to eql(movie)
    end

    it 'should render the show template' do
      expect(response).to render_template('show')
    end
  end


end