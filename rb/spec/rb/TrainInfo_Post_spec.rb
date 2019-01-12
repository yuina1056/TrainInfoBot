RSpec.describe 'TrainInfo_Post' do
  before do
    @trainInfo_Post = TrainInfo_Post.new
  end
  it 'trainInfo_Post get_json' do
      @trainInfo_Post.get_json()
  end
  it 'slack_post' do
      @TrainInfo_Post.slack_post()
  end
end