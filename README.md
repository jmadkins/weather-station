# WeatherStation

Reports the current weather conditions.

## Software stack

WeatherStation is a Ruby on Rails application that runs on the following software:

- Ruby 3.4.2
- Rails 8.0.2
- SQLite 3.x

## Environment Variables

| name                       | use                                                       |
| -------------------------- | --------------------------------------------------------- |
| `WS_MAPBOX_ACCESS_TOKEN`   | API token/key for Mapbox                                  |

## External Services

1. [Mapbox Geocoding](https://docs.mapbox.com/api/search/geocoding/)
1. [US National Weather Service](https://www.weather.gov/documentation/services-web-api)

## Notes

* I included `.env.development.local` and `config/master.key` despite being security risks. I'll revoke the key in 2 weeks.
* If given more time, I would have spent designing a better front end.
