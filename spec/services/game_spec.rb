require "spec_helper"

RSpec.describe Game do
  subject(:game) { described_class.new }

  let(:bot_instance) { instance_double(Bot) }

  before do
    allow(Bot).to receive(:new).and_return(bot_instance)
  end

  describe "#start" do
    it "returns :win and bot turn when player beats the bot" do
      allow(bot_instance).to receive(:turn).and_return("scissors")

      outcome = game.start("rock")

      expect(outcome[:result]).to eq(:win)
      expect(outcome[:bot_turn]).to eq("scissors")
    end

    it "returns :lose and bot turn when bot beats the player" do
      allow(bot_instance).to receive(:turn).and_return("rock")

      outcome = game.start("scissors")

      expect(outcome[:result]).to eq(:lose)
      expect(outcome[:bot_turn]).to eq("rock")
    end

    it "returns :draw and bot turn when both choose the same turn" do
      allow(bot_instance).to receive(:turn).and_return("paper")

      outcome = game.start("paper")

      expect(outcome[:result]).to eq(:draw)
      expect(outcome[:bot_turn]).to eq("paper")
    end
  end
end
