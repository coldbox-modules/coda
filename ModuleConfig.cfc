component {

    this.name = "coda";
    this.author = "Eric Peterson, Michael Anderson";
    this.webUrl = "https://github.com/coldbox-modules/coda";
    this.dependencies = [ "cbi18n" ];

    function configure() {
        binder.map( "@coda" ).to( "#moduleMapping#.models.Coda" );
    }

    function onLoad() {
        var resourceService = wirebox.getInstance( "ResourceService@cbi18n" );
        resourceService.loadBundle( "#moduleMapping#/resources/i18n/coda" );
    }

}
