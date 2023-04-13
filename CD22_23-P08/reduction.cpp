#include "reduction.h"


int main(int argc, char *argv[]) {

    // Default values.
    int num_rows = DEFAULT_NUM_ROWS;
    int num_features = DEFAULT_NUM_FEATURES;
    int num_threads = DEFAULT_NUM_THREADS;

    // Check if -h option is given.
    if (argc > 1 && (std::string(argv[1]) == "-h" || std::string(argv[1]) == "--help")) {
        std::cout << "Usage: " << argv[0] << " [NUM_ROWS] [NUM_FEATURES] [NUM_THREADS]" << std::endl;
        std::cout << "Compute the mean of a randomly generated dataset." << std::endl;
        std::cout << "Arguments:" << std::endl;
        std::cout << "  NUM_ROWS       number of rows in the dataset." << std::endl;
        std::cout << "  NUM_FEATURES   number of features in the dataset." << std::endl;
        std::cout << "  NUM_THREADS    number of threads to use for parallel computation." << std::endl;
        return 0;
    }

    // Get command line arguments other than -h.
    if (argc > 1) {
        try {
            num_rows = std::stoi(argv[1]);
        } catch (std::exception const &e) {
            std::cerr << "Error: Invalid argument. Number of rows must be an integer.\n";
            return 1;
        }
    }
    if (argc > 2) {
        try {
            num_features = std::stoi(argv[2]);
        } catch (std::exception const &e) {
            std::cerr << "Error: Invalid argument. Number of features must be an integer.\n";
            return 1;
        }
    }
    if (argc > 3) {
        try {
            num_threads = std::stoi(argv[3]);
            if (num_threads > omp_get_max_threads()) {
                num_threads = omp_get_max_threads();
                std::cout << "The number of threads provided is higher than the maximum available." << std::endl;
                std::cout << "Number of threads set to the maximum available: " << omp_get_max_threads() << "." << std::endl;
                std::cout << std::endl;                
            }
        } catch (std::exception const &e) {
            std::cerr << "Error: Invalid argument. Number of threads must be an integer.\n";
            return 1;
        }
    }

    // Show input.
    std::cout << "----------------INPUT---------------" << std::endl;
    std::cout << "Number of rows: " << num_rows << std::endl;
    std::cout << "Number of features: " << num_features << std::endl;
    std::cout << "Number of threads (parallel comp.): " << num_threads << std::endl;
    std::cout << std::endl;

    // Create dataset (allocate dynamic memory).
    std::cout << "---------------DATASET--------------" << std::endl;
    std::cout << "Allocating the dataset..." << std::endl;
    auto start = std::chrono::high_resolution_clock::now();
    double** data = new double*[num_rows];
    for (int i = 0; i < num_rows; i++) {
        data[i] = new double[num_features];
        for (int j = 0; j < num_features; j++) {
            data[i][j] = rand() % 100;
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    auto time_rand = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
    std::cout << "Completed!" << std::endl;
    std::cout << "Dataset creation (ms): " << time_rand << std::endl;
    std::cout << std::endl;

    // Serial computation.
    std::cout << "---------SERIAL COMPUTATION---------" << std::endl;
    std::cout << "Calculating the mean value..." << std::endl;
    start = std::chrono::high_resolution_clock::now();
    double sum = 0.0;
    for (int i = 0; i < num_rows; i++) {
        for (int j = 0; j < num_features; j++) {
            sum += data[i][j];
        }
    }
    double mean = sum / (num_rows * num_features);
    end = std::chrono::high_resolution_clock::now();
    auto time_serial = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
    std::cout << "Completed!" << std::endl;
    std::cout << "Mean result: " << mean << std::endl;
    std::cout << "Serial computation (ms): " << time_serial << std::endl;
    std::cout << std::endl;

    // Parallel computation.
    std::cout << "--------PARALLEL COMPUTATION--------" << std::endl;
    std::cout << "Calculating the mean value..." << std::endl;
    start = std::chrono::high_resolution_clock::now();
    sum = 0.0;
    #pragma omp parallel for num_threads(num_threads) reduction(+:sum)
    for (int i = 0; i < num_rows; i++) {
        for (int j = 0; j < num_features; j++) {
            sum += data[i][j];
        }
    }
    mean = sum / (num_rows * num_features);
    end = std::chrono::high_resolution_clock::now();
    auto time_parallel = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
    std::cout << "Completed!" << std::endl;
    std::cout << "Mean result: " << mean << std::endl;
    std::cout << "Parallel computation (ms): " << time_parallel << std::endl;

    // Free memory.
    for (int i = 0; i < num_rows; i++) {
        delete[] data[i];
    }
    delete[] data;

    // Exit.
    return 0;
}
