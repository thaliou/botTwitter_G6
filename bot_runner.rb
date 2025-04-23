require_relative 'lib/twitter_bot'

bot = TwitterBot.new

journalists = ['journalist1', 'journalist2', 'journalist3']
message = "Salut ! Découvrez ce super projet et rejoignez la conversation."
hashtag = "#MonSuperHashtag"

bot.promote_hashtag_to_journalists(journalists, message, hashtag)
