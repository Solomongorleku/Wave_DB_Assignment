--QUESTION 1
SELECT COUNT (u_id)
FROM users;

--QUESTION 2
SELECT COUNT(transfer_id)
FROM transfers
WHERE send_amount_currency = 'CFA';

--QUESTION 3
SELECT COUNT(DISTINCT u_id)
FROM transfers
WHERE send_amount_currency = 'CFA';

--QUESTION 4
SELECT COUNT (atx_id)
FROM agent_transactions
WHERE EXTRACT (YEAR FROM when_created) = 2018
GROUP BY EXTRACT (MONTH FROM when_created);

--QUESTION 5
SELECT COUNT (agent_id)
FROM agent_transactions
WHERE agent_transactions.when_created >= NOW()-interval '1 week' AND
amount > 0 or amount< 0
GROUP BY amount > 0;

--QUESTION 6
SELECT COUNT (agent_transactions.atx_id)
AS atx_volume_city_summary, agents.city
FROM agent_transactions LEFT JOIN agents
ON agent_transactions.agent_id = agents.agent_id
WHERE agent_transactions.when_created > NOW()-interval '1 week'
GROUP BY agents.city;

--QUESTION 7
SELECT COUNT (agent_transactions.atx_id)
AS atx_volume_city_summary, agents.city, agents.country
FROM agent_transactions LEFT JOIN agents
ON agent_transactions.agent_id = agents.agent_id
WHERE agent_transactions.when_created > NOW()-interval '1 week'
GROUP BY agents.city, agents.country;

--QUESTION 8
SELECT SUM (transfers.send_amount_scalar)
AS send_volume_by_country, transfers.kind AS transfer_kind,
wallets.ledger_location AS country
FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
WHERE transfers.when_created > NOW()-interval '1 week'
GROUP BY transfers.kind, wallets.ledger_location;

--QUESTION 9
SELECT SUM (transfers.send_amount_scalar)
AS send_volume_by_country, transfers.kind AS transfer_kind,
wallets.ledger_location AS country, (SELECT COUNT (DISTINCT transfers.transfer_id) AS transaction_count),
transfers.u_id AS number_of_unique_senders
FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
WHERE transfers.when_created > NOW()-interval '1 week'
GROUP BY transfers.kind, wallets.ledger_location, transfers.transfer_id, transfers.u_id;

--QUESTION 10
SELECT DISTINCT transfers.source_wallet_id, transfers.send_amount_scalar
FROM transfers
WHERE send_amount_currency = 'CFA'
AND send_amount_scalar > 10000000
AND transfers.when_created BETWEEN '2020-06-01' AND '2020-06-30'
GROUP BY transfers.source_wallet_id, transfers.send_amount_scalar;

