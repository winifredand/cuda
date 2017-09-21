//采用新版本的CUDA函数编写
//此函数是测试运行的PC机是否具有CUDA编程的能力
#include <stdio.h>  
#include <memory>
#include <cuda_runtime.h>
#include <helper_cuda.h>

extern "C" void DeviceInfo(void)
{
	int deviceCount;
	cudaError_t error_id = cudaGetDeviceCount(&deviceCount); //CUDA
	if (error_id != cudaSuccess)
	{
		printf("cudaGetDeviceCount returned %d\n-> %s\n", (int)error_id, cudaGetErrorString(error_id));
		printf("Result = FAIL\n");
		exit(EXIT_FAILURE);
	}
	if (deviceCount == 0)
	{
		printf("There are no available device(s) that support CUDA\n");
	}
	else
	{
		printf("There are no available device(s) that support CUDA\n");
	}
	int dev;
	for (dev = 0; dev < deviceCount; ++dev) {

		cudaSetDevice(dev);
		cudaDeviceProp deviceProp;
		cudaGetDeviceProperties(&deviceProp, dev);
		if (dev == 0) {
			if (deviceProp.major == 9999 && deviceProp.minor == 9999)
				printf("There is no device supporting CUDA.\n");
			else if (deviceCount == 1)
				printf("There is 1 device supporting CUDA\n");
			else
				printf("There are %d devices supporting CUDA\n", deviceCount);
		}
		printf("\nDevice %d: \"%s\"\n", dev, deviceProp.name);
		printf("  Major revision number:                         %d\n",
			deviceProp.major);
		printf("  Minor revision number:                         %d\n",
			deviceProp.minor);
		printf("  Total amount of global memory:                 %u bytes\n",
			deviceProp.totalGlobalMem);
#if CUDART_VERSION >= 2000
		printf("  Number of multiprocessors:                     %d\n",
			deviceProp.multiProcessorCount);
		printf("  Number of cores:                               %d\n",
			8 * deviceProp.multiProcessorCount);
#endif
		printf("  Total amount of constant memory:               %u bytes\n",
			deviceProp.totalConstMem);
		printf("  Total amount of shared memory per block:       %u bytes\n",
			deviceProp.sharedMemPerBlock);
		printf("  Total number of registers available per block: %d\n",
			deviceProp.regsPerBlock);
		printf("  Warp size:                                     %d\n",
			deviceProp.warpSize);
		printf("  Maximum number of threads per block:           %d\n",
			deviceProp.maxThreadsPerBlock);
		printf("  Maximum sizes of each dimension of a block:    %d x %d x %d\n",
			deviceProp.maxThreadsDim[0],
			deviceProp.maxThreadsDim[1],
			deviceProp.maxThreadsDim[2]);
		printf("  Maximum sizes of each dimension of a grid:     %d x %d x %d\n",
			deviceProp.maxGridSize[0],
			deviceProp.maxGridSize[1],
			deviceProp.maxGridSize[2]);
		printf("  Maximum memory pitch:                          %u bytes\n",
			deviceProp.memPitch);
		printf("  Texture alignment:                             %u bytes\n",
			deviceProp.textureAlignment);
		printf("  Clock rate:                                    %.2f GHz\n",
			deviceProp.clockRate * 1e-6f);
#if CUDART_VERSION >= 2000
		printf("  Concurrent copy and execution:                 %s\n",
			deviceProp.deviceOverlap ? "Yes" : "No");
#endif
	}

	printf("\nTest PASSED\n");

}
