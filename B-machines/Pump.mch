MACHINE Pump

INCLUDES Reserve

PROMOTES AddToReserve

SETS PUMP; PUMPATTACHED={attached,unattached}; QUANTITYSPECIFIED={specified,unspecified}; FUELPUMPED={pumped, unpumped}; PUMPSTATUS={locked, unlocked}

CONSTANTS minQuantity, maxQuantity

PROPERTIES minQuantity = 1 & maxQuantity = 100

VARIABLES quantitySpecified, cashAmount, litres, pumpAttached, fuelPumped, petrolPrice, pumpStatus

INVARIANT cashAmount:PUMP-->NAT & litres:PUMP-->NAT & petrolPrice:NAT & petrolPrice >= 0 & pumpAttached:PUMP-->PUMPATTACHED & fuelPumped:PUMP-->FUELPUMPED & quantitySpecified:PUMP-->QUANTITYSPECIFIED & pumpStatus:PUMP-->PUMPSTATUS

INITIALISATION quantitySpecified:=PUMP*{unspecified} || cashAmount:=PUMP*{0} || litres:=PUMP*{0} || pumpAttached:=PUMP*{unattached} || fuelPumped:=PUMP*{unpumped} || pumpStatus:=PUMP*{locked} || petrolPrice:=2

OPERATIONS
SetPetrolPrice(price) = PRE price>= 0 THEN petrolPrice:=price END;
UnlockPump(pp) = PRE pp:PUMP & pumpStatus(pp)=locked THEN pumpStatus(pp):=unlocked END;
LockPump(pp) = PRE pp:PUMP & pumpStatus(pp)=unlocked THEN pumpStatus(pp):=locked END;
InputCashAmount(amount, pp) = PRE pp:PUMP & pumpStatus(pp)=unlocked & amount >= minQuantity & amount:NAT & amount/petrolPrice >= minQuantity & quantitySpecified(pp)=unspecified THEN cashAmount(pp):=amount || litres(pp):=amount/petrolPrice || quantitySpecified(pp):=specified END;
InputLitreQuantity(amount, pp) = PRE pp:PUMP & pumpStatus(pp)=unlocked & amount:NAT & amount >= minQuantity & quantitySpecified(pp)=unspecified THEN cashAmount(pp):=amount*petrolPrice || litres(pp):=amount || quantitySpecified(pp):=specified END;
ResetQuantity(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified THEN cashAmount(pp):=0 || litres(pp):=0 || quantitySpecified(pp):=unspecified END;
AttachPump(pp) = PRE pp:PUMP & pumpStatus(pp)=unlocked & quantitySpecified(pp)=specified & pumpAttached(pp)=unattached THEN pumpAttached(pp):=attached END;
RemovePump(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached THEN pumpAttached(pp):=unattached END;
PressLever(pp) = PRE pp:PUMP & quantitySpecified(pp)=specified & pumpAttached(pp)=attached & fuelPumped(pp)=unpumped THEN 
IF reserveFuelAmount < litres(pp) THEN litres(pp):=reserveFuelAmount || cashAmount(pp):= reserveFuelAmount*petrolPrice || DispenseFromReserve(reserveFuelAmount) || fuelPumped(pp):=pumped
ELSE fuelPumped(pp):=pumped || DispenseFromReserve(litres(pp)) END END;
ResetPump(pp) = PRE pp:PUMP THEN quantitySpecified(pp):=unspecified || cashAmount(pp):=0 || litres(pp):=0 || pumpAttached(pp):=unattached || fuelPumped(pp):=unpumped END
END