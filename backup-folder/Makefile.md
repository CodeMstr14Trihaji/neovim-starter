CXX       = clang++
CXXFLAGS  = --debug

SRC    = code.cpp
TARGET = code

.PHONY: all run clean

all: $(TARGET)

# Compile code.cpp → code.exe (named 'code')
$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) $< -o $@

# Jalankan executable
run: $(TARGET)
	@echo Running $(TARGET)...
	./$(TARGET)

# Bersihkan hasil build
clean:
	-taskkill /f /im code.exe >nul 2>&1
	if exist $(TARGET).exe del /q $(TARGET).exe

