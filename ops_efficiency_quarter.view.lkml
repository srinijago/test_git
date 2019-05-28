view: ops_efficiency_quarter {
  sql_table_name: analysis_ready.ops_efficiency_quarter ;;

  dimension: key {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.key ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.quarter ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: bd {
    type: sum
    sql: ${TABLE}.bd ;;
    value_format_name: decimal_0
  }

  measure: billable {
    type: sum
    sql: ${TABLE}.billable ;;
    value_format_name: decimal_0
  }

  dimension: days_diff {
    type: number
    sql: ${TABLE}.days_diff ;;
  }

  measure: dollars {
    hidden: yes
    type: sum
    sql: ${TABLE}.dollars ;;
    value_format_name: decimal_0
  }

  measure: annual_cost {
    type: number
    sql: CASE WHEN ${num_of_units} > 0 THEN 1.0 * ${dollars}/NULLIF(${num_of_units},0)/NULLIF(${days_diff},0) * 365.25 END ;;
    value_format_name: usd_0
  }

  measure: drive_time {
    type: sum
    sql: ${TABLE}.drive_time ;;
    value_format_name: decimal_0
  }

  measure: housekeeping {
    type: sum
    sql: ${TABLE}.housekeeping ;;
    value_format_name: decimal_0
  }

  measure: maintenance {
    type: sum
    sql: ${TABLE}.maintenance ;;
    value_format_name: decimal_0
  }

  measure: num_of_units {
    type: sum
    sql: ${TABLE}.num_of_units ;;
  }

  measure: other_hours {
    type: sum
    sql: ${TABLE}.other_hours ;;
    value_format_name: decimal_0
  }

  measure: pto {
    type: sum
    sql: ${TABLE}.pto ;;
    value_format_name: decimal_0
  }

  measure: reservations_queue {
    type: sum
    sql: ${TABLE}.reservations_queue ;;
    value_format_name: decimal_0
  }

  measure: special_projects {
    type: sum
    sql: ${TABLE}.special_projects ;;
    value_format_name: decimal_0
  }

  measure: total_time {
    type: sum
    sql: ${TABLE}.total_time ;;
    value_format_name: decimal_0
  }

  measure: training {
    type: sum
    sql: ${TABLE}.training ;;
    value_format_name: decimal_0
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }
}
