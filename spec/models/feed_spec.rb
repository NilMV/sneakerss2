require 'rails_helper'



RSpec.describe Feed, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = 'TestName'
    subject.url = 'Test.url'
    subject.description = 'Test description'
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    expect(subject).to_not be_valid
  end
  it "is not valid without url" do
    subject.name = 'TestName'
    expect(subject).to_not be_valid
  end
  it "is not vali without description" do
    subject.name = 'TestName'
    subject.url = 'TestUrl'
    expect(subject).to_not be_valid
  end    
end

