require 'spec_helper'
require 'shared_examples'

describe GameFoulsController do

  let(:valid_attributes) { FactoryGirl.attributes_for(:game_foul_caution) }
  let(:valid_model) { FactoryGirl.create(:game_foul_caution) }
  let(:valid_session) { {} }

  describe "GET 'new'" do
    context 'when send valid params' do
      before do
        @game_team_id = valid_model.player.team.id
        FactoryGirl.create_list(:game_member_player, 3, {game_team_id: @game_team_id})
        @players = GameMember.find_all_by_game_team_id(@game_team_id)
        xhr :get, :new, {game_team_id: @game_team_id}, valid_session
      end

      describe 'assigns' do
        it { should assign_to(:game_foul).with_kind_of(GameFoul) }

        it { should assign_to(:game_team_id) }
        describe :game_team_id do
          subject { assigns(:game_team_id).to_i }
          it { should === @game_team_id }
        end

        it { should assign_to(:players) }
        describe :players do
          subject { assigns(:players) }
          it { should ===  @players }
        end
      end

      it_behaves_like :valid_js_response, :new
    end

    context 'when set invalid params' do
      context 'game_team_id not exits' do
        before do
          xhr :get, :new, {game_team_id: GameTeam.maximum(:id) + 1}
        end
        it_behaves_like :redirected_to_page_not_found
      end

    end
  end

  describe "POST 'create'" do
    context 'when send valid params' do
      before do
        @send_params = attributes_for(:game_foul_caution)
        @player = GameMember.find(@send_params[:game_member_id])
        @count = GameFoul.find_all_by_game_member_id(@player.id).size
        xhr :post, :create, { game_foul: @send_params, game_team_id: @player.team.id }, valid_session
      end

      it 'record count 1 up' do
        fouls_count = GameFoul.find_all_by_game_member_id(@player.id).size
        fouls_count.should === (@count + 1)
      end

      it_behaves_like :valid_js_response, :create
    end
    context 'when send invalid params' do
      before do
        @send_params = attributes_for(:game_foul_caution)
        @player = GameMember.find(@send_params[:game_member_id])
        @game_team_id = @player.team.id
        FactoryGirl.create_list(:game_member_player, 3, {game_team_id: @game_team_id})
        @players = GameMember.find_all_by_game_team_id(@game_team_id)
        @send_params[:game_member_id] = nil
        xhr :post, :create, { game_foul: @send_params, game_team_id: @game_team_id }, valid_session
      end

      describe 'assigns' do
        it { should assign_to(:game_foul).with_kind_of(GameFoul) }

        it { should assign_to(:game_team_id) }
        describe :game_team_id do
          subject { assigns(:game_team_id).to_i }
          it { should === @game_team_id }
        end

        it { should assign_to(:players) }
        describe :players do
          subject { assigns(:players) }
          it { should ===  @players }
        end
      end

      it_behaves_like :valid_js_response, :new
    end
  end

  describe "DELETE 'destroy'" do
    context 'when send valid params' do
      before do
        @target = create(:game_foul_caution)
        @count = GameFoul.count
        xhr :delete, :destroy, {id: @target.id}, valid_session
      end

      it_behaves_like :valid_js_response, :destroy

      it "record count 1 down" do
        GameFoul.count.should == (@count - 1)
      end
    end

    context 'when send invalid params' do
      before do
        xhr :delete, :destroy, {id: (GameFoul.maximum(:id).to_i + 1)}, valid_session
      end
      describe 'reponse' do
        context 'id not exits' do
          it_behaves_like :redirected_to_page_not_found
        end
      end

    end
  end

end
