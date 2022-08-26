MACHINE Reserve
CONSTANTS maxCapacity
PROPERTIES maxCapacity = 500
VARIABLES currentFuelAmount
INVARIANT currentFuelAmount:NAT & currentFuelAmount >= 0 & currentFuelAmount <= maxCapacity
INITIALISATION currentFuelAmount := 4
OPERATIONS
out <-- CurrentFuelAmount = BEGIN out := currentFuelAmount END;
DispenseFromReserve(dispenseAmount) = IF dispenseAmount >= currentFuelAmount THEN currentFuelAmount := 0 ELSE currentFuelAmount := currentFuelAmount - dispenseAmount END;
AddToReserve(addAmount) = IF addAmount < maxCapacity - currentFuelAmount & addAmount>0 & addAmount:NAT THEN currentFuelAmount := currentFuelAmount + addAmount ELSIF addAmount>maxCapacity-currentFuelAmount & addAmount>0 & addAmount:NAT THEN currentFuelAmount := maxCapacity END 
END



 

