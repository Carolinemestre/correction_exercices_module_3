SELECT
   event_name,
   TIMESTAMP_MICROS(event_timestamp) AS event_timestamp,
   user_pseudo_id,
   user_first_touch_timestamp,
   (SELECT event_params.value.int_value from unnest(event_params) event_params where event_params.key = 'ga_session_id') AS ga_session_id,
   (SELECT event_params.value.string_value from unnest(event_params) event_params where event_params.key = 'page_title') AS page_title,
   (SELECT event_params.value.string_value from unnest(event_params) event_params where event_params.key = 'browser') AS browser,
   traffic_source.medium AS traffic_medium,
   traffic_source.source AS traffic_source,
   traffic_source.name AS traffic_name
 FROM {{ source('googles_analytics_4', 'events_20210131') }}
