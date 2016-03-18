require 'rails_helper'

describe Report do
  describe '#result' do
    subject { report.result }

    let(:report) { build :report }
    let(:club_final_score) { 0 }
    let(:rival_final_score) { 0 }

    before do
      report.update(club_final_score: club_final_score,
                    rival_final_score: rival_final_score)
    end

    context 'when club_final_score is equal to rival_final_score' do
      it 'is set correctly' do
        expect(subject).to eq 'drew'
      end
    end

    context 'when club_final_score is greater than rival_final_score' do
      let(:club_final_score) { 1 }

      it 'is set correctly' do
        expect(subject).to eq 'won'
      end
    end

    context 'when club_final_score is lower than rival_final_score' do
      let(:rival_final_score) { 1 }

      it 'is set correctly' do
        expect(subject).to eq 'lost'
      end
    end

    context 'when club_final_score and/or rival_final_score are nil' do
      let(:club_final_score) { nil }
      let(:rival_final_score) { nil }

      it 'is set to nil' do
        expect(subject).to eq nil
      end
    end
  end
end
