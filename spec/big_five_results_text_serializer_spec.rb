require_relative "../app/big_five_results_text_serializer"

describe 'BigFiveResultsTextSerializer' do
  let(:text) { File.read('./result.txt') }
  let(:serializer) { BigFiveResultsTextSerializer.new(text) }
  let(:result) do
    {
      'NAME' => 'Wayne',
      'EMAIL' => 'wayne.5540@gmail.com',
      'EXTRAVERSION' => {
        'Overall Score' => 72,
        'Facets' => {
          'Friendliness' => 74,
          'Gregariousness' => 55,
          'Assertiveness' => 73,
          'Activity Level' => 49,
          'Excitement-Seeking' => 46,
          'Cheerfulness' => 90
        }
      },
      'AGREEABLENESS' => {
        'Overall Score' => 89,
        'Facets' => {
          'Trust' => 99,
          'Morality' => 89,
          'Altruism' => 69,
          'Cooperation' => 63,
          'Modesty' => 65,
          'Sympathy' => 63
        }
      },
      'CONSCIENTIOUSNESS' => {
        'Overall Score' => 85,
        'Facets' => {
          'Self-Efficacy' => 90,
          'Orderliness' => 41,
          'Dutifulness' => 78,
          'Achievement-Striving' => 66,
          'Self-Discipline' => 92,
          'Cautiousness' => 87
        }
      },
      'NEUROTICISM' => {
        'Overall Score' => 2,
        'Facets' => {
          'Anxiety' => 12,
          'Anger' => 1,
          'Depression' => 9,
          'Self-Consciousness' => 22,
          'Immoderation' => 12,
          'Vulnerability' => 19
        }
      },
      'OPENNESS TO EXPERIENCE' => {
        'Overall Score' => 77,
        'Facets' => {
          'Imagination' => 19,
          'Artistic Interests' => 69,
          'Emotionality' => 65,
          'Adventurousness' => 93,
          'Intellect' => 79,
          'Liberalism' => 71
        }
      }
    }
  end

  describe '#hash' do
    subject { serializer.hash }

    it 'returns result in hash' do
      is_expected.to eq(result)
    end

    it 'returns NAME' do
      expect(subject['NAME']).to eq('Wayne')
    end

    it 'returns EMAIL' do
      expect(subject['EMAIL']).to eq('wayne.5540@gmail.com')
    end

    it 'returns EXTRAVERSION' do
      expect(subject['EXTRAVERSION']).to eq(result['EXTRAVERSION'])
    end

    it 'returns AGREEABLENESS' do
      expect(subject['AGREEABLENESS']).to eq(result['AGREEABLENESS'])
    end

    it 'returns CONSCIENTIOUSNESS' do
      expect(subject['CONSCIENTIOUSNESS']).to eq(result['CONSCIENTIOUSNESS'])
    end

    it 'returns NEUROTICISM' do
      expect(subject['NEUROTICISM']).to eq(result['NEUROTICISM'])
    end

    it 'returns OPENNESS TO EXPERIENCE' do
      expect(subject['OPENNESS TO EXPERIENCE']).to eq(result['OPENNESS TO EXPERIENCE'])
    end
  end
end