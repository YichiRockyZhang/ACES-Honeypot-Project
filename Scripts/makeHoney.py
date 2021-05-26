from faker import Faker
from faker.providers import internet
from random_words import RandomWords
from random import randint, choice
import string
import hashlib

def randomCapitalize(str):
    newStr = ""
    for x in str:
        if randint(1,10) % 2 == 0:
            newStr += x.upper()
        else:
            newStr += x
    return newStr

def main():
    Faker.seed(1)

    txtFile = open("records.txt", "w")
    hashFile = open("hash.txt", "w")
    emailFile = open("CompanyEmails.txt", "w")

    fake = Faker()

    fakeIP = Faker()
    fakeIP.add_provider(internet)

    rw = RandomWords()

    txtFile.write("------------------------------------------------------------\n")
    txtFile.write("**********Important. Top Sneaky. Do Not Disclose.**********\n")
    txtFile.write("------------------------------------------------------------\n")

    for _ in range(1000):
        txtFile.write(fake.name() + "\n")
        password = rw.random_word()
        while len(password) < 8:
            password = rw.random_word()
        password = randomCapitalize(password) + "".join(choice(string.punctuation + string.digits) for x in range(randint(2, 6)))
        txtFile.write(password + "\n")
        emailFile.write(fake.email() + "\n")
        txtFile.write(fake.ipv4_private() + "\n\n")

        hashFile.write(hashlib.sha256(bytes(password,"utf-8")).hexdigest())
        hashFile.write("\n")

if __name__ == "__main__":
    main()