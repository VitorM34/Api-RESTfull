namespace :dev do
  desc "Configure development environment"
  task setup: :environment do
    100.times do |i|
      puts "Cadatrando contatos"
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
      birthdate: Faker::Date.between(from: 60.years.ago, to: 18.years.ago)
      )
      end
      puts "Contatos cadastrados com sucesso!"
    end
  end
