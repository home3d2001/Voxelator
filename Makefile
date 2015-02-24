CXXFLAGS = -std=c++14 -Wall -Wextra -I src/ -g
LDFLAGS  = -lglfw -lGLEW -lGL

voxelator: src/main.o
	$(CXX) $^ $(CXXFLAGS) $(LDFLAGS) -o $@

all: voxelator

apitrace: clean voxelator
	apitrace trace ./voxelator
	qapitrace voxelator.trace

clean:
	find . -name '*.o' -type f -delete
	find . -name '*.trace' -type f -delete
	find . -name voxelator -type f -delete