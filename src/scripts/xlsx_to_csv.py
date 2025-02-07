""" Script to convert all xlsx file under data folder to csv files. """

import openpyxl
import csv
import os
import logging

import py_logging as log

logger: logging.Logger = log.get_logger("basic_logger")

PATH = 'src/data/'


def xlsx_to_csv(xlsx_file):
    """Covert a single xlsv file into a csv file."""

    workbook = openpyxl.load_workbook(xlsx_file)
    sheet = workbook.active

    csv_file = os.path.splitext(xlsx_file)[0] + '.csv'

    try:
        with open(csv_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            for row in sheet.iter_rows(values_only=True):
                writer.writerow(row)
        logger.info(f"Converted '{xlsx_file}' to '{csv_file}' successfully.")
    except Exception as e:
        logger.error(e)
    return


def main():
    all_files = os.listdir(PATH)
    xlsx_files = [f for f in all_files if f.endswith('.xlsx')]

    for xlsx_file in xlsx_files:
        xlsx_to_csv(xlsx_file)

    logger(f"All xlsx filers under {PATH} finished.")
    return

if __name__ == "__main__":
    main()