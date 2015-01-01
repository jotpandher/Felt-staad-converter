#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <string>
#include <fstream>

using namespace std;

class Write_function
{
	string input_file, output_file, file_name;

	public:
	int ch;

	void write_function();
	void writeFeltFile_Joint_coordinates(float s, char nodes);
	void write_end_function(string symbol, int times);
	void writeFeltFile(std::string s);
};
#endif
