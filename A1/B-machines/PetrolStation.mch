MACHINE PetrolStation
/* This B Machine models the operations that will be undertaken and the data that will be stored for a petrol station management system.
*/

INCLUDES Pump

PROMOTES SetPetrolPrice, InputCashAmount, InputLitreQuantity, ResetQuantity, AttachPump, RemovePump, PressLever, AddToReserve

SETS TRANSACTION={active, inactive}

VARIABLES totalRevenue, totalPetrolLitresSold, transactionActive

INVARIANT transactionActive:PUMP-->TRANSACTION & totalRevenue:NAT & totalRevenue >= 0 & totalPetrolLitresSold:NAT & totalPetrolLitresSold >= 0

INITIALISATION transactionActive:=PUMP*{inactive} || totalRevenue:=0 || totalPetrolLitresSold:=0


OPERATIONS

StartTransaction(pp) = PRE pp:PUMP & transactionActive(pp)=inactive & pumpStatus(pp)=pumpFree THEN transactionActive(pp):=active || OccupyPump(pp) END;

AbortTransaction(pp) = PRE pp:PUMP & fuelPumped(pp)=unpumped & transactionActive(pp)=active THEN transactionActive(pp):=inactive || ResetPump(pp) || FreeUpPump(pp) END;

EndTransaction(pp) = PRE pp:PUMP & fuelPumped(pp)=pumped & transactionActive(pp)=active & pumpAttached(pp)=unattached THEN transactionActive(pp):=inactive || totalRevenue:= totalRevenue + cashAmount(pp) || totalPetrolLitresSold:= totalPetrolLitresSold + litres(pp) || ResetPump(pp) || FreeUpPump(pp) END

END