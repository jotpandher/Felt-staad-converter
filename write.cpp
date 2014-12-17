#include "write.h"
	void write_function::write_function()
	
	{
	write_end_function("*",70)
	
	cout<<"Enter the name of output file:\n";
	cin>> file_name;
	input_file = file_na,e + ".flt";
	output_file = file_name + ".std";
	ofstream f(output_file.c_Str(), ios::out);
	}	

	void write_function::write_end_function(string symbol, int times)
{
	for(int n= 0; n< times; n++)
	{
	cout<< symbol;	
	}
	cout<<endl; 
}

	void write_function::writeFeltFile(std::string s)
{
	ofstream f(output_file.c_Str(), ios::app);
	if (s.compare("nodes")==0)
		{ f<<" JOINT COORDINATES";}
	else if (s.compare("beam elements")==0)
		{ f<<"MEMBER INCIDENCES";}
}
void write_function::writeFeltFile_Joint_coordinates(float s, char nodes)
{
	ofstream f(output_file.c_str(), ios::app);
	if (nodes=='x')
	f << s ;
	else (nodes=='y')
	f<< s;
	if else (nodes=='z')
	f<< s;}
