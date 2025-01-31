gap> START_TEST("HAP library");
gap> dir:=Filename(DirectoriesPackageLibrary("HAP","tst/examples")[1],"data1V2X.pdb");;
gap> K:=ReadPDBfileAsPurePermutahedralComplex(dir);
Reading chain containing 191 atoms.
Pure permutahedral complex of dimension 3.

gap> G:=KnotGroup(K);
#I  there are 2 generators and 1 relator of total length 6
<fp group of size infinity on the generators [ f1, f2 ]>
gap> RelatorsOfFpGroup(G);
[ f2^-1*f1*f2*f1*f2^-1*f1^-1 ]
gap> STOP_TEST( "tst.tst", 1000 );


