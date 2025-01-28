from dotenv import dotenv_values

# Load the environment variables only once during the tests
env = dotenv_values(".env.test")
