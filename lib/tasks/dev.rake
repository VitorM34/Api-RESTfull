namespace :dev do
  # Task para configurar o ambiente de desenvolvimento
  desc "Configure development environment"
  task setup: :environment do
    puts "Cadastrando tipos de contatos..."

    kinds = %w[amigo familiar profissional]
    kinds.each do |kind|
      Kind.create!(description: kind)
    end

    puts "Tipos de contatos cadastrados com sucesso!"

    puts "Cadastrando contatos..."

    100.times do
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        kind: Kind.all.sample,
        birthdate: Faker::Date.between(from: 60.years.ago, to: 18.years.ago)
      )
    end

    puts "Contatos cadastrados com sucesso!"
  end

  # Task para cadastrar telefones para os contatos
  desc "Cadastrar telefones para os contatos"
  task phones: :environment do
    puts "Cadastrando telefones para os contatos..."

    Contact.find_each do |contact|
      rand(1..3).times do
        Phone.create!(
          name: Faker::PhoneNumber.cell_phone_in_e164,
          contact: contact
        )
      end
    end

    puts "Telefones cadastrados com sucesso!"
  end

  # Task para cadastrar endereços para os contatos
  desc "Cadastrar endereços para os contatos"
  task addresses: :environment do
    puts "Cadastrando os enderecos..."

    Contact.find_each do |contact|
      Address.create!(
        street: Faker::Address.street_name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        contact: contact
      )
    end

    puts "Endereços cadastrados com sucesso!"
  end
end
