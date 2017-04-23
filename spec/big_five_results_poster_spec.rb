describe 'BigFiveResultsPoster' do
  let(:text) { File.read('./result.txt') }
  let(:results_hash) { BigFiveResultsTextSerializer.new(text).hash }
  let(:poster) { BigFiveResultsPoster.new(results_hash) }

  describe '#post' do
    subject { poster.post }

    describe 'success' do
      around do |example|
        VCR.use_cassette('post_success') do
          example.call
        end
      end

      specify do
        is_expected.to be true
      end

      it 'recieves 201 created response_code' do
        subject

        expect(poster.response_code).to eq(201)
      end

      it 'recieves token' do
        subject

        expect(poster.token).to eq('rL3RK5eL9gHU6jeKs5x5DjwU')
      end
    end

    describe 'failed' do
      around do |example|
        VCR.use_cassette('post_failed') do
          example.call
        end
      end

      context 'when given incorrect body' do
        let(:results_hash) { { "hello" => "world" } }

        specify do
          is_expected.to be false
        end

        it 'recieves 422 unprocessable entity response_code' do
          subject

          expect(poster.response_code).to eq(422)
        end

        it "doesn't recieve token" do
          subject

          expect(poster.token).to be nil
        end
      end
    end
  end
end