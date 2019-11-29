# Microservices Inventory

This page shows the expected status of the different microservices

----

## Can we Build, Initialize, Start, Stop?

|                   | Locally     | Docker-compose | Kubernetes | AZ     | AWS     |
| ----------------- | ----------- | -------------- | ---------- | ------ | ------- |
| Identity Mgmt     | **Unknown** | **No**         | **No (1)** | **No** | **No**  |
| BasicService      | Yes(2)      | Yes (2)        | **No**     | **No** | **No**  |
| ActivityTrail     | **No**      | **No**         | **No**     | **No** | **No**  |
| BasicESService    | **No**      | **No**         | **No**     | **No** | **No**  |

1. Scripts are out of date  
2. Verified 11/29/2019

---

## Can we run api smoke tests?

|                   | Locally     | Docker-compose | Kubernetes | AZ     | AWS     |
| ----------------- | ----------- | -------------- | ---------- | ------ | ------- |
| Identity Mgmt     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicService      | **No**      | **No**         | **No**     | **No** | **No**  | 
| ActivityTrail     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicESService    | **No**      | **No**         | **No**     | **No** | **No**  |

---

## Do we have a front-end?

|                   | Locally     | Docker-compose | Kubernetes | AZ     | AWS     |
| ----------------- | ----------- | -------------- | ---------- | ------ | ------- |
| Identity Mgmt     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicService      | Yes (1)     | Yes (1)        | **No**     | **No** | **No**  | 
| ActivityTrail     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicESService    | **No**      | **No**         | **No**     | **No** | **No**  |

1. Verified 11/29/2019

---

## Can we run front-end smoke tests?

|                   | Locally     | Docker-compose | Kubernetes | AZ     | AWS     |
| ----------------- | ----------- | -------------- | ---------- | ------ | ------- |
| Identity Mgmt     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicService      | **No**      | **No**         | **No**     | **No** | **No**  | 
| ActivityTrail     | **No**      | **No**         | **No**     | **No** | **No**  | 
| BasicESService    | **No**      | **No**         | **No**     | **No** | **No**  |
