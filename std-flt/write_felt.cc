#include "write_felt.h"

write::write() {
	jc_count = 0;	/** counts no of nodes jc_count
			* counts no of beam elements mi_count */
	mi_count = 0;
}

void write::store_values(char nodes_beams, float value, int i) {
	if (nodes_beams == 'n') {				/** function to count no of nodes and beams */
	    jc[i] = value;
	    jc_count++;
	} else if (nodes_beams == 'b') {
	    mi[i] = value;
	    mi_count++;
	}
}

void write::write_description(string f_name) {			/** function to write header of std file */
	out_file = f_name;
	ofstream f(out_file.c_str(), ios::out);
	f << "problem description" << endl;
}

void write::write_title() {
	ofstream f(out_file.c_str(), ios::app);			/** function to write title of std file*/
	f << "title=\"Truss sample problem\"" << endl;
}

void write::total_node_beam() {
	ofstream f(out_file.c_str(), ios::app);

	int nodes, elements;					/** function to count serial no for nodes and beams*/
	nodes = jc_count/3;
	elements = mi_count/2;
	f << "nodes=" << nodes << " elements=" << elements << endl;
}

void write::write_nodes() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "nodes" << endl;

	for (int j = 0, i = 1; j < jc_count; j++) {		/** function for writing nodes*/
	    if (j % 3 == 0) {
		f << i << "  x=" << jc[j];
	    } else if (j % 3 == 1) {
		f << " y=" << jc[j];
	    } else if (j % 3 == 2) {
		if (i == 1) {
		   f << " z=" << jc[j] << "  constraint=free" << endl;
		} else if (i == 2) {
                   f << " z=" << jc[j] << "  constraint=fixed" << endl;
		} else {
		   f << " z=" << jc[j] << endl;
		}
		i++;
	    }
	}
}

void write::write_beams() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "truss elements" << endl;				/** function to write beams*/

        for (int j = 0, i = 1; j < mi_count; j++) {
	    if (j % 2 == 0) {
		f << i << "  nodes=[" << mi[j];
	    } else if (j % 2 == 1) {
		if (i == 1) {
		   f << "," << mi[j] << "]  material=steel" << endl;
		} else {
		   f << "," << mi[j] << "]" << endl;
		}
		i++;
	    }
	}
}

void write::write_material() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "material properties" << endl;		/** function to write properties*/
	f << "steel  E=2.1e+11 A=0.0004 Ix=0 Iy=0 Iz=0 J=0 G=0 nu=0 t=0 rho=1 kappa=0" << endl;
}

void write::write_constraints() {
	ofstream f(out_file.c_str(), ios::app);
	f << endl << "constraints" << endl;			/** function to write constraints*/
	f << "free  tx=u ty=u tz=c rx=u ry=u rz=u" << endl;
	f << "fixed  tx=c ty=c tz=c rx=u ry=u rz=u" << endl;
}

void write::write_forces() {
	ofstream f(out_file.c_str(), ios::app);
	f << "forces" << endl;				/** function to write forces */
	f << "" << endl;
}
void write::write_data() {
	total_node_beam();
	write_nodes();
	write_beams();
	write_material();
	write_constraints();				/** call all functions */
}


void write::write_end_file() {
	ofstream f(out_file.c_str(), ios::app);			/** function to end of file */
	f << endl << "end";
}
