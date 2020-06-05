require 'rails_helper'

describe Good do
  describe '#create' do
    it "コメントが入力されていれば保存できる" do
      expect(build(:comment)).to be_valid
    end

    it "コメントが入力されていなければ保存できない" do
      comment = build(:comment, comment: nil)
      comment.valid?
      expect(comment.errors[:comment]).to include("を入力してください")
    end

    it "user_idがなければ保存できない" do
      comment = build(:comment, user_id: nil)
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

    it "good_idがなければ保存できない" do
      comment = build(:comment, good_id: nil)
      comment.valid?
      expect(comment.errors[:good]).to include("を入力してください")
    end
  end
end