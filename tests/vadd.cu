#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#define N 10000000
#define MAX_ERR 1e-6

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

__global__ void vector_add(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i ++){
        out[i] = a[i] + b[i];
    }
}

int main(){
    float *a, *b, *out, *a2;
    float *d_a, *d_b, *d_out; 

    // Allocate host memory
    a   = (float*)malloc(sizeof(float) * N);
    b   = (float*)malloc(sizeof(float) * N);
    out = (float*)malloc(sizeof(float) * N);
    a2  = (float*)malloc(sizeof(float) * N);

    // Initialize host arrays
    for(int i = 0; i < N; i++){
        a[i] = 1.0f;
        b[i] = 2.0f;
    }

    // Allocate device memory
    gpuErrchk( cudaMalloc((void**)&d_a, sizeof(float) * N) );
    gpuErrchk( cudaMalloc((void**)&d_b, sizeof(float) * N) );
    gpuErrchk( cudaMalloc((void**)&d_out, sizeof(float) * N) );

    // Transfer data from host to device memory
    gpuErrchk( cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice ));
    gpuErrchk( cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice) );

    // Executing kernel 
    vector_add<<<1,1>>>(d_out, d_a, d_b, N);
    
    // Transfer data back to host memory
    gpuErrchk( cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost) );
    gpuErrchk( cudaMemcpy(a2, d_a, sizeof(float) * N, cudaMemcpyDeviceToHost) );

    printf("out[0] = %f\n", out[0]);
    printf("a from device[0] = %f\n", a2[0]);
    printf("Expected answer is 1+2=3...\n");
    // Verification
    for(int i = 0; i < N; i++){
        if ( fabs(out[i] - a[i] - b[i]) > MAX_ERR ) {
            printf(" %f %f %f\n",out[i],a[i],b[i]);
        }
        assert(fabs(out[i] - a[i] - b[i]) < MAX_ERR);
    }
    printf("SUCCESS!\n");
    
    // Deallocate device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);

    // Deallocate host memory
    free(a); 
    free(b); 
    free(out);
}
