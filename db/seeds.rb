User.find_or_create_by(name: "Bonnie", date_of_birth: "01/01/2011", address: "123 Lane Cleveland, OH 12323", phone_number: "123-123-1234", email: "hello@yahoo.com", username: "charliebrown", password_digest: BCrypt::Password.create("hellodolly"))
User.find_or_create_by(name: "Donny", date_of_birth: "12/01/2014", address: "43 Cherry Blossom Lane Cleveland, OH 12345", phone_number: "123-987-4561", email: "fakey@yahoo.com", username: "donnydarko", password_digest: BCrypt::Password.create("heythere"))
User.find_or_create_by(name: "Lilly", date_of_birth: "11/16/2001", address: "456 Highway Avenue Orlando,FL 32223", phone_number: "476-345-9865", email: "lilly@gmail.com", username: "wallflower", password_digest: BCrypt::Password.create("thisisfun"))
User.find_or_create_by(name: "McKenzie", date_of_birth: "02/07/1989", address: "3745 Park Street Birmingham, AL 45612", phone_number: "332-981-7410", email: "siri@gmail.com", username: "siriously", password_digest: BCrypt::Password.create("frankenstein"))
User.find_or_create_by(name: "Charles", date_of_birth: "03/21/1975", address: "4562 Yellow Lane New York, NY 45250", phone_number: "646-202-9633", email: "jfury@bellsouth.net", username: "bountiful87", password_digest: BCrypt::Password.create("bojangles"))

Medication.find_or_create_by(name: "Maxalt", dose: "10 mg", form: "tablets", route: "PO", time_to_be_taken: "prn", category: "prescription", side_effects: "sleepiness, dizziness", notes: "Don't take more then 2 in 24 hours.", prescription_number: "12345", date_filled: "02/28/2021", refill_date: "03/28/2021", discard_or_expiration_date: "02/28/2022", user_id: 1)
Medication.find_or_create_by(name: "Omeprazole", dose: "20 mg", form: "tablets", route: "PO", time_to_be_taken: "BID", category: "prescription", notes: "Take before meals.", prescription_number: "00001", date_filled: "01/14/2021", refill_date: "02/14/2021", discard_or_expiration_date: "02/14/2022", user_id: 1)
Medication.find_or_create_by(name: "Tylenol", dose: "10 ml", form: "liquid", route: "PO", time_to_be_taken: "q 4 hours prn", category: "OTC", notes: "Take with food.", discard_or_expiration_date: "12/02/2025", user_id: 2)
Medication.find_or_create_by(name: "Vitamin D", dose: "15 mcg", form: "chewable tablets", route: "PO", time_to_be_taken: "daily", category: "supplement", user_id: 5)
Medication.find_or_create_by(name: "Lisinopril", dose: "5 mg", form: "tablets", route: "PO", time_to_be_taken: "every morning", category: "prescription", side_effects: "dizziness", notes: "Don't take any supplements without first notifying prescribing physician.", prescription_number: "78265", date_filled: "02/20/2021", refill_date: "03/20/2021", discard_or_expiration_date: "02/20/2022", user_id: 5)

Physician.find_or_create_by(name: "Bob", address: "12 Corporate Way Roanoke, Tx 65465", phone_number: "202-654-9320", website: "yourheartdr.com", notes: "Good bedside manner.", user_id: 1)
Physician.find_or_create_by(name: "Wilma", address: "4505 Hidalgo Highway Miami, FL 63030", phone_number: "471-885-7463", website: "familyphysician.com", notes: "Asked me to keep a log of my blood presure readings for the next month...once in the morning and once before bed.", user_id: 5)
Physician.find_or_create_by(name: "Jane", address: "97 Brown Avenue Seattle, Washington 12534", phone_number: "741-852-9630", website: "familypeds.com", notes: "Great with kids.", user_id: 1)
Physician.find_or_create_by(name: "John", address: "3210 Stick Lane Charleston, NC 65374", phone_number: "142-986-5374", notes: "Need to change doctors.", user_id: 5)
Physician.find_or_create_by(name: "Nelson", address: "8512 Martian Way Dallas, TX 41295", phone_number: "585-961-7474", website: "bestdoc.com", user_id: 3)

Pharmacy.find_or_create_by(name: "YourWalgreens", address: "6335 Plains Circle Seattle, Washington 12534", phone_number: "741-329-8552", website: "yourwalgreens.com", notes: "Prescriptions are autofilled.", user_id: 1)
Pharmacy.find_or_create_by(name: "YourCVS", address: "2485 Nice Street", phone_number: "741-951-4545", website: "yourcvs.com", notes: "Prescriptions are autofilled.", user_id: 5)
Pharmacy.find_or_create_by(name: "YourTarget", address: "1223 Roosevelt Blvd. Jacksonville, FL 32155", phone_number: "656-149-3956", website: "yourtarget.com", user_id: 4)
Pharmacy.find_or_create_by(name: "Family Pharmacy", address: "9098 Whitehouse Lane Washington, D.C. 14245", phone_number: "520-875-3895", website: "yourfriendlypharmacy.com", notes: "Pick up prescriptions on the 5th of every month.", user_id: 3)
Pharmacy.find_or_create_by(name: "YourWalmart", address: "852 Market Street Las Vegas, NV 45450", phone_number: "638-874-1202", website: "getluckypharmacy.com", notes: "Will be moving soon. Need to notify pharmacy.", user_id: 5)

BloodPressureReading.find_or_create_by(date: "01/12/2020", time: "10:10 AM", systolic_reading: "120", diastolic_reading: "80", pulse: "68", device_used: "automatic blood pressure machine", site_used: "right arm", notes: "Great reading!", user_id: 5)
BloodPressureReading.find_or_create_by(date: "01/13/2020", time: "10:00 AM", systolic_reading: "123", diastolic_reading: "85", pulse: "71", device_used: "automatic blood pressure machine", site_used: "right arm", user_id: 5)
BloodPressureReading.find_or_create_by(date: "01/14/2020", time: "10:15 AM", systolic_reading: "118", diastolic_reading: "79", pulse: "69", device_used: "automatic blood pressure machine", site_used: "right arm", user_id: 5)
BloodPressureReading.find_or_create_by(date: "01/15/2020", time: "10:10 AM", systolic_reading: "160", diastolic_reading: "92", pulse: "88", device_used: "automatic blood pressure machine", site_used: "right arm", notes: "I was stuck in traffic for over an hour on the way to work.", user_id: 5)
BloodPressureReading.find_or_create_by(date: "01/15/2020", time: "08:10 PM", systolic_reading: "130", diastolic_reading: "87", pulse: "82", device_used: "automatic blood pressure machine", site_used: "right arm", user_id: 5)
BloodPressureReading.find_or_create_by(date: "02/07/2020", time: "07:30 AM", systolic_reading: "141", diastolic_reading: "86", pulse: "75", device_used: "automatic blood pressure machine", site_used: "left arm", notes: "Taken for Dr. DoGood. Need to take from 2/7/21 to 3/7/21 or until earlier appt.", user_id: 1)
BloodPressureReading.find_or_create_by(date: "02/08/2020", time: "07:30 AM", systolic_reading: "138", diastolic_reading: "82", pulse: "73", device_used: "automatic blood pressure machine", site_used: "left arm", user_id: 1)
