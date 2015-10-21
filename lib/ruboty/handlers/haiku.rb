require 'ruboty/haiku_wo_yome/actions/haiku'

module Ruboty
  module Handlers
    class Haiku < Ruboty::Handlers::Base
      env 'SLACK_TOKEN_FOR_SEARCH', "Slack token for search api (important: bot user can't call search api! require human api key"

      on(/ハイクを詠め\s\@?(?<user_name>\w+)[=＝]サン/, name: :haiku_wo_yome, description: 'カイシャクしてやる', all: true)
      on(/タンカを詠め\s\@?(?<user_name>\w+)[=＝]サン/, name: :tanka_wo_yome, description: 'カイシャクしてやる', all: true)
      on(/(?<search_word>.+)\s+ハイクを詠め/, name: :haiku_wo_yome, description: 'カイシャクしてやる', all: true)
      on(/(?<search_word>.+)\s+タンカを詠め/, name: :tanka_wo_yome, description: 'カイシャクしてやる', all: true)

      def haiku_wo_yome(message)
        Ruboty::HaikuWoYome::Actions::Haiku.new(message).call
      end

      def tanka_wo_yome(message)
        Ruboty::HaikuWoYome::Actions::Haiku.new(message).call(type: :tanka)
      end
    end
  end
end
