# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
  try:
    conn = pymysql.connect(host=db_host,
                           port=3306,
                           user=db_username,
                           password=db_password,
                           db=db_name,
                           charset="utf8mb4",
                           cursorclass=pymysql.cursors.DictCursor)
    print("Bot connected to database {}".format(db_name))
    return conn
  except:
    print(
      "Bot failed to create a connection with your database because your secret environment variables "
      + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
    print("\n")


def get_response(msg):
  db_response = None
  command_parts = msg.split()
  bot_command = command_parts[0]
  # Requirement 1: Find all hospitals in city x.
  if "/find_hospitals_in_city" in bot_command:
    city = command_parts[1]
    db_response = hospitals_in_city(city)
  # Requirement 2: For each manager, find the number of messages received.
  elif "/find_number_of_messages" in bot_command:
    db_response = number_of_messages()
  # Requirement 3: Find the matching donor blood type for blood type x.
  elif "/matching_blood_type_with" in bot_command:
    blood_type = command_parts[1]
    db_response = matching_blood_type(blood_type)
  # Requirement 4: Create a function that returns the disease result for disease check in each laboratory.
  elif "/disease_result" in bot_command:
    db_response = disease_result()
  # Requirement 5: Create a function that takes in a doctor's name and returns the number of blood transfusion they performed.
  elif "/total_blood_transfusions_performed_by" in bot_command:
    doctor_name = command_parts[1] + " " + command_parts[2]
    db_response = total_blood_transfusions(doctor_name)
  # Requirement 6: For each blood bank, find the name of the manager working in the blood bank.
  elif "/find_manager_working_in_bloodbank" in bot_command:
    db_response = manager_working_in_bloodbank()
  # Requirement 7: Show the rarity of a blood type in the US.
  elif "/blood_type_rarity" in bot_command:
    blood_type = command_parts[1]
    db_response = rarity(blood_type)
  # Requirement 8: If a monitoring process does not have a description, write 'N/A'.
  elif "/replace_description" in bot_command:
    db_response = "To be implimented..."
  # Requirement 9: If doctor does not exist on file for blood transfusion, assign a random doctor from file.
  elif "/assign_random_doctor" in bot_command:
    db_response = "To be implimented..."
  # Requirement 10: Discard blood donation only if the disease result show that the blood is not clean.
  elif "/discard_positive_blood" in bot_command:
    db_response = discard_blood()
  # Requirement 11: Find the number of disease checks a laboratory has performed.
  elif "/find_number_of_disease_checks" in bot_command:
    db_response = number_of_disease_checks()
  # Requirement 12: For each blood bank, find the number of donations.
  elif "/find_number_of_donations" in bot_command:
    db_response = number_of_donations()
  # Requirement 13: Create a function that returns a disease description for disease check x.
  elif "/disease_description_for" in bot_command:
    disease = command_parts[1]
    db_response = disease_desc(disease)
  # Requirement 14: Delete donor because his blood was not clean.
  elif "/delete_donor" in bot_command:
    db_response = "To be implimented..."
  # Requirement 15: For each laboratory, find the number of discarded bloods.
  elif "/find_discarded_bloods" in bot_command:
    db_response = discarded_bloods()
  # Requirement 16: Find patient that performed blood transfusion x.
  elif "/find_person_performed_blood_transfusion" in bot_command:
    blood_transfusion = command_parts[1]
    db_response = find_person(blood_transfusion)
  else:
    return "Unknown command"
  return db_response


# Requirement 1
def hospitals_in_city(city):
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT Hospital.name FROM Hospital WHERE Hospital.address IN (SELECT Address.address_id FROM Address WHERE Address.city = %s);"""
  variable = city
  cursor.execute(query, variable)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result1 = "Hospital names in city " + "'" + city + "': "
    result2 = ""
    for value in range(0, len(query_result)):
      result2 += query_result[value]['name'] + ", "
    final_result = result1 + result2
    return final_result
  return "No hospitals in city " + "'" + city + "'. "


# Requirement 2
def number_of_messages():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT manager_id, total_messages_received FROM Manager GROUP BY manager_id, total_messages_received HAVING total_messages_received >= 0 ORDER BY total_messages_received DESC;"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += "Manager " + str(
        query_result[value]['manager_id']) + " received " + str(
          query_result[value]
          ['total_messages_received']) + " total messages.\n"
    return result
  return query_result


# Requirement 3
def matching_blood_type(blood_type):
  result = ""
  if blood_type == "o_positive":
    result += "o_positive matches with: o_positive OR o_negative"
  elif blood_type == "o_negative":
    result += "o_negative matches with: o_negative"
  elif blood_type == "a_positive":
    result += "a_positive matches with: a_positive OR a_negative OR o_positive OR o_negative"
  elif blood_type == "a_negative":
    result += "a_negative matches with: a_negative OR o_negative"
  elif blood_type == "b_positive":
    result += "b_positive matches with: b_positive OR b_negative OR o_positive: o_negative"
  elif blood_type == "b_negative":
    result += "b_negative matches with: b_negative OR o_negative"
  elif blood_type == "ab_positive":
    result += "ab_positive matches with: Compatible with all types"
  elif blood_type == "ab_negative":
    result += "ab_negative matches with: ab_negative OR a_negative OR b_negative OR o_negative"
  else:
    return blood_type + " is not a blood type."
  return result


# Requirement 4
def disease_result():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT Laboratory.name, DiseaseCheck.disease_result FROM Laboratory JOIN DiseaseCheck ON Laboratory.disease_check = DiseaseCheck.disease_check_id;"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += query_result[value][
        'name'] + " Laboratory " + " has disease result of " + str(
          query_result[value]['disease_result']) + ".\n"
    return result
  return query_result


# Requirement 5
def total_blood_transfusions(doctor_name):
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT count(BloodTransfusion.blood_transfusion_id)
FROM BloodTransfusion
WHERE BloodTransfusion.doctor IN (
	SELECT Doctor.doctor_id
    FROM Doctor
    WHERE Doctor.full_name = %s);"""
  variable = doctor_name
  cursor.execute(query, variable)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = variable + " performed " + str(
      query_result[0]['count(BloodTransfusion.blood_transfusion_id)']
    ) + " blood transfusions."
    return result
  return variable + " is not in the database."


# Requirement 6
def manager_working_in_bloodbank():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT BloodBank.name, Manager.full_name FROM BloodBank JOIN Manager ON BloodBank.manager = Manager.manager_id;"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += query_result[value][
        'full_name'] + " works in " + "'" + query_result[value][
          'name'] + "'" + " bloodbank.\n"
    return result
  return query_result


# Requirement 7
def rarity(blood_type):
  result = ""
  if blood_type == "o_positive":
    result += "o_positive rarity: 37.4% of the US population"
  elif blood_type == "o_negative":
    result += "o_negative rarity: 6.6%  of the US population"
  elif blood_type == "a_positive":
    result += "a_positive rarity: 35.7% of the US population"
  elif blood_type == "a_negative":
    result += "a_negative rarity: 6.3% of the US population"
  elif blood_type == "b_positive":
    result += "b_positive rarity: 8.5% of the US population"
  elif blood_type == "b_negative":
    result += "b_negative rarity: 1.5% of the US population"
  elif blood_type == "ab_positive":
    result += "ab_positive rarity: 3.4% of the US population"
  elif blood_type == "ab_negative":
    result += "ab_negative rarity: 0.6% of the US population"
  else:
    return blood_type + " is not a blood type."
  return result


# Requirement 10
def discard_blood():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT * FROM BloodResult WHERE positive_result > 0"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += "Blood result " + "'" + str(
        query_result[value]
        ['blood_result_id']) + "'" + " needs to be discarded.\n"
    return result
  return query_result


# Requirement 11
def number_of_disease_checks():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT name, count(disease_check) FROM Laboratory GROUP BY name HAVING COUNT(disease_check) > 0 ORDER BY COUNT(*) DESC;"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += query_result[value]['name'] + " has performed " + str(
        query_result[value]['count(disease_check)']) + " disease checks.\n"
    return result
  return query_result


# Requirement 12
def number_of_donations():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT name, total_donations FROM BloodBank GROUP BY name, total_donations HAVING total_donations >= 0 ORDER BY total_donations DESC;"""
  cursor.execute(query)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += "'" + query_result[value][
        'name'] + "'" + " bloodbank has " + str(
          query_result[value]['total_donations']) + " total donations.\n"
    return result
  return query_result


# Requirement 13
def disease_desc(disease):
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT disease_description FROM DiseaseCheck WHERE disease_check_id = %s;"""
  variable = disease
  cursor.execute(query, variable)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = "Disease description for disease check " + "'" + variable + "': " + "'" + query_result[
      0]['disease_description'] + "'"
    return result
  return variable + " is not in the database."


# Requirement 15
def discarded_bloods():
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT laboratory, count(positive_result) FROM BloodResult GROUP BY laboratory HAVING COUNT(positive_result) >= 0 ORDER BY count(positive_result) DESC;"""
  cursor.execute(query, )
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = ""
    for value in range(0, len(query_result)):
      result += "Laboratory " + "'" + str(
        query_result[value]['laboratory']) + "'" + " has " + str(
          query_result[value]
          ['count(positive_result)']) + " discarded bloods.\n"
    return result
  return query_result


# Requirement 16
def find_person(blood_transfusion):
  connection = connect()
  cursor = connection.cursor()
  query = """SELECT PatientRecord.full_name FROM PatientRecord JOIN Patient ON PatientRecord.patient = Patient.patient_id WHERE Patient.blood_transfusion = %s;"""
  variable = blood_transfusion
  cursor.execute(query, variable)
  query_result = cursor.fetchall()
  cursor.close()
  if query_result:
    result = "'" + query_result[0][
      'full_name'] + "'" + " performed blood transfusion " + "'" + variable + "'"
    return result
  return variable + " is not in the database."
