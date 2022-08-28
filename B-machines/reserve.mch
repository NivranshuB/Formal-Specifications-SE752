MACHINE Reserve
/* This B Machine models the petrol storage reserve of a petrol station.
*/

CONSTANTS maxCapacity

PROPERTIES maxCapacity = 500

VARIABLES reserveFuelAmount

INVARIANT reserveFuelAmount:NAT & reserveFuelAmount >= 0 & reserveFuelAmount <= maxCapacity

INITIALISATION reserveFuelAmount := 4


OPERATIONS

out <-- ReserveFuelAmount = BEGIN out := reserveFuelAmount END;

DispenseFromReserve(dispenseAmount) = IF dispenseAmount >= reserveFuelAmount THEN reserveFuelAmount := 0 ELSE reserveFuelAmount := reserveFuelAmount - dispenseAmount END;

AddToReserve(addAmount) =  PRE addAmount>0 THEN IF addAmount < maxCapacity - reserveFuelAmount & addAmount>0 & addAmount:NAT THEN reserveFuelAmount :=  reserveFuelAmount + addAmount ELSIF addAmount>maxCapacity-reserveFuelAmount & addAmount>0 & addAmount:NAT THEN reserveFuelAmount := maxCapacity END END

END



 

