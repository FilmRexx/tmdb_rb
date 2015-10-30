require "spec_helper"

# Genre Spec
describe TmdbRexx::Client do
  initialize_client

  let(:tmdb_rexx) { TmdbRexx::Client.new }

  describe "invalid type" do
    it { expect{ tmdb_rexx.genres("invalid") }.to raise_error(TmdbRexx::InvalidTypeError) }
  end

  describe ".genres", :vcr do
    context "type movies" do
      let(:resource) { tmdb_rexx.genres.first }
      it { expect(resource).to have_key("id") }
      it { expect(resource).to have_key("name") }
    end

    context "type tv" do
      let(:resource) { tmdb_rexx.genres("tv").first }
      it { expect(resource).to have_key("id") }
      it { expect(resource).to have_key("name") }
    end
  end

  describe ".genre_movies", :vcr do
    let(:resource) { tmdb_rexx.genre_movies("genre-id") }
    it { expect(resource).to have_key("id") }
    it { expect(resource).to have_key("page") }
    it { expect(resource).to have_key("results") }
    it { expect(resource).to have_key("total_pages") }
    it { expect(resource).to have_key("total_results") }

    context '["results"]' do
      let(:resource) { tmdb_rexx.genre_movies("genre-id")["results"].first }
      it { expect(resource).to have_key("backdrop_path") }
      it { expect(resource).to have_key("id") }
      it { expect(resource).to have_key("original_title") }
      it { expect(resource).to have_key("release_date") }
      it { expect(resource).to have_key("poster_path") }
      it { expect(resource).to have_key("title") }
      it { expect(resource).to have_key("vote_average") }
      it { expect(resource).to have_key("vote_count") }
    end
  end
end
