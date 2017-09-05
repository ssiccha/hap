#####################################################
#####################################################
InstallGlobalFunction(TupleOrbitReps_perm,
function(A,Q,n,tester)
local orbs, neworbs, i, x, q, y, D, S, B;

orbs:=Orbits(A,Q);
orbs:=List(orbs,x->[[x[1]],Stabilizer(A,x[1])]);

for i in [2..n] do
neworbs:=[];
for x in orbs do
S:=x[2];
D:=[];

for q in Q do
y:=Concatenation(x[1],[q]);
Add(D,y);
od;

B:=Orbits(A,D,OnTuples);
B:=List(B,x->[x[1],Stabilizer(S,x[1],OnTuples)]);
Append(neworbs,B);

od;
orbs:=neworbs;
orbs:=Filtered(orbs,x->tester(x[1]));
od;

orbs:=List(orbs,x->x[1]);
return orbs;
end);
#####################################################
#####################################################

#####################################################
#####################################################
InstallGlobalFunction(TupleOrbitReps,
function(A,Q,n,tester)
local gens,N,permgens,elts,Aperm,a,p,orbs;

if IsPermGroup(A) then return TupleOrbitReps_perm(A,Q,n,tester); fi;


elts:=Elements(Q);
gens:=GeneratorsOfGroup(A );
N:=Size(Q);
permgens:=[];
for a in gens do
p:=List([1..N],i->Position(elts,elts[i]^a));
p:=PermList(p);
Add(permgens,p);
od;

Aperm:=Group(permgens);
permgens:=SmallGeneratingSet(Aperm);
Aperm:=Group(permgens);

orbs:=TupleOrbitReps_perm(Aperm,[1..N],n,tester);
return [orbs,Aperm];
end);
#####################################################
#####################################################

#####################################################################
#####################################################################
InstallGlobalFunction(NumberOfHomomorphisms_connected,
function(genRelK,Q)
local multTab,tester,A,T,nbGen,rels,RELS,r,n;

multTab:=MultiplicationTable(Q);
nbGen:=Length(genRelK.generators);
rels:=genRelK.relators;
RELS:=[];
for n in [1..nbGen] do
RELS[n]:=[];
od;
for r in rels do
Add(RELS[Maximum(Flat(r))], r);
od;

###########################
tester:=function(mapping)
local R,re,x,y,z;
R:=RELS[Length(mapping)];
for re in R do
x:=re[1][1];
y:=re[1][2];
z:=re[2];
if not mapping[z]=multTab[mapping[x]][mapping[y]] then return false; fi;
od;
return true;
end;
###########################

A:=AutomorphismGroupQuandle(Q);
T:=TupleOrbitReps(A,Q,nbGen,tester);
T:=List(T[1],x->Size(Orbit(T[2],x,OnTuples)));
return T;

end);
#####################################################################
#####################################################################
