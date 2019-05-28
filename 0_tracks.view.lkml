####
## https://github.com/llooker/demo_segment/blob/master/0_tracks.view.lkml ##

view: segment_tracks {
  sql_table_name: vacasa_prod.tracks ;;

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: event_text {
    type: string
    sql: ${TABLE}.event_text ;;
  }

  dimension_group: received {
    type: time
    timeframes: [raw, time, date, week, month, year]
    sql: ${TABLE}.received_at ;;
  }

  dimension: user_id {
    type: string
    # hidden: true
    sql: LOWER(TRIM(${TABLE}.user_id)) ;;
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
  }

  dimension: event_id {
    type: string
    hidden: yes
#     sql: ${TABLE}.id ;;
    sql: CONCAT(${received_raw}, ${uuid}) ;;
  }

## This isn't in the reference material, but adding it since it's important
  dimension: url {
    type: string
    sql: ${TABLE}.context_page_url ;;
  }

  measure: count_tracks {
    type: count
    drill_fields: [segment_users.id]
  }

  measure: count_distinct_tracks {
    type: count_distinct
    sql: ${TABLE}.anonymous_id ;;
  }

  ## Advanced Fields (require joins to other views)

  dimension: weeks_since_first_visit {
    type: number
    sql: FLOOR(DATEDIFF(day,${segment_user_session_facts.first_date}, ${received_date})/7) ;;
  }

  dimension: days_since_first_visit {
    type: number
    sql: FLOOR(DATEDIFF(day,${segment_user_session_facts.first_date}, ${received_date})) ;;
  }

  dimension: is_new_user {
    sql: CASE
      WHEN ${received_date} = ${segment_user_session_facts.first_date} THEN 'New User'
      ELSE 'Returning User' END
       ;;
  }

  measure: count_percent_of_total {
    type: percent_of_total
    sql: ${count_tracks} ;;
    value_format_name: decimal_1
  }

  ## Advanced -- Session Count Funnel Measures

 # filter: event1 {
#    suggestions: [
#      "added_item",
#      "app_became_active",
#      "app_entered_background",
#      "app_entered_foreground",
#      "app_launched",
#      "app_resigned_active",
#      "app_loaded",
#      "asked_for_sizes",
#      "completed_order",
#      "created_a_project",
#      "failed_auth_validation",
#      "login",
#      "made_purchase",
#      "payment_available",
#      "payment_failed",
#      "payment_form_shown",
#      "payment_form_submitted",
#      "removed_item",
#      "saved_sizes",
#      "shipping_available",
#      "shipping_form_failed",
#      "shipping_form_shown",
#      "shipping_form_submitted",
#      "signup",
#      "submitted_order",
#      "switched_auth_forms",
#      "tapped_shipit",
#      "view_buy_page",
#      "viewed_auth_page"
#    ]
#  }

#  measure: event1_session_count {
#    type: number
#    sql: COUNT(
#        DISTINCT(
#          CASE
#            WHEN
#            {% condition event1 %} ${event} {% endcondition %}
#              THEN ${track_facts.session_id}
#            ELSE NULL END
#        )
#      )
#       ;;
#  }

#  filter: event2 {
#    suggestions: [
#      "added_item",
#      "app_became_active",
#      "app_entered_background",
#      "app_entered_foreground",
#      "app_launched",
#      "app_resigned_active",
#      "asked_for_sizes",
#      "completed_order",
#      "created_a_project",
#      "failed_auth_validation",
#      "login",
#      "made_purchase",
#      "payment_available",
#      "payment_failed",
#      "payment_form_shown",
#      "payment_form_submitted",
#      "removed_item",
#      "saved_sizes",
#      "shipping_available",
#      "shipping_form_failed",
#      "shipping_form_shown",
#      "shipping_form_submitted",
#      "signup",
#      "submitted_order",
#      "subscribed_to_blog",
#      "switched_auth_forms",
#      "tapped_shipit",
#      "view_buy_page",
#      "viewed_auth_page"
#    ]
#  }

#  measure: event2_session_count {
#    type: number
#    sql: COUNT(
#        DISTINCT(
#          CASE
#            WHEN
#            {% condition event2 %} ${event} {% endcondition %}
#              THEN ${track_facts.session_id}
#            ELSE NULL END
#        )
#      )
#       ;;
#  }

#  filter: event3 {
#    suggestions: [
#      "added_item",
#      "app_became_active",
#      "app_entered_background",
#      "app_entered_foreground",
#      "app_launched",
#      "app_resigned_active",
#      "asked_for_sizes",
#      "completed_order",
#      "created_a_project",
#      "failed_auth_validation",
#     "logged_in",
#      "made_purchase",
#      "payment_available",
#      "payment_failed",
#      "payment_form_shown",
#      "payment_form_submitted",
#      "removed_item",
#      "saved_sizes",
#      "shipping_available",
#      "shipping_form_failed",
#      "shipping_form_shown",
#      "shipping_form_submitted",
#      "signup",
#      "submitted_order",
#      "subscribed_to_blog",
#      "switched_auth_forms",
#      "tapped_shipit",
#      "view_buy_page",
#      "viewed_auth_page"
#    ]
#  }

#  measure: event3_session_count {
#    type: number
#    sql: COUNT(
#        DISTINCT(
#          CASE
#            WHEN
#            {% condition event3 %} ${event} {% endcondition %}
#              THEN ${track_facts.session_id}
#            ELSE NULL END
#        )
#      )
#       ;;
#  }

#  filter: event4 {
#    suggestions: [
#      "added_item",
#      "app_became_active",
#      "app_entered_background",
#      "app_entered_foreground",
#      "app_launched",
#      "app_resigned_active",
#      "asked_for_sizes",
#      "completed_order",
#      "created_a_project",
#      "failed_auth_validation",
#      "login",
#      "made_purchase",
#      "payment_available",
#      "payment_failed",
#      "payment_form_shown",
#      "payment_form_submitted",
#      "removed_item",
#      "saved_sizes",
#      "shipping_available",
#      "shipping_form_failed",
#      "shipping_form_shown",
#      "shipping_form_submitted",
#      "signup",
#      "submitted_order",
#      "subscribed_to_blog",
#      "switched_auth_forms",
#      "tapped_shipit",
#      "view_buy_page",
#      "viewed_auth_page"
#    ]
#  }

#  measure: event4_session_count {
#    type: number
#    sql: COUNT(
#        DISTINCT(
#          CASE
#            WHEN
#            {% condition event4 %} ${event} {% endcondition %}
#              THEN ${track_facts.session_id}
#            ELSE NULL END
#        )
#      )
#       ;;
#  }
}