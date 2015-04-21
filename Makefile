ifeq ($(DEBUG),1)
	CXXFLAGS += -std=c++14 -Wunused -Wall -Wextra -Wpedantic -I src/ -g
else
	CXXFLAGS += -std=c++14 -Wunused -Wall -Wextra -Wpedantic -I src/ -O3 -march=native -msse4 -mfpmath=sse -ffast-math -g
endif
ifeq ($(OS),Windows_NT)
	LDFLAGS += -lopengl32 -lglew32mx.dll -lglfw3 -lgdi32
	TMPPATH += .
else
	LDFLAGS  = -lglfw -lGLEW -lGL
	TMPPATH += /tmp
endif

voxelator: src/main.o src/ext/stb/stb_image_pre.o src/ext/stb/stb_image_write_pre.o
	$(CXX) $^ $(CXXFLAGS) $(LDFLAGS) -o $@

all: voxelator

apitrace: voxelator
	apitrace trace -o $(TMPPATH)/voxelator.trace ./voxelator
	qapitrace $(TMPPATH)/voxelator.trace

clean:
	find . -name '*.o' -type f -delete
	find . -name '*.trace' -type f -delete
	find . -name voxelator -type f -delete
	rm -f $(TMPPATH)/voxelator*.trace
