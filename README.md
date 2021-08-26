# Coda

## A collection of date helper functions

### Methods

#### `formatDistance`

Returns the distance between two dates expressed as an approximate human-readable string

```
coda.formatDistance( "2021-01-01 10:00:00", "2021-01-01 11:05:23" );
// "about an hour"
```

### Internationalization

Coda supports the following locales:

+ en_US

You can contribute a new locale by adding a file to the `/resources/i18n/` folder.
The file should be named `coda_{LANG}(_{LOCALE}).json` with `_{LOCALE}` being optional.
cbi18n will use the most specific file found and fall back to more general files if not.

Additionally, please duplicate the `FormatDistance_EN_US_Spec.cfc` test and change the
functions to return the correct translation for your new locale.  This ensures we don't
mess things up in the future.
 
## Prior Art &amp; Inspiration
- [date-fns](https://date-fns.org/)