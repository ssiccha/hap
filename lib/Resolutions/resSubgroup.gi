#(C) Graham Ellis, 2005-2006

#####################################################################
InstallGlobalFunction(ResolutionFiniteSubgroup,
function(arg)
local 
		R,gensG,gensK,
		DimensionR, BoundaryR, HomotopyR, EltsG,
		Dimension, Boundary, BoundaryRec, Homotopy, EltsK,
		G, K, TransK, sK,
		Gword2Kword, G2K, Pair2Int, Int2Pair,
		Mult, FIN, i;
		
if Length(arg)=3 then
R:=arg[1]; gensG:=arg[2]; gensK:=arg[3];
fi;
if Length(arg)=2 then
R:=arg[1]; gensG:=R!.group; gensK:=arg[2];
fi;
				#gensG and gensK originally had to be
				#generating sets. Later I allowed them to be
				#the groups G, K themselves. Sloppy!
DimensionR:=R!.dimension;
BoundaryR:=R!.boundary;
HomotopyR:=R!.homotopy;
EltsG:=R!.elts;

if IsList(gensG) then G:=Group(gensG); else G:=gensG; fi;
if IsList(gensK) then K:=Group(gensK); else K:=gensK; fi;
if Size(G)=Length(EltsG) then FIN:=true; else FIN:= false; fi;
if FIN then EltsK:=Elements(K);
else
EltsK:=[];
fi;

TransK:=RightTransversal(G,K);
sK:=Size(TransK);

if FIN then
#####################################################################
Mult:=function(i,j);
return Position(EltsG,TransK[i]*EltsG[j]);
end;
#####################################################################
else
#####################################################################
Mult:=function(i,j) local x,r;
x:=TransK[i]*EltsG[j];
r:=Position(EltsG,x);
if r=fail then Add(EltsG,x); r:=Length(EltsG); fi;
return r;
end;
#####################################################################
fi;

#####################################################################
Dimension:=function(n);
return sK*DimensionR(n);
end;
#####################################################################

if FIN then
#####################################################################
G2K:=function(g)
local t,k;
t:=PositionCanonical(TransK,EltsG[g]);
k:=Position(EltsK,EltsG[g]*TransK[t]^-1);
return [k,t];
end;
#####################################################################
else
#####################################################################
G2K:=function(g)
local t,k,x;
t:=PositionCanonical(TransK,EltsG[g]);
x:=EltsG[g]*TransK[t]^-1;
k:=Position(EltsK,x);
if k=fail then Add(EltsK,x); k:=Length(EltsK); fi;
return [k,t];
end;
#####################################################################
fi;

#####################################################################
Pair2Int:=function(x)
local i,t;
i:=x[1]; t:=x[2];
return SignInt(i)*((AbsoluteValue(i)-1)*sK + t);
end;
#####################################################################

#####################################################################
Int2Pair:=function(i)
local j,k, x;
j:=AbsoluteValue(i);
x:=j mod sK;
k:=(j-x)/sK;
if not x=0 then return [SignInt(i)*(k+1),x]; else
return [SignInt(i)*k,sK]; fi;
end;
#####################################################################

#####################################################################
Gword2Kword:=function(w)
local x, y, v;

v:=[];
for x in w do
y:=G2K(x[2]);
y:=[Pair2Int([x[1],y[2]]),y[1]];
Append(v,[y]);
od;
return v;
end;
#####################################################################

BoundaryRec:=[];
for i in [1..EvaluateProperty(R,"length")] do
BoundaryRec[i]:=[];
od;

#####################################################################
Boundary:=function(n,i)
local x, w, nn;

nn:=AbsInt(n);
if not IsBound(BoundaryRec[nn][i]) then
x:=Int2Pair(i);
w:=StructuralCopy(BoundaryR(nn,x[1]));
Apply(w, y->[y[1],Mult(x[2],y[2])]);
#Apply(w, y->[y[1],Position(EltsG,TransK[x[2]]*EltsG[y[2]])   ]); #Changed this back but forgot why this line was ever here!!
BoundaryRec[nn][i]:= Gword2Kword(w);
fi;

if n>0 then return BoundaryRec[nn][i]; fi;
return NegateWord(BoundaryRec[nn][i]);
end;
#####################################################################

######################
Homotopy:=function(n,e)
local x,g,pos;
x:=Int2Pair(e[1]);
#g:=TransK[x[2]]*EltsK[e[2]];
g:=EltsK[e[2]]*TransK[x[2]]; #Need to chack the maths again here!
pos:=Position(EltsG,g);
if pos =fail then Add(EltsG,g); pos:=Length(EltsG);fi;
return Gword2Kword( R!.homotopy(n,[x[1],pos]));
end;
######################

return Objectify(HapResolution,
	     rec(
	     dimension:=Dimension,
	     boundary:=Boundary,
	     homotopy:=Homotopy,
	     elts:=EltsK,
	     group:=K,
	     properties:=
	     [["length",EvaluateProperty(R,"length")],
	      ["characteristic",EvaluateProperty(R,"characteristic")],
	      ["reduced",false],
	      ["type","resolution"] ]));
end);
#####################################################################


