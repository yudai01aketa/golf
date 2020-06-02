require 'rails_helper'

RSpec.describe Course, type: :model do
  let!(:course_yesterday) { create(:course, :yesterday) }
  let!(:course_one_week_ago) { create(:course, :one_week_ago) }
  let!(:course_one_month_ago) { create(:course, :one_month_ago) }
  let!(:course) { create(:course) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(course).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      course = build(:course, name: nil)
      course.valid?
      expect(course.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      course = build(:course, name: "あ" * 31)
      course.valid?
      expect(course.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      course = build(:course, description: "あ" * 141)
      course.valid?
      expect(course.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "コツ・ポイントが50文字以内であること" do
      course = build(:course, tips: "あ" * 51)
      course.valid?
      expect(course.errors[:tips]).to include("は50文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      course = build(:course, user_id: nil)
      course.valid?
      expect(course.errors[:user_id]).to include("を入力してください")
    end

    it "人気度が1以上でなければ無効な状態であること" do
      course = build(:course, recommend: 0)
      course.valid?
      expect(course.errors[:recommend]).to include("は1以上の値にしてください")
    end

    it "人気度が5以下でなければ無効な状態であること" do
      course = build(:course, recommend: 6)
      course.valid?
      expect(course.errors[:recommend]).to include("は5以下の値にしてください")
    end
  end
end
