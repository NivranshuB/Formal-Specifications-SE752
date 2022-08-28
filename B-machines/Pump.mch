MACHINE Pump
/* This B Machine models the fuel dispenser pumps of a petrol station.
*/

INCLUDES Reserve

PROMOTES AddToReserve

SETS PUMP; PUMPATTACHED={attached,unattached}; QUANTITYSPECIFIED={specified,unspecified}; FUELPUMPED={pumped, unpumped}; PUMPSTATUS={pumpFree, pumpOccupied}

CONSTANTS minQuantity, maxQuantity, maxPetrolPrice

PROPERTIES minQuantity = 1 & maxQuantity = 100 & maxPetrolPrice = 6

VARIABLES quantitySpecified, cashAmount, litres, pumpAttached, fuelPumped, petrolPrice, pumpStatus

INVARIANT cashAmount:PUMP-->NAT & litres:PUMP-->NAT & petrolPrice:NAT & petrolPrice >= 0 & pumpAttached:PUMP-->PUMPATTACHED & fuelPumped:PUMP-->FUELPUMPED & quantitySpecified:PUMP-->QUANTITYSPECIFIED & pumpStatus:PUMP-->PUMPSTATUS

INITIALISATION quantitySpecified:=PUMP*{unspecified} || cashAmount:=PUMP*{0} || litres:=PUMP*{0} || pumpAttached:=PUMP*{unattached} || fuelPumped:=PUMP*{unpumped} || pumpStatus:=PUMP*{pumpFree} || petrolPrice:=2


OPERATIONS

SetPetrolPrice(price) = PRE price> 0 & price<=maxPetrolPrice THEN petrolPrice:=price END;

FreeUpPump(pp) = PRE pp:PUMP & pumpStatus(pp)=pumpOccupied THEN pumpStatus(pp):=pumpFree END;

OccupyPump(pp) = PRE pp:PUMP & pumpStatus(pp)=pumpFree THEN pumpStatus(pp):=pumpOccupied END;

InputCashAmount(amount, pp) = PRE pp:PUMP & pumpStatus(pp)=pumpOccupied & amount >= minQuantity & amount<= petrolPrice*maxQuantity & amount:NAT & amount/petrolPrice >= minQuantity & quantitySpecified(pp)=unspecified & fuelPumped(pp)=unpumped THEN cashAmount(pp):=amount || litres(pp):=amount/petrolPrice || quantitySpecified(pp):=specified END;

InputLitreQuantity(amount, pp) = PRE pp:PUMP & pumpStatus(pp)=pumpOccupied & amount:NAT & amount >= minQuantity & amount <= maxQuantity & quantitySpecified(pp)=unspecified & fuelPumped(pp)=unpumped THEN cashAmount(pp):=amount*petrolPrice || litres(pp):=amount || quantitySpecified(pp):=specified END;

ResetQuantity(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & fuelPumped(pp)=unpumped THEN cashAmount(pp):=0 || litres(pp):=0 || quantitySpecified(pp):=unspecified END;

AttachPump(pp) = PRE pp:PUMP & pumpStatus(pp)=pumpOccupied & quantitySpecified(pp)=specified & pumpAttached(pp)=unattached THEN pumpAttached(pp):=attached END;

RemovePump(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached THEN pumpAttached(pp):=unattached END;

PressLever(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached & fuelPumped(pp)=unpumped THEN 
IF reserveFuelAmount < litres(pp) THEN litres(pp):=reserveFuelAmount || cashAmount(pp):= reserveFuelAmount*petrolPrice || DispenseFromReserve(reserveFuelAmount) || fuelPumped(pp):=pumped
ELSE fuelPumped(pp):=pumped || DispenseFromReserve(litres(pp)) END END;

ResetPump(pp) = PRE pp:PUMP THEN quantitySpecified(pp):=unspecified || cashAmount(pp):=0 || litres(pp):=0 || pumpAttached(pp):=unattached || fuelPumped(pp):=unpumped END

END