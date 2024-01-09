sudo apt update && sudo apt install libhdf5-dev libopenblas-dev protobuf-compiler libprotobuf-dev libboost-all-dev
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | sudo tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
sudo apt update
sudo apt install intel-oneapi-mkl intel-oneapi-mkl-devel

git submodule update --init -- external/rl_tools
cd external/rl_tools
git submodule update --init -- external/cli11 external/highfive external/json/ external/tensorboard tests/lib/googletest/

source /opt/intel/oneapi/setvars.sh
cd ../../
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DRL_TOOLS_BACKEND_ENABLE_MKL:BOOL=ON
cmake --build . -j8
cd ..
