# Каталог агрегатов

## Bounded Context: Patient Care

### Aggregate: Patient

- **Aggregate Root**: `Patient`;
- **Ключ**: `patientId` (UUID, внутренний идентификатор);
- **Состав**: контакты, статус (активен / архивный), ссылка на текущий `TreatmentCase`;
- **Инварианты**:
    - `patientId` уникален и не переиспользуется после архивации;
    - Пациент не может быть удален физически — только переведен в статус `archived` (регуляторные требования к хранению
      мед. данных);
    - Изменение персональных данных (ФИО, дата рождения) требует подтверждения оператора.

### Aggregate: TreatmentCase

- **Aggregate Root**: `TreatmentCase`;
- **Ключ**: `caseId` (UUID), внешняя ссылка `patientId`;
- **Состав**: статус кейса лечения (открыт / в процессе / закрыт), список назначенных исследований, лечащий врач;
- **Инварианты**:
    - Кейс может быть закрыт только после закрытия всех связанных диагностических сессий;
    - Один активный `TreatmentCase` на пациента одновременно;

### Aggregate: MedicalRecord

- **Aggregate Root**: `MedicalRecord`;
- **Ключ**: `recordId`, ссылка `patientId`;
- **Инварианты**: доступ только в рамках контекста Patient Care.

## Bounded Context: AI Diagnostics

### Aggregate: DiagnosticSession

- **Aggregate Root**: `DiagnosticSession`;
- **Ключ**: `sessionId` (UUID), внешние ссылки `caseId`, `patientId`;
- **Состав**: тип анализа, статус (queued / running / completed / failed), метаданные результата;

## Bounded Context: Lending & Payments

### Aggregate: Invoice

- **Aggregate Root**: `Invoice`;
- **Ключ**: `invoiceId`, ссылка `caseId` (opaque);
- **Инварианты**:
    - сумма счета не может быть отрицательной;
    - статус переходит `issued -> paid / overdue / cancelled` строго по разрешенным переходам.

### Aggregate: LoanAgreement

- **Aggregate Root**: `LoanAgreement`;
- **Ключ**: `loanId`, ссылка `customerId`, ссылка `invoiceId`;
- **Состав**: сумма, ставка, график платежей, статус;
- **Инварианты**:
    - Договор создается только после проверки кредитоспособности, инвариант проверяется до создания события;
    - Сумма выданного кредита не превышает лимит, одобренный скоринговым сервисом;
    - Статус `active` невозможен без хотя бы одного связанного `Payment` в графике.

### Aggregate: Payment

- **Aggregate Root**: `Payment`;
- **Ключ**: `paymentId`, ссылка `loanId` или `invoiceId`;
- **Инварианты**: платеж неизменяем после подтверждения.

## Bounded Context: HR

### Aggregate: Employee

- **Ключ**: `employeeId`;
- **Инварианты**:
    - один активный трудовой контракт на сотрудника;
    - изменения ставки / должности версионируются.

## Bounded Context: Inventory & Assets

### Aggregate: InventoryItem

- **Ключ**: `itemId`, `locationId` (привязка к конкретной клинике / складу);
- **Инварианты**:
    - остаток не может быть отрицательным;
    - списание требует связанного документа-основания.

## Bounded Context: Partner Integration

### Aggregate: SupplyOrder

- **Ключ**: `orderId`, ссылка `partnerId`;
- **Инварианты**: статус заказа синхронизирован с событиями `Payment` из Fintech.
