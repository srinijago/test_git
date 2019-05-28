view: minutes {
  sql_table_name: vacasa.minutes ;;

  dimension: minute_of_day {
    type: string
    sql: ${TABLE}.MinuteOfDay ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
