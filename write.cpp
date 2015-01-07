#include "write.h"

	void write::write_function()
	{
		cout<<"\nOUTPUT FILE GENERATED IS: staad_file.std\n";
	}	

	void write::write_staad_file()
	{
		time_t now = time(0);
       		char* dt = ctime(&now);
		ofstream f(output_file.c_str(), ios::out); 
	f<< "STAAD SPACE\n""START JOB INFORMATION\n""ENGINEER DATE "<< dt <<"END JOB INFORMATION\n""INPUT WIDTH 79\n""UNIT METER KN"<<endl;
		}

	void write::write_join_coordinates()
	{
		ofstream f(output_file.c_str(), ios::out);
		f<<"JOINT COORDINATES"<<endl;
		
		for (int i=1, j=1; j <= jc_count; i++)
		{ 		f<< j <<" ";
		 	f<< "x=" <<" " << "y=" << " "<< "z=" <<";";
			j++;
		}
			f<< endl;
}	
	
	void write::write_member_incidences()
	{
		ofstream f(output_file.c_str(), ios::app);
		f<<"MEMBER INCIDENCES"<<endl;
		for (int i=1, j=1; j<= mi_count; i++)
		{ f<< j << " " << "beam_x[i]" << " " << "beam_y[i]" << ";" ;
		}
			f << endl;

	}

	void write::write_end_file() 
	{
		ofstream f(output_file.c_str(), ios::app);
		f << endl << "FINISH";
	}	

