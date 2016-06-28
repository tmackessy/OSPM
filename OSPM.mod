/*********************************************
 * OPL 12.4 Model
 * Oceanographic Sensor Placement Model (OSPM)
 * Author: Trevor Mackessy-Lloyd
 * Date: May 11, 2013
 *********************************************/

using CPLEX;

int NbCells = ...;
int NbNewSite = ...;

/*P*/int P = ...;

/*I*/range IRange = 1..NbCells;
/*J*/range JRange = 1..NbNewSite;

/*Ni*/{int} N[IRange] = ...;
/*Ai*/int A[IRange] = ...;

/*x(j)*/dvar int+ x[JRange] in 0..1;
/*y(i)*/dvar int+ y[IRange] in 0..1;

maximize
  sum(i in IRange)
    A[i] * y[i];

subject to {
	ct1:
		forall(i in IRange)
		  sum(j in N[i])
		    x[j] >= y[i];
	ct2:
		sum(j in JRange)
		  x[j] == P;
}

execute DISPLAY {
	var j2;
	for (j2 in JRange)
		if (x[j2]==1)
		writeln("j ", j2, " was chosen to install a sensor platform.");
}