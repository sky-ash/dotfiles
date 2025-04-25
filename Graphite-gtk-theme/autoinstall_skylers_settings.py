# this small python script is meant to execute the install.sh script with my preconfigured parameters


import os
import subprocess




destination = os.path.expanduser("~/.themes/")
if not os.path.exists(destination):
    os.makedirs(destination)





def get_install_script_path():
    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct the path to the install.sh script
    install_script_path = os.path.join(script_dir, "install.sh")

    if not os.path.exists(install_script_path):
        print(f"Error: {install_script_path} does not exist.")
        return
    # Check if the install.sh script is executable
    if not os.access(install_script_path, os.X_OK):
        print(f"Error: {install_script_path} is not executable.")
        return

    return install_script_path

def run_install_script(libadwaita=False, name=None, tweaks=None, color=None, install_script_path=None):
    if install_script_path is None:
        install_script_path = get_install_script_path()
        if install_script_path is None:
            return

    command = []
    command.append(install_script_path)


    # Add the libadwaita flag if specified
    if libadwaita:
        command.append("--libadwaita")

    # Add the name flag if specified
    if name:
        command.append(f"--name {name}")

    # Add the colors flag if specified
    if color:
        command.append(f"--color {color}")

    # Add the tweaks flag if specified
    if tweaks:
        tweaks_str = " ".join(tweaks)
        command.append(f"--tweaks {tweaks_str}")

    print(f"Executing command: \n{' '.join(command)}")
    subprocess.run(command)






    

if __name__ == "__main__":

    tweaks = ["black", "normal", "rimless"]
    run_install_script(True, "BLACKOUT", tweaks)
    
    #run_install_script(False, "BLACKOUT", tweaks)
    #run_install_script(True)