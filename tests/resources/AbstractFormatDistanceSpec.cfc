component extends="testbox.system.BaseSpec" {

    variables.INCLUDE_SECONDS = true;

    function beforeAll() {
        variables.coda = new root.models.Coda();
    }

    function run() {
        describe( "formatDistance", function() {
            describe( "includeSeconds", function() {
                it( "less than 5s", function() {
                    var date = createDateTime( 2021, 1, 1, 12, 0, 3 );
                    var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                    expect( coda.formatDistance( date, baseDate, INCLUDE_SECONDS ) ).toBe( lessThanFiveSeconds() );
                } );

                it( "less than 10s", function() {
                    var date = createDateTime( 2021, 1, 1, 12, 0, 8 );
                    var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                    expect( coda.formatDistance( date, baseDate, INCLUDE_SECONDS ) ).toBe( lessThanTenSeconds() );
                } );

                it( "less than 20s", function() {
                    var date = createDateTime( 2021, 1, 1, 12, 0, 15 );
                    var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                    expect( coda.formatDistance( date, baseDate, INCLUDE_SECONDS ) ).toBe( lessThanTwentySeconds() );
                } );

                it( "less than 40s", function() {
                    var date = createDateTime( 2021, 1, 1, 12, 0, 39 );
                    var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                    expect( coda.formatDistance( date, baseDate, INCLUDE_SECONDS ) ).toBe( halfAMinute() );
                } );

                it( "less than 60s", function() {
                    var date = createDateTime( 2021, 1, 1, 12, 0, 55 );
                    var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                    expect( coda.formatDistance( date, baseDate, INCLUDE_SECONDS ) ).toBe( lessThanAMinute() );
                } );
            } );

            it( "0 to 59s", function() {
                var date = createDateTime( 2021, 1, 1, 12, 0, 15 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( lessThanAMinute() );
            } );

            it( "1m to 2m", function() {
                var date = createDateTime( 2021, 1, 1, 12, 1, 05 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( oneMinute() );
            } );

            it( "2m to 45m", function() {
                var date = createDateTime( 2021, 1, 1, 12, 5, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( fiveMinutes() );

                date = createDateTime( 2021, 1, 1, 12, 21, 0 );
                baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( twentyOneMinutes() );
            } );

            it( "45m to 1.5h", function() {
                var date = createDateTime( 2021, 1, 1, 12, 48, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutAnHour() );

                date = createDateTime( 2021, 1, 1, 13, 29, 0 );
                baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutAnHour() );
            } );

            it( "1.5h to 24h", function() {
                var date = createDateTime( 2021, 1, 1, 15, 29, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutThreeHours() );

                date = createDateTime( 2021, 1, 1, 15, 45, 0 );
                baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutFourHours() );
            } );

            it( "1d to 1.75d", function() {
                var date = createDateTime( 2021, 1, 2, 15, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 12, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aDay() );

                date = createDateTime( 2021, 1, 2, 17, 0, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aDay() );
            } );

            it( "1.75d to 30d", function() {
                var date = createDateTime( 2021, 1, 2, 18, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( twoDays() );

                date = createDateTime( 2021, 1, 21, 2, 30, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( twentyDays() );
            } );

            it( "1mos to 2mos", function() {
                var date = createDateTime( 2021, 2, 1, 2, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutAMonth() );
            } );

            it( "2mos to 12mos", function() {
                var date = createDateTime( 2021, 6, 1, 2, 30, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( fiveMonths() );
                
                date = createDateTime( 2021, 12, 1, 2, 30, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( elevenMonths() );
            } );

            it( "N years to N years 3 months", function() {
                var date = createDateTime( 2022, 1, 2, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutAYear() );

                date = createDateTime( 2023, 1, 2, 0, 0, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( aboutTwoYears() );
            } );

            it( "N years 3 months to N years 9 months", function() {
                var date = createDateTime( 2022, 5, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( overAYear() );

                date = createDateTime( 2023, 9, 1, 0, 0, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( overTwoYears() );
            } );

            it( "N years 9 months to N years 12 months", function() {
                var date = createDateTime( 2022, 11, 1, 0, 0, 0 );
                var baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( almostTwoYears() );

                date = createDateTime( 2023, 12, 1, 0, 0, 0 );
                baseDate = createDateTime( 2021, 1, 1, 0, 0, 0 );
                expect( coda.formatDistance( date, baseDate ) ).toBe( almostThreeYears() );
            } );
        } );
    }

    function lessThanFiveSeconds() {
        throw( "method is abstract and must be implemented in a subclass" );
    }
    
    function lessThanTenSeconds() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function lessThanTwentySeconds() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function halfAMinute() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function lessThanAMinute() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function oneMinute() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function fiveMinutes() {
        throw( "method is abstract and must be implemented in a subclass" );
    }
    
    function twentyOneMinutes() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aboutAnHour() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aboutThreeHours() {
        throw( "method is abstract and must be implemented in a subclass" );
    }
    
    function aboutFourHours() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aDay() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function twoDays() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function twentyDays() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aboutAMonth() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function fiveMonths() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function elevenMonths() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aboutAYear() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function aboutTwoYears() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function overAYear() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function overTwoYears() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function almostTwoYears() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

    function almostThreeYears() {
        throw( "method is abstract and must be implemented in a subclass" );
    }

}
