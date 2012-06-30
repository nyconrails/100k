require 'spec_helper'

describe Post do
  describe "Associations" do
    it { should belong_to :organization }
    it { should belong_to :user }
  end

  describe "Database Columns" do
    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:organization_id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  describe "Validations" do
    it { should validate_presence_of :organization }
    it { should validate_presence_of :user}
    it { should validate_presence_of :body }
  end
end
