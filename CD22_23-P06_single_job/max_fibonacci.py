import sys
import argparse


def get_args(argv=None):
    """Takes the command line arguments."""

    # Get arguments.
    parser = argparse.ArgumentParser(
        description="Python script to play with slurm."
    )

    # Optional arguments.
    parser.add_argument(
        '--maximum',
        '-m',
        type=int,
	default=1000,
        help=('input number to compute Fibonacci (>0).')
    )

    return parser.parse_args(sys.argv[1:])

def main():
    """Main function."""

    # Get command terminal arguments.
    args = get_args(argv=sys.argv)

    # Get input number.
    maximum = args.maximum
    # if maximum == None:
    #     maximum = int(input('Enter a number to compute Fibonacci (>0): '))
    # else:
    #     print(f'Number to compute Fibonacci: {maximum}')

    # Handle exceptions.
    if maximum <= 0:
        raise argparse.ArgumentError(None, 'The number must be greater than 0.')

    # Compute.
    print('\nCalculating...')
    n1, n2 = 1, 1
    while n2 <= maximum:
        n1, n2 = n2, n1 + n2
    print('Completed!')

    # Show result.
    print(f'\nGreatest Fibonacci number up to {maximum}: {n1}')

    return 0


# Call the main function to execute the program.
if __name__ == '__main__':
    sys.exit(main())
