MACHINE PetrolStation

INCLUDES Pump

PROMOTES SetPetrolPrice, InputCashAmount, InputLitreQuantity, ResetQuantity, AttachPump, RemovePump, PressLever, AddToReserve, LockPump, UnlockPump

SETS TRANSACTION={active, inactive}

VARIABLES totalRevenue, totalPetrolLitresSold, transactionActive

INVARIANT transactionActive:PUMP-->TRANSACTION & totalRevenue:NAT & totalRevenue >= 0 & totalPetrolLitresSold:NAT & totalPetrolLitresSold >= 0

INITIALISATION transactionActive:=PUMP*{inactive} || totalRevenue:=0 || totalPetrolLitresSold:=0

OPERATIONS
StartTransaction(pp) = PRE pp:PUMP & transactionActive(pp)=inactive & pumpStatus(pp)=unlocked THEN transactionActive(pp):=active || UnlockPump(pp) END;
EndTransaction(pp) = PRE pp:PUMP & fuelPumped(pp)=pumped & transactionActive(pp)=active THEN transactionActive(pp):=inactive || totalRevenue:= totalRevenue + cashAmount(pp) || totalPetrolLitresSold:= totalPetrolLitresSold + litres(pp) || ResetPump(pp) || LockPump(pp) END
END