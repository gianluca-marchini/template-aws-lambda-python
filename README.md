# Template: AWS Lambda function
This repository contains the template to start from when implementing a new Python lambda function to run on AWS.

## The Lambda function
### Application architecture
The application's source code is located in the `src/` directory, and the tests in the `tests/` directory:
- `src/lambda_function.py`: it contains the `lambda_handler` function as entry point of the lambda function, and the business logic.
- `tests/`: it contains the functional, integration, and unit automatic tests. It reads the environment variables from the `.env.test` file.

### Deployment
The stage and production environments should be isolated, so the application will run on 2 different Lambda functions.
The two GitHub actions `deploy-stage.yml` and `release.yml` will take care to deploy the application to the Lambda functions:
- `deploy-stage.yml`: manually trigger it from the GitHub dashboard to deploy the application to the staging Lambda function before merging the reviewed branch into the develop branch
- `release.yml`: it is triggered when a new release of the application is ready and deploys the application to the production Lambda function.

Note that you need to add to the GitHub repository the `api-keys` of a user allowed to update the required `lambda function`. You have to assign to it a policy with the following rules:
```json
{
    "Version": "YYYY-MM-DD",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:UpdateFunctionCode",
                "lambda:GetFunction",
                "lambda:PublishVersion"
            ],
            "Resource": "arn:aws:lambda:{aws-region}:{aws-user-id}:function:{aws-lambda-function-name}"
        }
    ]
}
```

## Usage
Once you cloned the repository and performed the changes required by the task, you have to check, test, and eventually fix your application:
1. install the Python packages required by the application running the command `pip install -r dev-requirements.txt`
2. `make check-app`: use `ruff[1]` to check the code
3. `make docker-run`: run the dockerized services and wait until they are ready
4. `make test-app`: run the automatic tests

If you need to run the application locally:
1. install the required Python packages: `pip install -r dev-requirements.txt`
2. Start the Docker services: `make docker-run`
3. Load the environment variables from `.env.dist`
4. Execute the Python script: `python src/lambda_function.py`.

### Dependencies
To run the application locally you need install:
- Python v3.13
- Docker

## References:
1. [Ruff](https://pypi.org/project/ruff/): it is a fast code linter and checker, written in Rust.
