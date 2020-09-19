module PrefecturesCreator
  def create_prefectuers
    CSV.foreach(Rails.root.join('db', 'prefectures.csv').to_s) do |row|
      Prefecture.create!(name: row[1])
    end
  end
end