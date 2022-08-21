MACHINE Pump
INCLUDES Reserve
CONSTANTS minQuantity, maxQuantity, petrolPrice
PROPERTIES minQuantity = 1 & maxQuantity = 100 & petrolPrice = 2
VARIABLES quantitySpecified, cashAmount, litres, pumpAttached, transactionActive, fuelPumped
INVARIANT quantitySpecified:BOOL & cashAmount:NAT & cashAmount >= 0 & litres:NAT & litres >= 0 & pumpAttached:BOOL & transactionActive:BOOL & fuelPumped:BOOL
INITIALISATION quantitySpecified:=FALSE || cashAmount:=0 || litres:=0 || pumpAttached:=FALSE || transactionActive:=FALSE || fuelPumped:=FALSE
OPERATIONS
StartTransaction = PRE transactionActive=FALSE THEN transactionActive:=TRUE || litres:=0 || cashAmount:=0 || quantitySpecified:=FALSE || fuelPumped:=FALSE END;
InputCashAmount(amount) = PRE amount:NAT & amount/petrolPrice >= minQuantity & quantitySpecified=FALSE & transactionActive=TRUE THEN cashAmount:=amount || litres:=amount/petrolPrice || quantitySpecified:=TRUE END;
InputLitreQuantity(amount) = PRE amount:NAT & amount >= minQuantity & quantitySpecified=FALSE & transactionActive=TRUE THEN cashAmount:=amount*petrolPrice || litres:=amount || quantitySpecified:=TRUE END;
ResetQuantity = PRE quantitySpecified=TRUE THEN cashAmount:=0 || litres:=0 || quantitySpecified:=FALSE END;
AttachPump = PRE quantitySpecified=TRUE & pumpAttached=FALSE THEN pumpAttached:=TRUE END;
RemovePump = PRE quantitySpecified=TRUE & pumpAttached=TRUE THEN pumpAttached:=FALSE END;
PressLever = PRE quantitySpecified=TRUE & pumpAttached=TRUE THEN 
IF CurrentFuelAmount < litres THEN litres:=CurrentFuelAmount || cashAmount:= CurrentFuelAmount*petrolPrice || DispenseFromReserve(CurrentFuelAmount) || fuelPumped:=TRUE ELSE fuelPumped:=TRUE || DispenseFromReserve(llitres) END END;
EndTransaction = PRE fuelPumped=TRUE THEN transactionActive:=FALSE END
END





