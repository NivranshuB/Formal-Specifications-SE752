MACHINE Buffer

SETS
 MSG

CONSTANTS limit

PROPERTIES
 limit = 4

VARIABLES items

INVARIANT
 items : seq(MSG) & card(items) <= limit

INITIALISATION items := []

OPERATIONS
  Join(mm) = PRE mm : MSG & card(items) < limit THEN items := items ^ [mm] END;

  output <-- Leave = PRE items /= [] THEN output, items := first(items), tail(items) END

END

