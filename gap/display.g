# Functions to display Deep Thought polynomials/DTobj
# To display a DTobj use 
#		DTP_Display_DTobj(DTobj).
#
# Display polynomials only: 
# When using the function DTP_DTpols_rs, call 
#		DTP_Display_f_r(DTP_DTpols_rs(...)[2])
# When using the function DTP_DTpols_r, call 
#		DTP_Display_f_r(DTP_DTpols_r(...)[2])

# TODO: Write function that maps DT pols to polynomials in GAP and let
# GAP expand the polynomials. 

#############################################################################

DTP_Display_Variable := function(k, n)
	if k <= n then
		Print("X_", k);
	else
		Print("Y_", k - n);
	fi;
end; 

DTP_Display_summand := function(summand, n)
	local i; 
	if summand[1] <> 1 then
		Print(summand[1], " * ");
	fi; 
	for i in [2 .. Length(summand)] do 
		if summand[i][2] = 1 then
			DTP_Display_Variable(summand[i][1], n); 
			Print(" "); 
		else	
			Print("Binomial("); 
			DTP_Display_Variable(summand[i][1], n);
			Print(", ", summand[i][2] , ") "); 
		fi; 
	od; 
end; 

# displays output of DTP_DTpols_r_S()
DTP_Display_f_r_S := function(f_r_S)
	local r, i, n; 
	
	if f_r_S = fail then 
		return; 
	fi;
	
	n := Length(f_r_S); 
	
	for r in [1 .. n] do
		Print("f_", r, ",s = ");
		if Length(f_r_S[r]) = 1 then
			DTP_Display_summand(f_r_S[r][1], n);
			Print("\n"); 
		else
			i := 1; 
			for i in [1 .. (Length(f_r_S[r]) - 1)] do
				DTP_Display_summand(f_r_S[r][i], n);
				Print("+ ");
			od; 
			DTP_Display_summand(f_r_S[r][i + 1], n); 
			Print("\n");
		fi;
	od;
	
end;

# display output of function DTP_DTpols_rs(...)[2]
InstallGlobalFunction( DTP_Display_f_rs, 
function(f_rs)
	local s;
	for s in [1 .. Length(f_rs)] do
		Print("Polynomials f_rs for s = ", s, ":\n"); 
		DTP_Display_f_r_S(f_rs[s]); 
	od; 
end);

# displays output of function DTP_DTpols_r(...)[2]
InstallGlobalFunction( DTP_Display_f_r, 
function(f_r)
	local r, i, n; 
	
	if f_r = fail then 
		return; 
	fi; 
	
	n := Length(f_r); 
	
	for r in [1 .. n] do
		Print("f_", r, " = ");
		if Length(f_r[r]) = 1 then
			DTP_Display_summand(f_r[r][1], n);
			Print("\n"); 
		else
			for i in [1 .. (Length(f_r[r]) - 1)] do
				DTP_Display_summand(f_r[r][i], n);
				Print("+ ");
			od; 
			DTP_Display_summand(f_r[r][i + 1], n); 
			Print("\n");
		fi;
	od;
	
end);

# display a DTobj
InstallGlobalFunction( DTP_Display_DTobj, 
function(DTobj)

	if DTobj[4] then 
		Print("Generator orders of the consistent collector:\n", DTobj[3], "\n\n"); 
	else
		Print("The polynomials were computed with isConfl=false. No generator orders were computed.\n\n"); 
	fi; 
	
	if IsInt(DTobj[2][1][1][1]) then 
		DTP_Display_f_r(DTobj[2]); 
	else
		DTP_Display_f_rs(DTobj[2]); 
	fi; 

end); 