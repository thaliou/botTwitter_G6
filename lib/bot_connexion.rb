require 'dotenv/load'
require 'twitter'
require 'pry'
require 'net/https'
require 'openssl'

# Forcer l'utilisation de TLS 1.2
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ssl_version] = :TLSv1_2

# Classe qui gère le bot Twitter
class TwitterBot
  def initialize
    # Configuration des clés API Twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY'] # Remplacer par ta clé
      config.consumer_secret     = ENV['TWITTER_API_SECRET'] # Remplacer par ton secret
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN'] # Remplacer par ton token
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET'] # Remplacer par ton token secret
    end
  end

  # Méthode pour tester la connexion
  def test_login
    begin
      # Tentative d'obtention d'informations sur l'utilisateur authentifié
      user = @client.verify_credentials
      puts "Connexion réussie ! Utilisateur authentifié : @#{user.screen_name}"
      binding.pry  # Pour tester la connexion dans pry
    rescue Twitter::Error => e
      puts "Erreur lors de la connexion : #{e.message}"
    end
  end
end

# Créer une instance du bot et tester la connexion
bot = TwitterBot.new
bot.test_login
