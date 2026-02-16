require "spec_helper"

RSpec.describe Bot do
  subject(:bot) { described_class.new }

  describe "#turn" do
    let(:connection) { instance_double(Faraday::Connection) }

    before do
      allow(bot).to receive(:conn).and_return(connection)
    end

    it "returns the move from the API when it is valid" do
      response = double(body: { body: "rock" })
      allow(connection).to receive(:get).with("/throw").and_return(response)

      expect(bot.turn).to eq("rock")
    end

    it "falls back when API returns an invalid move" do
      response = double(body: { body: "invalid" })
      allow(connection).to receive(:get).with("/throw").and_return(response)
      allow(bot).to receive(:bot_fallback).and_return("paper")

      expect(bot.turn).to eq("paper")
    end

    it "falls back when a Faraday error is raised" do
      allow(bot).to receive(:conn).and_raise(Faraday::Error.new("boom"))
      allow(bot).to receive(:bot_fallback).and_return("scissors")

      expect(bot.turn).to eq("scissors")
    end
  end

  describe "#bot_fallback" do
    it "returns one of the allowed game turns" do
      turns = Array.new(20) { bot.send(:bot_fallback) }

      expect(turns.uniq - Game::WINS.keys).to be_empty
    end
  end
end

