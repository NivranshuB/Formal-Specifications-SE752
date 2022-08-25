MACHINE PetrolStation
VARIABLES revenue, petrolSold, petrolPrice
INVARIANT revenue:NAT & revenue >= 0 & petrolSold:NAT & petrolSold >= 0 & petrolPrice:NAT & petrolPrice > 0
INITIALISATION petrolPrice := 2 || revenue := 0 || petrolSold := 0
OPERATIONS
ResetAccounts = revenue:=0 || petrolSold:=0;
ResetPrice(price) = PRE price:NAT & price > 0 THEN petrolPrice:=price END;
PetrolSold(litres) = PRE litres:NAT & litres > 0 THEN revenue:=revenue + litres*petrolPrice || petrolSold:=petrolSold + litres END
END