# Siddhi Transaction Anomaly Detection Application

## Overview

This Siddhi application demonstrates anomaly detection using **Streaming Integrator**. It sends an email notification to an administrator when more than one transaction occurs within 10 seconds for a specific user, and the total amount of those transactions exceeds 100,000.

## Key Advantages of Siddhi and Streaming Integrator

- **Declarative and Simple Syntax**: Siddhi allows you to express complex stream processing logic in a simple, declarative style. You can focus on the logic of your application without worrying about low-level details.
- **Real-Time Processing**: Siddhi provides powerful real-time event processing capabilities, which makes it ideal for scenarios like anomaly detection, fraud detection, and monitoring.
- **Easy Integration**: Streaming Integrator simplifies the process of integrating Siddhi with various external systems (e.g., databases, JMS, HTTP) with minimal configuration.
- **Efficient Event Processing**: Siddhi is designed to handle large-scale event processing with high throughput and low latency, ensuring timely insights from your streaming data.
- **Scenario-Based Use Cases**: The integration of various sources and sinks in a declarative manner allows you to build complex event-driven applications for real-time analytics, monitoring, and notifications easily.

## Prerequisites

- **MySQL Database**: The application uses a MySQL database to store transaction records.
- **Streaming Integrator Tooling**: To run the Siddhi application, you need to set up the Streaming Integrator Tooling.
- **Java**: Ensure that you have Java installed.

## Setup Instructions

### 1. Set Up the Database

Run the database commands from the provided `db.sql` file to create the required `TransactionTable`.

### 2. Configure MySQL Connector

- Download the MySQL connector `mysql-connector-j-8.0.33.jar`.
- Copy the jar file into the `lib` folder inside the **Streaming Integrator Tooling** directory.

### 3. Update the Configuration

- Open the `deployment.yaml` file located in the `conf/server` directory.
- Append the content from the `deployment.yaml` file in this repository to the existing file.
- Replace the variables in the `deployment.yaml` file with appropriate values (e.g., MySQL database credentials, email credentials).

For **Gmail password generation**: Follow the instructions here:  
[How to get an app password for Gmail](https://support.google.com/accounts/answer/185833?hl=en).

### 4. Start the Streaming Integrator Tooling

- Navigate to the `SI-TOOLING-HOME/bin` directory and execute the following command:
  - For **Linux/macOS**:  
    ```
    ./tooling.sh
    ```
  - For **Windows**:  
    ```
    ./tooling.bat
    ```

### 5. Access the Editor

- Open the editor by visiting the URL displayed in the logs after running the above command.

### 6. Create and Run the Siddhi Application

- Create a new Siddhi file in the editor.
- Copy and paste the content of the `TransactionAnomaly.siddhi` file into the new Siddhi file.
- Run the Siddhi application.

### 7. Insert Sample Data

Insert the following values into the **TransactionTable** to simulate transactions:

```sql
INSERT INTO TransactionTable (customer, amount, last_update) VALUES ('Alice', 10000.0, NOW());

INSERT INTO TransactionTable (customer, amount, last_update) VALUES ('Alice', 20000.0, NOW());

INSERT INTO TransactionTable (customer, amount, last_update) VALUES ('Alice', 90000.0, NOW());
```

### 8. Observe Results

Once the transactions are inserted into the database, you will observe that emails are sent only when more than one transaction for the specific user (e.g., "Alice") occurs within 10 seconds, and the sum of those transactions exceeds 100,000.