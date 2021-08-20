component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.coda = new root.models.Coda();
    }

    function run() {
        describe( "formatDistance", function() {
            it( "0 to 59s", function() {
                var date = createDateTime( 2021, 1, 1, 12, 0, 15 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "less than a minute" );
            } );

            it( "1m to 2m", function() {
                var date = createDateTime( 2021, 1, 1, 12, 1, 05 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "1 minute" );
            } );

            it( "1m to 2m", function() {
                var date = createDateTime( 2021, 1, 1, 12, 1, 05 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "1 minute" );
            } );

            it( "2m to 45m", function() {
                var date = createDateTime( 2021, 1, 1, 12, 5, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "5 minutes" );

                var date = createDateTime( 2021, 1, 1, 12, 21, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "21 minutes" );
            } );

            it( "45m to 1.5h", function() {
                var date = createDateTime( 2021, 1, 1, 12, 48, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about an hour" );

                var date = createDateTime( 2021, 1, 1, 13, 29, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about an hour" );
            } );

            it( "1.5h to 24h", function() {
                var date = createDateTime( 2021, 1, 1, 15, 29, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about 3 hours" );

                var date = createDateTime( 2021, 1, 1, 15, 45, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about 4 hours" );
            } );

            it( "1d to 1.75d", function() {
                var date = createDateTime( 2021, 1, 2, 15, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "a day" );

                var date = createDateTime( 2021, 1, 2, 17, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "a day" );
            } );

            it( "1.75d to 30d", function() {
                var date = createDateTime( 2021, 1, 2, 18, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "2 days" );

                var date = createDateTime( 2021, 1, 21, 2, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "20 days" );
            } );

            it( "1mos to 2mos", function() {
                var date = createDateTime( 2021, 2, 1, 2, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about a month" );
            } );

            it( "2mos to 12mos", function() {
                var date = createDateTime( 2021, 6, 1, 2, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "5 months" );
            } );

            it( "N years to N years 3 months", function() {
                var date = createDateTime( 2022, 1, 2, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about a year" );

                var date = createDateTime( 2023, 1, 2, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "about 2 years" );
            } );

            it( "N years 3 months to N years 9 months", function() {
                var date = createDateTime( 2022, 5, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "over a year" );

                var date = createDateTime( 2023, 9, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "over 2 years" );
            } );

            it( "N years 9 months to N years 12 months", function() {
                var date = createDateTime( 2022, 11, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "almost 2 years" );

                var date = createDateTime( 2023, 12, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( "almost 3 years" );
            } );
        } );
    }

}
