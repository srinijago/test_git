view: op_territories_users {
  sql_table_name: vacasa.op_territories_users ;;

  dimension: role_id {
    type: number
    # hidden: true
    sql: ${TABLE}.RoleID ;;
  }

  dimension: territory_id {
    type: number
    sql: ${TABLE}.TerritoryID ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.UserID ;;
  }

  measure: count {
    type: count
    drill_fields: [users.id, roles.role_id]
  }
}
