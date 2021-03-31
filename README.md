# SeniorTestAutomationEngineer-Testcase
## To run the tests localy
in order to run the tests localy you need to instal 
firefox and robotframework with selenium library
<code>
cd robot
mkdir output 
robot --variablefile variable_file.py -d output testcase.robot 
</code>
##run tests in docker
<code>
cd Docker
sudo docker build --network host -t robor-firefox .
cd ..
sudo docker run -v `pwd`/robot:/project robot-firefox bash -c " mkdir /project/test_output;robot --variablefile  project/variable_file.py -d /project/test_output/ project/robot/"
</code>
