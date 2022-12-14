from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Address(Base):
  __tablename__ = 'Address'

  address_id = Column(String(60), primary_key=True)
  street = Column(String(45), nullable=False)
  zip_code = Column(String(45), nullable=False)
  state = Column(String(45), nullable=False)
  city = Column(String(45), nullable=False)

  def __init__(self, address_id, street, zip_code, state, city):
    self.address_id = address_id
    self.street = street
    self.zip_code = zip_code
    self.state = state
    self.city = city

class BloodBank(Base):
  __tablename__ = 'BloodBank'

  blood_bank_id = Column(Integer, primary_key=True)
  monitoring_process = Column(Integer, unique=True, nullable=False)
  manager = Column(Integer, unique=True, nullable=False)
  address = Column(String(60), nullable=False)
  donor_record = Column(Integer, unique=True)
  donor = Column(Integer, unique=True)
  hospital = Column(Integer)
  name = Column(String(60), nullable=False)
  total_donations = Column(Integer)

  def __init__(self, blood_bank_id, monitoring_process, manager, address, donor_record, donor, hospital, name, total_donations):
    self.blood_bank_id = blood_bank_id
    self.monitoring_process = monitoring_process
    self.manager = manager
    self.address = address
    self.donor_record = donor_record
    self.donor = donor
    self.hospital = hospital
    self.name = name
    self.total_donations = total_donations

class BloodType(Base):
  __tablename__ = 'BloodType'
  
  blood_type_id = Column(Integer, primary_key=True)
  o_positive_type_blood_type = Column(Boolean)
  o_negative_type_blood_type = Column(Boolean)
  a_positive_type_blood_type = Column(Boolean)
  a_negative_type_blood_type = Column(Boolean)
  b_positive_type_blood_type = Column(Boolean)
  b_negative_type_blood_type = Column(Boolean)
  ab_positive_type_blood_type = Column(Boolean)
  ab_negative_type_blood_type = Column(Boolean)

  def __init__(self, blood_type_id, o_positive_type_blood_type, o_negative_type_blood_type, a_positive_type_blood_type, a_negative_type_blood_type, b_positive_type_blood_type, b_negative_type_blood_type, ab_positive_type_blood_type, ab_negative_type_blood_type):
    self.blood_type_id = blood_type_id
    self.o_positive_type_blood_type = o_positive_type_blood_type
    self.o_negative_type_blood_type = o_negative_type_blood_type
    self.a_positive_type_blood_type = a_positive_type_blood_type
    self.a_negative_type_blood_type = a_negative_type_blood_type
    self.b_positive_type_blood_type = b_positive_type_blood_type
    self.b_negative_type_blood_type = b_negative_type_blood_type
    self.ab_positive_type_blood_type = ab_positive_type_blood_type
    self.ab_negative_type_blood_type = ab_negative_type_blood_type

class Patient(Base):
  __tablename__ = 'Patient'

  patient_id = Column(Integer, primary_key=True)
  patient_record = Column(Integer, unique=True)
  blood_transfusion = Column(Integer)
  doctor = Column(Integer)

  def __init__(self, patient_id, patient_record, blood_transfusion, doctor):
    self.patient_id = patient_id
    self.patient_record = patient_record
    self.blood_transfusion = blood_transfusion
    self.doctor = doctor

class BloodTransfusion(Base):
  __tablename__ = 'BloodTransfusion'
  
  blood_transfusion_id = Column(Integer, primary_key=True)
  doctor = Column(Integer)
  hospital = Column(Integer)
  patient = Column(Integer, ForeignKey('Patient.patient_id'), nullable=True)

  def __init__(self, blood_transfusion_id, doctor, hospital, patient):
    self.blood_transfusion_id = blood_transfusion_id
    self.doctor = doctor
    self.hospital = hospital
    self.patient = patient

class BloodResult(Base):
  __tablename__ = 'BloodResult'
    
  blood_result_id = Column(Integer, primary_key=True)
  positive_result = Column(Integer, unique=True, nullable=True)
  negative_result = Column(Integer, unique=True, nullable=True)
  doctor = Column(Integer)
  laboratory = Column(Integer)

  def __init__(self, blood_result_id, positive_result, negative_result, doctor, laboratory):
    self.blood_result_id = blood_result_id
    self.positive_result = positive_result
    self.negative_result = negative_result
    self.doctor = doctor
    self.laboratory = laboratory

class Hospital(Base):
  __tablename__ = 'Hospital'
    
  hospital_id = Column(Integer, primary_key=True)
  address = Column(String(60), nullable=False)
  laboratory = Column(Integer)
  donor_record = Column(Integer, unique=True, nullable=True)
  doctor = Column(Integer)
  patient_record = Column(Integer, unique=True, nullable=True)
  name = Column(String(60), nullable=False)

  def __init__(self, hospital_id, address, laboratory, donor_record, doctor, patient_record, name):
    self.hospital_id = hospital_id
    self.address = address
    self.laboratory = laboratory
    self.donor_record = donor_record
    self.doctor = doctor
    self.patient_record = patient_record
    self.name = name

class Doctor(Base):
  __tablename__ = 'Doctor'
    
  doctor_id = Column(Integer, primary_key=True)
  hospital = Column(Integer)
  patient_record = Column(Integer)
  donor_record = Column(Integer)
  blood_transfusion = Column(Integer)
  blood_result = Column(Integer)
  full_name = Column(String(60), unique=True, nullable=False)

  def __init__(self, doctor_id, hospital, patient_record, donor_record, blood_transfusion, blood_result, full_name):
    self.doctor_id = doctor_id
    self.hospital = hospital
    self.patient_record = patient_record
    self.donor_record = donor_record
    self.blood_transfusion = blood_transfusion
    self.blood_result = blood_result
    self.full_name = full_name

class PatientRecord(Base):
  __tablename__ = 'PatientRecord'
    
  patient_record_id = Column(Integer, primary_key=True)
  address = Column(String(60), ForeignKey('Address.address_id'), nullable=False)
  blood_type = Column(Integer, ForeignKey('BloodType.blood_type_id'), unique=True, nullable=False)
  patient = Column(Integer, ForeignKey('Patient.patient_id'), unique=True, nullable=False)
  full_name = Column(String(60), unique=True, nullable=False)
  blood_result = Column(Integer, ForeignKey('BloodResult.blood_result_id'), unique=True, nullable=True)
  hospital = Column(Integer, ForeignKey('Hospital.hospital_id'), nullable=True)
  doctor = Column(Integer, ForeignKey('Doctor.doctor_id'), nullable=True)

  def __init__(self, patient_record_id, address, blood_type, patient, full_name, blood_result, hospital, doctor):
    self.patient_record_id = patient_record_id
    self.address = address
    self.blood_type = blood_type
    self.patient = patient
    self.full_name = full_name
    self.blood_result = blood_result
    self.hospital = hospital
    self.doctor = doctor

class Laboratory(Base):
  __tablename__ = 'Laboratory'
    
  laboratory_id = Column(Integer, primary_key=True)
  donor_record = Column(Integer)
  blood_bank_message = Column(Integer)
  address = Column(String(60), nullable=False)
  hospital = Column(Integer)
  disease_check = Column(Integer, nullable=False)
  message_sent = Column(Integer)
  message_received = Column(Integer)
  name = Column(String(60), nullable=False)

  def __init__(self, laboratory_id, donor_record, blood_bank_message, address, hospital, disease_check, message_sent, message_received, name):
    self.laboratory_id = laboratory_id
    self.donor_record = donor_record
    self.blood_bank_message = blood_bank_message
    self.address = address
    self.hospital = hospital
    self.disease_check = disease_check
    self.message_sent = message_sent
    self.message_received = message_received
    self.name = name

class Donor(Base):
  __tablename__ = 'Donor'
    
  donor_id = Column(Integer, primary_key=True)
  blood_bank = Column(Integer)
  message_blood_bank = Column(Integer)
  blood_result = Column(Integer, unique=True, nullable=False)
  donor_record = Column(Integer, unique=True, nullable=True)

  def __init__(self, donor_id, blood_bank, message_blood_bank, blood_result, donor_record):
    self.donor_id = donor_id
    self.blood_bank = blood_bank
    self.message_blood_bank = message_blood_bank
    self.blood_result = blood_result
    self.donor_record = donor_record

class DiseaseCheck(Base):
  __tablename__ = 'DiseaseCheck'
  
  disease_check_id = Column(Integer, primary_key=True)
  laboratory = Column(Integer, ForeignKey('Laboratory.laboratory_id'), nullable=False)
  donor_record = Column(Integer)
  disease_description = Column(String(60), nullable=False)
  disease_result = Column(Integer, nullable=True)

  def __init__(self, disease_check_id, laboratory, donor_record, disease_description, disease_result):
    self.disease_check_id = disease_check_id
    self.laboratory = laboratory
    self.donor_record = donor_record
    self.disease_description = disease_description
    self.disease_result = disease_result

class DonorRecord(Base):
  __tablename__ = 'DonorRecord'

  donor_record_id = Column(Integer, primary_key=True)
  donor = Column(Integer, ForeignKey('Donor.donor_id'), unique=True)
  blood_type = Column(Integer, ForeignKey('BloodType.blood_type_id'), primary_key=True)
  blood_bank = Column(Integer, ForeignKey('BloodBank.blood_bank_id'), primary_key=True)
  blood_result = Column(Integer, ForeignKey('BloodResult.blood_result_id'), unique=True)
  disease_check = Column(Integer, ForeignKey('DiseaseCheck.disease_check_id'), unique=True)
  address = Column(String, ForeignKey('Address.address_id'), unique=True)
  full_name = Column(String, unique=True)

  def __init__(self, donor_record_id, donor, blood_type, blood_bank, blood_result, disease_check, address, full_name):
    self.donor_record_id = donor_record_id
    self.donor = donor
    self.blood_type = blood_type
    self.blood_bank = blood_bank
    self.blood_result = blood_result
    self.disease_check = disease_check
    self.address = address
    self.full_name = full_name

class PositiveResult(Base):
  __tablename__ = 'PositiveResult'

  positive_result_id = Column(Integer, primary_key=True)
  positive_result = Column(Boolean, nullable=True)
  blood_result = Column(Integer, nullable=True, ForeignKey('BloodResult.blood_result_id'))

  def __init__(self, positive_result_id, positive_result, blood_result):
    self.positive_result_id = positive_result_id
    self.positive_result = positive_result
    self.blood_result = blood_result

class Messages(Base):
  __tablename__ = 'Messages'

  message_id = Column(Integer, primary_key=True)
  messages_blood_bank_id = Column(Integer, nullable=True)
  messages_hospital_id = Column(Integer, nullable=True)
  messages_donor_id = Column(Integer, nullable=True)
  messages_laboratory_id = Column(Integer, nullable=True)
  disease_check_description = Column(String, nullable=True)
  sent_description = Column(String, nullable=True)
  received_description = Column(String, nullable=True)
  
  def __init__(self, message_id, messages_blood_bank_id, messages_hospital_id, messages_donor_id, messages_laboratory_id, disease_check_description, sent_description, received_description):
    self.message_id = message_id
    self.messages_blood_bank_id = messages_blood_bank_id
    self.messages_hospital_id = messages_hospital_id
    self.messages_donor_id = messages_donor_id
    self.messages_laboratory_id = messages_laboratory_id
    self.disease_check_description = disease_check_description
    self.sent_description = sent_description
    self.received_description = received_description
  

class NegativeResult(Base):
  __tablename__ = 'NegativeResult'

  negative_result_id = Column(Integer, primary_key=True)
  negative_result = Column(Boolean)
  blood_result = Column(Integer, ForeignKey('BloodResult.blood_result_id'))

  def __init__(self, negative_result_id, negative_result, blood_result):
    self.negative_result_id = negative_result_id
    self.negative_result = negative_result
    self.blood_result = blood_result

class MonitoringProcess(Base):
  __tablename__ = 'MonitoringProcess'

  monitoring_process_id = Column(Integer, primary_key=True)
  description = Column(String(45))

  def __init__(self, monitoring_process_id, description):
    self.monitoring_process_id = monitoring_process_id
    self.description = description


class Manager(Base):
  __tablename__ = "Manager"
    
  manager_id = Column(Integer, primary_key=True)
  blood_bank = Column(Integer, ForeignKey('BloodBank.blood_bank_id'), primary_key=True)
  monitoring_process = Column(Integer, ForeignKey('MonitoringProcess.monitoring_process_id'), primary_key=True)
  address = Column(String, ForeignKey('Address.address_id'))
  donor_record = Column(Integer, ForeignKey('DonorRecord.donor_record_id'), unique=True, nullable=True)
  full_name = Column(String, unique=True)
  total_messages_received = Column(Integer, nullable=True)
  laboratory_messages = Column(Integer, ForeignKey('Messages.message_id'), nullable=True, default=0)
  messages_received = Column(Integer, ForeignKey('Messages.message_id'), nullable=True, default=0)
  messages_sent = Column(Integer, ForeignKey('Messages.message_id'), nullable=True, default=0)

  def __init__(self, manager_id, blood_bank, monitoring_process, address, donor_record, full_name, total_messages_received, laboratory_messages, messages_received, messages_sent):
    self.manager_id = manager_id
    self.blood_bank = blood_bank
    self.monitoring_process = monitoring_process
    self.address = address
    self.donor_record = donor_record
    self.full_name = full_name
    self.total_messages_received = total_messages_received
    self.laboratory_messages = laboratory_messages
    self.messages_received = messages_received
    self.messages_sent = messages_sent
