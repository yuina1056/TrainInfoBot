RSpec.describe 'TrainInfo_Post' do
  before do
    @TrainName = ""
    @TrainCompany = ""
    @trainInfo_Post = TrainInfo_Post.new
  end
  it 'trainInfo_Post get_json' do
      @trainInfo_Post.get_json()
  end
  it 'json_judge' do
    @trainInfo_Post.json_judge(@TrainName,@TrainCompany)
  end
end