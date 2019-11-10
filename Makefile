# project name (generate executable with this name)
TARGET   = tips
#target arguments

CC       = /usr/bin/gcc
# compiling flags here
CFLAGS   = -g -Wall -std=c99 `pkg-config --cflags gtk+-2.0`

LINKER   = /usr/bin/gcc
# linking flags here
LFLAGS   = -g -Wall -std=c99 `pkg-config --libs gtk+-2.0` 

# change these to proper directories where each file should be
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

# compile source files
SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

# linux commands
rm       = rm -f
mkdir 	 = mkdir -p


$(BINDIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	@$(LINKER) $(OBJECTS) $(LFLAGS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"


###########
# Rules
##########
.PHONY: clean remove debug run 

clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!

debug:
	 cgdb --args $(BINDIR)/$(TARGET) -r -m $(SRCDIR)/$(TARGS4)

run:
	@echo 
	 $(BINDIR)/$(TARGET)

