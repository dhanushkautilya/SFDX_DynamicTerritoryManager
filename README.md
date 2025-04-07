# SFDX_DynamicTerritoryManager
# 🌍 Dynamic Territory Manager (DTM)

Dynamic Territory Manager (DTM) is a customizable Salesforce-native solution for managing and assigning territories based on User **Profiles**, **Roles**, **Regions**, and other custom logic. This project is built using Apex, Lightning Web Components, and Custom Metadata for a fully configurable Territory Assignment Engine.

---

## 🚀 Features

- 🔄 Dynamic User-Territory assignment based on rules
- 🧠 Metadata-driven rule engine
- 🧭 Visual map of Territories and assignments (via LWC)
- 📢 Real-time notifications with Platform Events
- ⚡ Efficient list views with Apex Cursor-based Pagination
- 📊 Admin dashboard for Territory insights

---
## 2. Custom Metadata Design
🧩 Metadata: Territory_Rule__mdt
- Field API Name	Type	Description
- Profile__c	Text	Profile Name to match
- Role__c	Text	Role Name to match
- Region__c	Text	Region field on User to match
- Territory_API_Name__c	Text	API name of related Territory__c record
## 🧩 Metadata: Territory_Definition__mdt
- Field API Name	Type	Description
- Name	Metadata Name	Used for reference by rule
- Region__c	Text	Optional: Region this territory covers
- Map_Color__c	Text	UI color for map view (hex or color name)
