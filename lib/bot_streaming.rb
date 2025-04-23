require 'dotenv/load'
require 'twitter'
require 'pry'
require 'openssl'

# Forcer l'utilisation de TLS 1.2
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ssl_version] = :TLSv1_2

class TwitterBot
  def initialize
    # Initialisation du client Twitter avec les clés d'API
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  # Méthode pour envoyer un tweet à un utilisateur par son nom d'utilisateur
  def send_tweet(username, message)
    tweet = "#{message} #hello_world #TS_4Afreeka"
    @client.update("@#{username} #{tweet}")
    puts "Tweet envoyé à @#{username} : #{tweet}"
  end

  # Méthode pour liker un tweet
  def like_tweet(tweet)
    tweet.favorite
    puts "Tweet liké : #{tweet.text}"
  end

  # Méthode pour follow un utilisateur
  def follow_user(user)
    @client.follow(user)
    puts "Followé @#{user.screen_name}"
  end

  # Fonction pour écouter les tweets contenant #hello_world en live
  def listen_and_respond
    puts "Bot en écoute sur les tweets avec le hashtag #hello_world"

    @client.filter(track: '#hello_world') do |object|
      binding.pry  # Arrêt dans Pry pour déboguer chaque tweet
      if object.is_a?(Twitter::Tweet)
        puts "Tweet détecté: #{object.text}"

        # Like le tweet
        like_tweet(object)

        # Follow l'utilisateur qui a tweeté
        follow_user(object.user)
      end
    end
  end
end

# Créer une instance du bot
bot = TwitterBot.new

# Lancer l'écoute des tweets en temps réel
bot.listen_and_respond
