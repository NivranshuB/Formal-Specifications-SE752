MACHINE PetrolStation
INCLUDES Reserve
PROMOTES AddToReserve
SETS PUMP; TRANSACTION={active, inactive}; PUMPATTACHED={attached,unattached}; FUELPUMPED={pumped, unpumped}; QUANTITYSPECIFIED={specified,unspecified}
CONSTANTS minQuantity, maxQuantity
PROPERTIES minQuantity = 1 & maxQuantity = 100
VARIABLES quantitySpecified, cashAmount, litres, pumpAttached, transactionActive, fuelPumped, totalRevenue, totalPetrolLitresSold, petrolPrice
INVARIANT cashAmount:NAT & cashAmount >= 0 & litres:NAT & litres >= 0 & petrolPrice:NAT & pumpAttached:PUMP-->PUMPATTACHED & fuelPumped:PUMP-->FUELPUMPED & transactionActive:PUMP-->TRANSACTION & quantitySpecified:PUMP-->QUANTITYSPECIFIED & totalRevenue:NAT & totalRevenue >= 0 & totalPetrolLitresSold:NAT & totalPetrolLitresSold >= 0
INITIALISATION quantitySpecified:=PUMP* {unspecified} || cashAmount:=0 || litres:=0 || pumpAttached:=PUMP*{unattached} || transactionActive:=PUMP*{inactive} || fuelPumped:=PUMP*{unpumped} || petrolPrice:=2 || totalRevenue:=0 || totalPetrolLitresSold:=0
OPERATIONS
StartTransaction(price, pp) = PRE pp:PUMP & price>=0 & transactionActive(pp)=inactive THEN petrolPrice:=price || transactionActive(pp):=active || litres:=0 || cashAmount:=0 || quantitySpecified(pp):=unspecified || fuelPumped(pp):=unpumped END;
InputCashAmount(amount, pp) = PRE pp:PUMP & amount >= minQuantity & amount:NAT & amount/petrolPrice >= minQuantity & quantitySpecified(pp)=unspecified & transactionActive(pp)=active THEN cashAmount:=amount || litres:=amount/petrolPrice || quantitySpecified(pp):=specified END;
InputLitreQuantity(amount, pp) = PRE pp:PUMP & amount:NAT & amount >= minQuantity & quantitySpecified(pp)=unspecified & transactionActive(pp)=active THEN cashAmount:=amount*petrolPrice || litres:=amount || quantitySpecified(pp):=specified END;
ResetQuantity(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified THEN cashAmount:=0 || litres:=0 || quantitySpecified(pp):=unspecified END;
AttachPump(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=unattached THEN pumpAttached(pp):=attached END;
RemovePump(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached THEN pumpAttached(pp):=unattached END;
PressLever(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached THEN 
IF currentFuelAmount < litres THEN litres:=currentFuelAmount || cashAmount:= currentFuelAmount*petrolPrice || DispenseFromReserve(currentFuelAmount) || fuelPumped(pp):=pumped || totalRevenue:=totalRevenue + cashAmount || totalPetrolLitresSold:=totalPetrolLitresSold + litres
ELSE fuelPumped(pp):=pumped || DispenseFromReserve(litres) || totalRevenue:=totalRevenue + cashAmount || totalPetrolLitresSold:=totalPetrolLitresSold + litres END END;
EndTransaction(pp) = PRE pp:PUMP & fuelPumped(pp)=pumped THEN transactionActive(pp):=inactive || quantitySpecified(pp):=unspecified || fuelPumped(pp):=unpumped || pumpAttached(pp):=unattached END
END





