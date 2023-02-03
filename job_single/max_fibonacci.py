import sys
import argparse

# Get arguments.
parser = argparse.ArgumentParser(
    description="Script to play with slurm."
)

parser.add_argument(
    'maximum',
    type=int,
    help=('Input number to compute Fibonacci.')
)

args = parser.parse_args(sys.argv[1:])

if not args.maximum > 0:
    raise argparse.ArgumentError(None, 'The number must be greater than 0.')

# Get input number.
maximum = args.maximum
print(f'Maximum number: {maximum}')

# Computation.
n1, n2 = 1, 1
while n2 <= maximum:
    n1, n2 = n2, n1 + n2

print(f'\nGreatest Fibonacci number up to {maximum}: {n1}')
