# SeniorTestAutomationEngineer-Testcase
## To run the tests localy
in order to run the tests localy you need to instal 
firefox and robotframework with selenium library. Open concole in the root project dir and run commands
```
cd robot
mkdir output 
robot --variablefile variable_file.py -d output testcase.robot 
```
## run tests in docker
Open concole in the root project dir and run commands
```
cd Docker
sudo docker build --network host -t robot-firefox .
cd ..
sudo docker run -v `pwd`/robot:/project robot-firefox bash -c " mkdir /project/test_output;robot --variablefile  project/variable_file.py -d /project/test_output/ project/robot/"
```
