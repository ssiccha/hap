HAPchildren:=[];


####################################################
####################################################
InstallGlobalFunction(ChildProcess,
function(arg)
local d,f,s,Name,Remote,Computer,tmpdir;
d:= DirectoryCurrent();

if Length(arg)=0 then 
Remote:=false;
Computer:="localhost";
f := Filename(DirectoriesSystemPrograms(), "gap");
s := InputOutputLocalProcess(d,f,["-T","-q","-b"]);
else
Remote:=true;
Computer:=arg[1];
f:=Filename(DirectoriesSystemPrograms(),"ssh");
s := InputOutputLocalProcess(d,f,[arg[1],"gap","-f","-T","-q","-b"]);
fi;

#WriteLine(s,"SizeScreen([255,24]);");

#Name:=Concatenation(["/tmp/HAPchild",String(1+Length(HAPchildren))]);
tmpdir := DirectoryTemporary();;
Name:=Filename( tmpdir, String(1+Length(HAPchildren)) );


Add(HAPchildren,Name);
PrintTo(Name,"HAPchildToggle\:=true;");

return rec(
	stream:=s,
	name:=Name,
	number:=Length(HAPchildren),
	remote:=Remote,
	computer:=Computer);
end);
####################################################
####################################################

####################################################
####################################################
InstallGlobalFunction(ChildClose,
function(s);
CloseStream(s.stream);
PrintTo(s.name,"HAPchildToggle\:=false;");
end);
####################################################
####################################################

####################################################
####################################################
InstallGlobalFunction(ChildFunction,
function(func,s)
local i;

PrintTo(s.name,"HAPchildToggle\:=false;");
WriteLine(s.stream,"\"STOP\";");;
i:=0;
while true do 			#FLUSH THE CHILD
if not i="\"STOP\"\n" then
i:=ReadAllLine(s.stream,true);
else break; fi;
od;

i:=Concatenation(["\"START\";xyxy:=",func,"\"STOP\";"]);
WriteLine(s.stream,i);;

i:=Concatenation(["PrintTo(\"",String(s.name),"\",\"HAPchildToggle\:=true;\");"]);
WriteLine(s.stream,i);;
end);
####################################################
####################################################

####################################################
####################################################
InstallGlobalFunction(ChildCommand,
function(command,s)
local i;

PrintTo(s.name,"HAPchildToggle\:=false;");
Append(command,";");

WriteLine(s.stream,command);;
i:=Concatenation(["PrintTo(\"",String(s.name),"\",\"HAPchildToggle\:=true;\");"]);
WriteLine(s.stream,i);;

end);
####################################################
####################################################

####################################################
####################################################
InstallGlobalFunction(ChildRead,
function(s)
local i,output;

while true do
i:=ReadAllLine(s.stream,true); 
if  i="\"START\"\n" then 
fi;break; 
od;

if not s.remote then i:=(ReadAllLine(s.stream,true));fi;
i:=(ReadAllLine(s.stream,true));

output:="";
while true do
if not i="\"STOP\"\n" then 
Append(output,i);
i:=(ReadAllLine(s.stream,true)); 
else break; fi;
od;

return output;

end);
#####################################################
#####################################################

#####################################################
#####################################################
InstallGlobalFunction(ChildReadEval,
function(s);
return EvalString(ChildRead(s));
end);
#####################################################
#####################################################


#####################################################
#####################################################
InstallGlobalFunction(ChildPut,
function(X,Name,s)
local i;

NextAvailableChild([s]); #Don't start if s is busy.

PrintTo(s.name,"HAPchildToggle\:=false;");

PrintTo("/tmp/tmpPut.txt",Concatenation(Name,":="));
AppendTo("/tmp/tmpPut.txt",X);
AppendTo("/tmp/tmpPut.txt",";");

if s!.remote then
        i:=Concatenation(["sftp ",s!.computer," /tmp/tmpPut.txt "]);
        Exec(i);
        fi;

i:="Read(\"/tmp/tmpPut.txt\");";
ChildCommand(i,s);
end);
#####################################################
#####################################################

HAP_XYXYXYXY:=0;
#####################################################
#####################################################
InstallGlobalFunction(ChildGet,
function(X,s)
local i;

NextAvailableChild([s]); #Don't start if s is busy.

PrintTo(s.name,"HAPchildToggle\:=false;");

i:="PrintTo(\"/tmp/tmpGet.txt\", \"HAP_XYXYXYXY:=\");";
WriteLine(s.stream,i);
#ChildCommand(i,s);
#NextAvailableChild([s]);

i:=Concatenation("AppendTo(\"/tmp/tmpGet.txt\"," ,  X,");");

ChildCommand(i,s);
NextAvailableChild([s]);

PrintTo(s.name,"HAPchildToggle\:=false;");

if s!.remote then 
i:=Concatenation(["ssh ",s!.computer," less /tmp/tmpGet.txt > /tmp/tmpGet.txt"]);
fi;

AppendTo("/tmp/tmpGet.txt",";");

Read("/tmp/tmpGet.txt");
i:=Concatenation(["PrintTo(\"",String(s.name),"\",\"HAPchildToggle\:=true;\");"]);
WriteLine(s.stream,i);;

return HAP_XYXYXYXY;

end);
#####################################################
#####################################################






HAPchildToggle:=false;

#####################################################
#####################################################
InstallGlobalFunction(NextAvailableChild,
function(L)
local
	s,i;

while true do

	for s in L do
	if s!.remote then 
	i:=Concatenation(["ssh ",s!.computer," less ",s!.name," > ",s!.name]);
	Exec(i);
	fi;
	Read(s!.name);
	if HAPchildToggle=true then
	return s; break; fi;
	od;

	Exec("sleep 0.01");
od;
end);
#####################################################
#####################################################

#####################################################
#####################################################
InstallGlobalFunction(IsAvailableChild,
function(s)
local x;

Read(s!.name);

if HAPchildToggle then return true;
else return false;
fi;

end);
#####################################################
#####################################################

#####################################################
#####################################################
InstallGlobalFunction(ParallelList,
function(lst,func,processes)
local
	ind,s,i,j,kk,answer,final,cnt,f,prm1,prm2;

answer:=[];
prm1:=[];
prm2:=[];
cnt:=1;

for i in lst{[1..Length(processes)]} do
f:=Concatenation([func,"(",String(i),");"]);
ChildFunction(f,processes[cnt]);
Add(prm1,processes[cnt].number);
cnt:=cnt+1;
od;

for i in lst{[1+Length(processes)..Length(lst)]} do
s:=NextAvailableChild(processes);
Add(answer,ChildReadEval(s));
Add(prm2,s.number);
f:=Concatenation([func,"(",String(i),");"]);
ChildFunction(f,s);
Add(prm1,s.number);

od;

for s in processes do
Add(answer,ChildReadEval(s));
Add(prm2,s.number);
od;

#Reorder the answer
ind:=SSortedList(prm1);
final:=[];
cnt:=[];
for i in ind do
cnt[i]:=0;
od;

for i in [1..Length(prm1)] do
cnt[prm1[i]]:=cnt[prm1[i]] + 1;
final[i]:=answer[PositionNthOccurrence(prm2,prm1[i],cnt[prm1[i]])];

od;

return final;
end);
#####################################################
#####################################################
