#include "write.h"
	void Write_function::write_function()
	{
		cout<<"\nOUTPUT FILE GENERATED IS: staad_file.std\n";
		/*cin>> file_name;
		input_file = file_name + ".flt";
		output_file = file_name + ".std";
		ofstream f(output_file.c_str(), ios::out);
		*/
	}	

	void Write_function::write_end_function(string symbol, int times)
	{
		for(int n= 0; n< times; n++)
		{
			cout<< symbol;	
		}
		cout<<endl; 
	}

	void Write_function::writeFeltFile(std::string s)
	{
		ofstream f(output_file.c_str(), ios::app); //c_str() ????
		
		if (s.compare("nodes")==0)
		{ 
			f<<" JOINT COORDINATES";
		}
		else if (s.compare("beam elements")==0)
		{ 
			f<<"MEMBER INCIDENCES";
		}
	}

	void Write_function::writeFeltFile_Joint_coordinates(float s, char nodes)
	{
		cout<<"***********shaina************";
		ofstream f(output_file.c_str(), ios::app);
		if (nodes=='x')
			f<<s;
		else if(nodes=='y')
			f<< s;
		 else if(nodes=='z')
			f<< s;
		f.close();
	}


