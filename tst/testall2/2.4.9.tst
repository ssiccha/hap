#D
gap> START_TEST("HAP library");
gap> dir:=Filename(DirectoriesPackageLibrary("HAP","tst/testall")[1],"data249.txt");;
gap> Read(dir);
gap> G:=SymmetricMatrixToFilteredGraph(D,50,50);;
gap> K:=FilteredRegularCWComplex(CliqueComplex(G,2));
Filtered regular CW-complex of dimension 2

gap> #BarCodeCompactDisplay(PersistentBettiNumbers(K,1));;
gap> Y:=FiltrationTerm(K,15);
Regular CW-complex of dimension 2

gap> M:=ContractedComplex(HomotopyGraph(Y));
Graph on 41 vertices.

gap> #Display(M);
gap> STOP_TEST( "tst.tst", 1000 );


