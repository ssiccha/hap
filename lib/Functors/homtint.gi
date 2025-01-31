
########################################################
########################################################
InstallGlobalFunction(HomToInt_ChainComplex,
function(C)
local D, DimensionD, BoundaryD, BoundaryDrec, len, n, k,i, A;

################################
################################
if not IsHapChainComplex(C) then
Print("Error: input must be a chain complex.\n");
return fail;
fi;

if not EvaluateProperty(C,"characteristic")=0 then
Print("Error: chain complex must have characteristic 0.\n"); 
return fail;
fi;
################################
################################

len:=Length(C);
BoundaryDrec:=[];

################################
################################
DimensionD:=function(n);
if n<0 or n>len then return 0; fi;

return C!.dimension(n);
end;
################################
################################

#for n in [1..len] do
#for k in [1..C!.dimension(n)] do
#C!.boundary(n,k);
#od;
#od;

#######################
BoundaryD:=function(n,k);
if n<0 or n>=len then return [0]; fi;

if not IsBound(BoundaryDrec[n+1]) then
A:=BoundaryMatrix(C,n+1);
if Length(A)=0 then A:=List([1..C!.dimension(n)],x->[0]); fi;   
BoundaryDrec[n+1]:=A;
fi;

return BoundaryDrec[n+1][k];
end;
#######################

D:=Objectify(HapCochainComplex,
                rec(
                dimension:=DimensionD,
                boundary:=BoundaryD,
                properties:=
                [["length",len],
                ["type", "cochainComplex"],
                ["characteristic",0 ] ]));

return D;

end);
###############################################################
###############################################################

########################################################
########################################################
InstallGlobalFunction(HomToInt_CochainComplex,
function(C)
local D, DimensionD, BoundaryD, BoundaryDrec, len, n, k,i, A;

################################
################################
if not IsHapCochainComplex(C) then
Print("Error: input must be a cochain complex.\n");
return fail;
fi;

if not EvaluateProperty(C,"characteristic")=0 then
Print("Error: cochain complex must have characteristic 0.\n");
return fail;
fi;
################################
################################

len:=Length(C);
BoundaryDrec:=[];

################################
################################
DimensionD:=function(n);
if n<0 or n>len then return 0; fi;

return C!.dimension(n);
end;
################################
################################

#for n in [1..len] do
#for k in [1..C!.dimension(n)] do
#C!.boundary(n,k);
#od;
#od;

#######################
BoundaryD:=function(n,k);
if n<0 or n>len then return [0]; fi;

if not IsBound(BoundaryDrec[n]) then
A:=BoundaryMatrix(C,n-1);
if Length(A)=0 then A:=List([1..C!.dimension(n)],x->[0]); fi;
BoundaryDrec[n]:=A;
fi;

return BoundaryDrec[n][k];
end;
#######################

D:=Objectify(HapChainComplex,
                rec(
                dimension:=DimensionD,
                boundary:=BoundaryD,
                properties:=
                [["length",len],
                ["type", "chainComplex"],
                ["characteristic",0 ] ]));

return D;

end);
###############################################################
###############################################################


##########################################
##########################################
InstallGlobalFunction(HomToInt_ChainMap,
function(arg)
local F,S, T, HS, HT, HF, HThomHS, zero,n,sparsemap;

F:=arg[1];
S:=Source(F);
HS:=HomToIntegers(S);
T:=Target(F);
HT:=HomToIntegers(T);

zero:=[];
for n in [1..Length(S)+1] do
zero[n]:=0*[1..S!.dimension(n-1)];
od;

#################
HThomHS:=function(v,n)
local rowA, ans, k;

rowA:=StructuralCopy(zero[n+1]);
ans:=StructuralCopy(zero[n+1]);;

for k in [1..Length(ans)] do
rowA[k]:=1;
ans[k]:=v*F!.mapping(rowA,n);
rowA[k]:=0;
od;
return ans;
end;
#################

#################
sparsemap:=function(v,n)
local ans, rowA, k, f, x;

rowA:=StructuralCopy(zero[n+1]);
ans:=StructuralCopy(zero[n+1]);;

for k in [1..Length(ans)] do
rowA[k]:=1;
f:= F!.mapping(rowA,n);
rowA[k]:=0;
  for x in v do
  ans[k]:=ans[k]+x[2]*f[x[1]]*SignInt(x[1]);
  od;
od;
return ans;
end;
#################


return Objectify(HapCochainMap,
        rec(
           source:=HT,
           target:=HS,
           mapping:=HThomHS,
           sparseMap:=sparsemap,
           properties:=[ ["type","cochainMap"],
           ["characteristic", Maximum(
           EvaluateProperty(F!.source,"characteristic"),
           EvaluateProperty(F!.target,"characteristic"))]
           ]));

end);
##########################################
##########################################
