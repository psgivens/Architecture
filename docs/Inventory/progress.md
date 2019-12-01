# Microservices Inventory

This page shows the expected status of the different microservices

----

## Can we Build, Initialize, Start, Stop?

|                   | Locally     | Docker-compose | Kubernetes | AZ     | AWS     |
| ----------------- | ----------- | -------------- | ---------- | ------ | ------- |
| Identity Mgmt     | **Unknown** | **No**         | **No** (1) | **No** | **No**  |
| BasicService      | Yes(2)      | Yes (2)        | **No**     | **No** | **No**  |
| ActivityTrail     | **No**      | **No**         | **No**     | **No** | **No**  |
| BasicESService    | **No**      | **No**         | **No**     | **No** | **No**  |

1. Scripts are out of date  
2. Verified 11/29/2019

---

## Can we run unit tests?

|                   | API     | Business | Event Source | Command Source  | 
| ----------------- | ------- | -------- | ------------ | --------------- | 
| Identity Mgmt     | **No**  | Yes (1)  | Yes (1)      | Yes (1)         |  
| BasicService      | **No**  | **No**   | N/A          | N/A             |  
| ActivityTrail     | **No**  | **No**   | N/A          | N/A             |  
| BasicESService    | **No**  | **No**   | **No**       | **No**          | 

1. Verified 12/1/2019

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

---

## Can we route under one domain?

|                   | Locally     | Docker-compose | Kubernetes | AZ         | AWS         |
| ----------------- | ----------- | -------------- | ---------- | ---------- | ----------- |
| Identity Mgmt     | N/A         | **No** (1)     | **No** (1) | **No** (2) | **No** (3)  | 
| BasicService      | N/A         | **No** (1)     | **No** (1) | **No** (2) | **No** (3)  | 
| ActivityTrail     | N/A         | **No** (1)     | **No** (1) | **No** (2) | **No** (3)  | 
| BasicESService    | N/A         | **No** (1)     | **No** (1) | **No** (2) | **No** (3)  |

1. Plan to use Envoy reverse proxy
2. Plan to use AZ  Route/Gateway
3. Plan to use AWS Route/Gateway

---

## Can we authenticate into application?

|                   | Locally     | Docker-compose | Kubernetes | AZ         | AWS         |
| ----------------- | ----------- | -------------- | ---------- | ---------- | ----------- |
| Identity Mgmt     | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| BasicService      | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| ActivityTrail     | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| BasicESService    | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  |

All solutions plan to use swappable front end network library.
1. Plan to use (Envoy?) reverse proxy
2. Plan to use AZ  Route/Gateway
3. Plan to use AWS Route/Gateway

---

## Can we authorize application use?

|                   | Locally     | Docker-compose | Kubernetes | AZ         | AWS         |
| ----------------- | ----------- | -------------- | ---------- | ---------- | ----------- |
| Identity Mgmt     | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| BasicService      | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| ActivityTrail     | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  | 
| BasicESService    | N/A         | N/A            | **No** (1) | **No** (2) | **No** (3)  |

All solutions plan to use swappable front end network library.
1. Plan to use (Envoy?) reverse proxy
2. Plan to use AZ  Route/Gateway
3. Plan to use AWS Route/Gateway

