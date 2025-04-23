require 'rspec'
require 'twitter_bot'

RSpec.describe TwitterBot do
  let(:bot) { TwitterBot.new }

  describe '#send_dm_to_user' do
    it 'envoie un message direct' do
      expect { bot.send_dm_to_user('journalist1', 'Salut !') }.to output("Message envoyé à journalist1: Salut !\n").to_stdout
    end
  end
end
