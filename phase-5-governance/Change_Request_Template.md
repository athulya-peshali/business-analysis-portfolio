# Change Control Request (CR) Form

## 1. Request Details
* **Change Request ID:** `CR-001`
* **Project Title:** Real-Time Inventory & Order Synchronization System
* **Request Date:** 2026-11-19
* **Requested By:** Operations Lead
* **BA Lead:** Athulya Herath

---

## 2. Description of Proposed Change
* **Title:** Integration with 3PL Logistics Carrier APIs (FedEx / DHL)
* **Description:** Add dynamic shipping cost calculations and tracking link generation during order checkout.

---

## 3. Business Justification
Reduces customer support inquiries regarding order status by 25% and automates carrier manifest creation for warehouse staff.

---

## 4. Impact Analysis

| Impact Dimension | Assessment / Magnitude |
| :--- | :--- |
| **Scope Impact** | Requires 2 new external API microservice integrations. |
| **Schedule Impact** | Extends project delivery timeline by 2 Sprints (+4 weeks). |
| **Cost Impact** | Estimated at +$12,000 for carrier API sandbox licensing & dev effort. |
| **Risk Level** | Medium (Third-party API latency dependencies). |

---

## 5. Change Control Board (CCB) Decision

* [ ] **Approved**
* [ ] **Rejected**
* [x] **Deferred** *(Moved to Post-Launch Phase 2 Roadmap)*

**Reasoning:** Core real-time inventory locking must be stabilized and tested before introducing third-party logistics integrations.
