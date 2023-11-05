#!/data/miniconda3/envs/env1/bin/python

from filelock import FileLock
import hickle
import sys

# set constants
file_path = "/data/picasso/envlist.hkl"
lock_path = "/data/picasso/envlist.khl.lock"
time_out_secs = 60

# program modes
READ_MODE = 0
WRITE_MODE = 1
RESET_MODE = 2

# get number of arguments
nargs = len(sys.argv)
if nargs > 3:
    print('Usage: envlist; envlist env; envlist envprefix nenvs')
    exit
elif nargs > 2:
    pmode = RESET_MODE
    envprefix = sys.argv[1]
    nenvs = sys.argv[2]
elif nargs > 1:
    pmode = WRITE_MODE
    env = sys.argv[1]
else:
    pmode = READ_MODE
    env = None  # Initialize env


lock = FileLock(lock_path, timeout=time_out_secs)

with lock:
    # Check the value of pmode to determine the operation
    if pmode == RESET_MODE:
        # Convert nenvs to an integer
        nenvs = int(nenvs)
        # Create a list (named clist) of nenvs environments with the
        # prefix envprefix
        clist = [f"{envprefix}{i}" for i in range(nenvs)]
        print(clist)
        clist1 = [*range(0,int(nenvs),1)]
        clist = [envprefix + str(s) for s in clist1]
    else:
        # Load the list of environments from a file
        clist = hickle.load(file_path)

        if pmode == WRITE_MODE:
            # Append an item (env) to the end of the list
            clist.append(env)
        else:
            # Return the next environment from the list
            env = clist.pop(0)
            # append item to end of list
            clist.append(env)
        else:    
            # pop first item off list
            env = clist.pop(0)
            # return env name
            print(env)

    # Save the updated list of environments back to the file
    hickle.dump(clist, file_path, mode="w")
