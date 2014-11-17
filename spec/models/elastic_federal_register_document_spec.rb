require 'spec_helper'

describe ElasticFederalRegisterDocument do
  fixtures :federal_register_agencies, :federal_register_documents

   let!(:fr_noaa) { federal_register_agencies(:fr_noaa) }

  describe '.search_for' do
    before do
      FederalRegisterDocument.all.each(&:save!)
      ElasticFederalRegisterDocument.commit
    end

    context 'when there are results' do
      it 'returns results in an easy to access structure' do
        search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                           language: 'en',
                                                           q: 'fish')

        search.total.should eq 4
        search.results.first.should be_instance_of(FederalRegisterDocument)
      end

      it 'sorts results by comments_close_on in the descending order' do
        search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                           language: 'en',
                                                           q: 'foreign fishing')

        search.total.should eq 4
        search.results[0].document_number.should eq '2014-15173'
        search.results[1].document_number.should eq '2014-15266'
        search.results[2].document_number.should eq '2014-15269'
      end

      it 'groups results by docket ID ordered by published_date' do
        search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                           language: 'en',
                                                           q: 'hedge funds')
        search.total.should eq 3
        search.results[0].document_number.should eq '2013-17000'
        search.results[1].document_number.should eq '2013-15000'
        search.results[2].document_number.should eq '2014-25000'
      end

      context 'when there is a matching term in the abstract' do
        it 'shows the documents' do
          search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                             language: 'en',
                                                             q: 'protect')

          search.total.should eq 1
          search.results[0].document_number.should eq '2014-15238'
        end
      end

      context 'when the query contains document number' do
        it 'shows the documents' do
          search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                             language: 'en',
                                                             q: '2014-15238 marine')

          search.total.should eq 1
          search.results[0].document_number.should eq '2014-15238'
        end
      end

      context 'when those results get deleted' do
        before do
          FederalRegisterDocument.destroy_all
          ElasticFederalRegisterDocument.commit
        end

        it 'returns zero results' do
          search = ElasticFederalRegisterDocument.search_for(federal_register_agency_ids: [fr_noaa.id],
                                                             language: 'en',
                                                             q: 'fish')

          search.total.should eq 0
          search.results.size.should eq 0
        end
      end

    end
  end
end