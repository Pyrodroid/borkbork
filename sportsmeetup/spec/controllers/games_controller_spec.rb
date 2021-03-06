require 'rails_helper'
require 'spec_helper'

RSpec.describe GamesController, type: :controller do
  
describe 'signing up' do
let(:game) { FactoryGirl.create(:game) }

describe "PUT #update" do

  before(:each) {
    Game.stub(:find).returns(game)
  }
=begin
  it "should redirect to the game path on succesful save" do
    game.should_receive(:update_attributes).and_return true
    put :update, game, {}
    response.should redirect_to(edit_game_path(game))
  end

  it "should render the edit screen again with errors if the model doesn't save" do
    game.should_receive(:update_attributes).and_return false
    put :update, game, {}
    response.should render_template("edit")
  end
=end
end
  end
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  let(:game) { FactoryGirl.create(:game) }
  let(:valid_attributes) { FactoryGirl.build(:game).attributes.symbolize_keys }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  context "#edit" do
    #render_views
    it "user should be able to edit game" do
      get :edit, id: game.id
      expect(response).to render_template("edit")
    end
  end

  describe "GET #edit" do
    it "assigns the requested game as @game" do
      game = Game.create!
      get :edit, {:id => game.to_param}
      expect(assigns(:game)).to eq(game)
    end
  end
  
  context "#meet_details" do
    it "user should be able to get more info" do
      get :meet_details, id: game.id
      expect(response).to render_template("meet_details")
    end

  end

  describe "PUT update" do
      let(:game) { FactoryGirl.create(:game, title: "Old Title", max:"nan") }
      let(:bad_attributes) { FactoryGirl.build(:game, title: 'New Title', sport:'new sport', max:0, min: "not a number", sign_ups:1, password:"").attributes.symbolize_keys }
      it "does not update the requested game with invalid params" do
        put :update, {:id => game.to_param, :game => new_attributes, :commit=>'Confirm Changes'}
        expect(game.title).to eq("Old Title")
      end
      let(:new_attributes) { FactoryGirl.build(:game, title: 'New Title', sport:'new sport', sign_ups:1, password:"").attributes.symbolize_keys }
      it "updates the requested game with valid params", focus: true do
        game = Game.create!
        put :update, {:id => game.to_param, :game => new_attributes, :commit=>'Confirm Changes'}
        game.reload
        expect(assigns(:game).attributes.symbolize_keys[:game]).to eq(new_attributes[:game])
      end
      let(:new_attributes) { FactoryGirl.build(:game, title: 'New Title', sport:'new sport', sign_ups:1, password:"Password").attributes.symbolize_keys }
      it "signs up a player to a meet with a password", focus: true do
        game1 = FactoryGirl.create(:game, sign_ups:1, last_email:"good@email.com", password: "Password")
        put :update, {:id => game1.to_param, :game=>new_attributes, :commit=>'Sign Up'}
      end
       let(:new_attributes) { FactoryGirl.build(:game, last_email:"good_email", password:"").attributes.symbolize_keys }
      it "signs up a player to a meet with no password", focus: true do
        game2 = FactoryGirl.create(:game, sign_ups:1, password: "")
        put :update, {:id => game2.to_param, :game=>new_attributes, :commit=>'Sign Up'}
      end
      it "calls the signup model method", focus: true do
        game3 = FactoryGirl.create(:game, sign_ups:1, last_email:"good@email.com", password: "")
        Game.sign_up(game3, "A name", "good@email.com")
        expect(game3.sign_ups).to eq(2)
      end
      
      it "calls the backout model method", focus: true do
        game3 = FactoryGirl.create(:game, sign_ups:2, emails: "an@email.net,good@email.com,", last_email:"good@email.com", password: "")
        expect(Game).to receive(:back_out)
        put :update, {:id => game3.to_param, :game=>new_attributes, :commit=>'Back Out'}
      end
end    
describe "PUT update/:id" do
  let(:attr) do 
    { :title => 'new title', :min => '1' }
  end

  before(:each) do
    put :update, :id => @game.id, :game => attr
    @game.reload
  end
end
    describe "verify correct password" do
      let(:new_attributes) { FactoryGirl.build(:game, onestring: 'Password').attributes.symbolize_keys }
      
      it "updates the requiested game", focus: true do
        game = Game.create! valid_attributes
        #put :update, {:id=> game.to_param, :game =>new_attributes, :commit=>"Confirm Changes"}
        put :update, {:id=> game.to_param, :game =>new_attributes, :commit=>"Sign Up"}
        game.reload
        expect(assigns(:game).attributes.symbolize_keys[:game]).to eq(new_attributes[:game])
        expect(game.sign_ups).to eq(4)
      end
    end 
     
    describe "reject incorrect password" do
      let(:new_attributes) { FactoryGirl.build(:game, onestring: 'a').attributes.symbolize_keys }
      
      it "does not add to the signups", focus: true do
        game = Game.create! valid_attributes
        put :update, {:id=> game.to_param, :game =>new_attributes}
        game.reload
        expect(assigns(:game).attributes.symbolize_keys[:game]).to eq(new_attributes[:game])
        expect(game.sign_ups).to eq(3)
      end
    end 

  
  describe 'DELETE #destroy' do
    it "deletes the game" do
      game = FactoryGirl.create(:game)
      expect{delete :destroy, :id => game}.to change(Game, :count).by(-1)
    end
end   
  

  describe "GET #show" do
    it "assigns the requested game to @game"
    it "renders the :show template"
  end
 
  describe "POST #create" do
    context "with valid attributes" do
    let(:new_attributes) { FactoryGirl.build(:game, onestring: 'password').attributes.symbolize_keys }
      it "saves the new game in the database" do
        post :create, {:id => game.to_param, :game => new_attributes}
      end
      it "redirects to the success page"
    end
  end
    context "with invalid attributes" do
      it "does not save the new game in the database"
      it "re-renders the :new template"
    end

end
