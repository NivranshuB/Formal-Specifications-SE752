MACHINE Reserve
CONSTANTS maxCapacity
PROPERTIES maxCapacity = 500
VARIABLES currentFuelAmount
INVARIANT currentFuelAmount:NAT & currentFuelAmount >= 0 & currentFuelAmount <= maxCapacity
INITIALISATION currentFuelAmount := 100
OPERATIONS
out <-- CurrentFuelAmount = BEGIN out := currentFuelAmount END;
DispenseFromReserve(dispenseAmount) = IF dispenseAmount >= currentFuelAmount THEN currentFuelAmount := 0 ELSE currentFuelAmount := currentFuelAmount - dispenseAmount END;
AddToReserve(addAmount) = IF addAmount < maxCapacity - currentFuelAmount THEN currentFuelAmount := currentFuelAmount + addAmount ELSE currentFuelAmount := maxCapacity END 
END





