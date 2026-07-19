# Каталог доменных событий

## PatientRegistered — Зарегистрирован новый пациент

- **Контекст-источник**: Patient Care;
- **Семантика**: новый пациент зарегистрирован в системе клиники, создан агрегат `Patient`;
- **Контракт**:
  ```json
  {
    "eventType": "PatientRegistered",
    "eventVersion": "1.0",
    "payload": {
      "patientId": "uuid",
      "registeredAt": "timestamp",
      "clinicId": "string",
      "status": "active"
    }
  }
  ```
- **Подписчики**: Data Platform (Streaming Data Mart Patient Care).

## DiagnosticStudyOrdered — Назначено диагностическое исследование

- **Контекст-источник**: Patient Care;
- **Семантика**: врач назначил пациенту диагностическое исследование в рамках `TreatmentCase`;
- **Контракт**:
  ```json
  {
    "eventType": "DiagnosticStudyOrdered",
    "eventVersion": "1.0",
    "payload": {
      "caseId": "uuid",
      "patientId": "uuid",
      "studyType": "string",
      "orderedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: AI Diagnostics, Data Platform.

## DiagnosticSessionCompleted — Пройдено исследование ИИ

- **Контекст-источник**: AI Diagnostics;
- **Семантика**: ИИ-сервис завершил анализ; событие несет только факт и метаданные, не результат диагностики;
- **Контракт**:
  ```json
  {
    "eventType": "DiagnosticSessionCompleted",
    "eventVersion": "1.0",
    "payload": {
      "sessionId": "uuid",
      "caseId": "uuid",
      "modelVersion": "string",
      "status": "completed | failed",
      "completedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Patient Care, Fintech, Data Platform.

## TreatmentCaseClosed — Случай лечения закрыт

- **Контекст-источник**: Patient Care;
- **Семантика**: лечение завершено, все исследования закрыты;
- **Контракт**:
  ```json
  {
    "eventType": "TreatmentCaseClosed",
    "eventVersion": "1.0",
    "payload": {
      "caseId": "uuid",
      "patientId": "uuid",
      "closedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Fintech, Data Platform.

## InvoiceIssued — Выставлен счет за лечение

- **Контекст-источник**: Lending & Payments;
- **Семантика**: сформирован счет на основании закрытого / частично закрытого случая лечения;
- **Контракт**:
  ```json
  {
    "eventType": "InvoiceIssued",
    "eventVersion": "1.0",
    "payload": {
      "invoiceId": "uuid",
      "caseId": "uuid",
      "amount": "decimal",
      "currency": "string",
      "issuedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Financial Reporting, Data Platform.

## LoanAgreementCreated — Создан кредитный договор

- **Контекст-источник**: Lending & Payments;
- **Семантика**: клиенту одобрен и оформлен кредитный договор;
- **Контракт**:
  ```json
  {
    "eventType": "LoanAgreementCreated",
    "eventVersion": "1.0",
    "payload": {
      "loanId": "uuid",
      "customerId": "uuid",
      "invoiceId": "uuid | null",
      "amount": "decimal",
      "rate": "decimal",
      "createdAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Financial Reporting, Data Platform, Partner Integration.

## PaymentProcessed — Платеж проведен

- **Контекст-источник**: Lending & Payments;
- **Семантика**: платеж успешно проведен;
- **Контракт**:
  ```json
  {
    "eventType": "PaymentProcessed",
    "eventVersion": "1.0",
    "payload": {
      "paymentId": "uuid",
      "loanId": "uuid | null",
      "invoiceId": "uuid | null",
      "amount": "decimal",
      "processedAt": "timestamp",
      "status": "success | failed"
    }
  }
  ```
- **Подписчики**: Financial Reporting, Partner Integration, Data Platform.

## SupplyOrderFulfilled — Заказ поставки выполнен

- **Контекст-источник**: Partner Integration;
- **Семантика**: партнер подтвердил выполнение заказа после подтвержденной оплаты;
- **Контракт**:
  ```json
  {
    "eventType": "SupplyOrderFulfilled",
    "eventVersion": "1.0",
    "payload": {
      "orderId": "uuid",
      "partnerId": "string",
      "fulfilledAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Inventory & Assets, Data Platform.

## InventoryLevelChanged — Изменен остаток на складе

- **Контекст-источник**: Inventory & Assets;
- **Семантика**: изменение остатка оборудования / материалов;
- **Контракт**:
  ```json
  {
    "eventType": "InventoryLevelChanged",
    "eventVersion": "1.0",
    "payload": {
      "itemId": "string",
      "locationId": "string",
      "delta": "int",
      "reason": "string",
      "changedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Financial Reporting, Data Platform.

## EmployeeOnboarded / EmployeeOffboarded — Сотрудник принят / уволен

- **Контекст-источник**: HR;
- **Семантика**: изменение статуса сотрудника, важно для планирования нагрузки клиник и расчета ФОТ;
- **Контракт**:
  ```json
  {
    "eventType": "EmployeeOnboarded",
    "eventVersion": "1.0",
    "payload": {
      "employeeId": "uuid",
      "clinicId": "string",
      "position": "string",
      "startedAt": "timestamp"
    }
  }
  ```
- **Подписчики**: Financial Reporting, Data Platform.

## Соответствие источников и подписчиков

| Событие                               | Источник            | Подписчики                                              |
|---------------------------------------|---------------------|---------------------------------------------------------|
| PatientRegistered                     | Patient Care        | Data Platform                                           |
| DiagnosticStudyOrdered                | Patient Care        | AI Diagnostics, Data Platform                           |
| DiagnosticSessionCompleted            | AI Diagnostics      | Patient Care, Fintech, Data Platform                    |
| TreatmentCaseClosed                   | Patient Care        | Fintech, Data Platform                                  |
| InvoiceIssued                         | Fintech             | Financial Reporting, Data Platform                      |
| LoanAgreementCreated                  | Fintech             | Financial Reporting, Data Platform, Partner Integration |
| PaymentProcessed                      | Fintech             | Financial Reporting, Partner Integration, Data Platform |
| SupplyOrderFulfilled                  | Partner Integration | Inventory & Assets, Data Platform                       |
| InventoryLevelChanged                 | Inventory & Assets  | Financial Reporting, Data Platform                      |
| EmployeeOnboarded / EmployeeOnboarded | HR                  | Financial Reporting, Data Platform                      |
