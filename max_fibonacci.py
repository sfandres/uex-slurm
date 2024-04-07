#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script that computes the highest Fibonacci number up to a given number.

Usage: max_fibonacci.py [-h] [--maximum MAXIMUM]

Script that computes the highest Fibonacci number up to a given number.

optional arguments:
  -h, --help            show this help message and exit
  --maximum MAXIMUM, -m MAXIMUM
                        input number to compute Fibonacci (>0).

Author: Andres J. Sanchez-Fernandez
Email: sfandres@unex.es
Date: 2024-04-07
Version: v1
"""


import sys
import argparse


def get_args() -> argparse.Namespace:
    """
    Parse and retrieve command-line arguments.

    Returns:
        An 'argparse.Namespace' object containing the parsed arguments.
    """
    parser = argparse.ArgumentParser(                                                   # Parser creation and description.
        description='Script that computes the highest ' \
                    'Fibonacci number up to a given number.'
    )

    parser.add_argument(                                                                # Options.
        '--maximum',
        '-m',
        type=int,
        default=1000,
        help=('input number to compute Fibonacci (>0).')
    )

    return parser.parse_args(sys.argv[1:])


def main(args: argparse.Namespace) -> bool:
    """
    Main function.

    Args:
        args: An 'argparse.Namespace' object containing the parsed arguments.

    Returns:
        A boolean indicating the success of the process.
    """
    if args.maximum <= 0:
        raise argparse.ArgumentError(None, 'The number must be greater than 0.')        # Raise an error if the number is not valid.

    n1, n2 = 1, 1                                                                       # Initialize the first two Fibonacci numbers.

    print('\nCalculating...')                                                           # Calculate the Fibonacci numbers.
    while n2 <= args.maximum:
        n1, n2 = n2, n1 + n2
    print('Completed!')
    print(f'\nThe highest Fibonacci number up to {args.maximum} is {n1}')               # Print the result.

    return 0


if __name__ == '__main__':
    args = get_args()                                                                   # Parse and retrieve command-line arguments.
    sys.exit(main(args))                                                                # Execute the main function.
