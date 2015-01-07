#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>

using namespace std;

class write
{
	string input_file, output_file, file_name;
	float jc[1024], mi[1024];
	int jc_count, mi_count;
	

	public:

	void write_function();
	void write_staad_file();
	void write_join_coordinates();
	void write_member_incidences();
	void write_end_file();
};
#endif
