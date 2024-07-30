Return-Path: <linux-edac+bounces-1584-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD47941551
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 17:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7678E282A3E
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB331A2C20;
	Tue, 30 Jul 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rNdixRy4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2829A2;
	Tue, 30 Jul 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352758; cv=fail; b=FCvKbo7Xuf1WWcD4eOcH+qpE3Bl5CD4KVjROYXn6T74FjuVl54Xi2fLO8EFVum0xLF8nsEfUWkEpmlqJhTkQmyNzXBKl8eoGUGHWtBeMpFsZiguRjF82tMoD0wGNrL/MEQ0mwkHfUQ+5tqFFyVy2L9ASp/POhZVjuORW3AEZUsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352758; c=relaxed/simple;
	bh=ED4JtKXJBKAk1HoxfUuGEQW3Hcc1pF8VaREvraqxOHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EOyVdZiyWBINO26DvclETI89SVFZQnY9lpaFxITaGkEX8LXZTe1Xt1f94/Bfcx2wbUiV5uzKORLvwtQN9XevWwoLQW22NAmZT4yQ81RPU2VwCk8k9T7Ih3HaEo/4xo7H29qRXO4VzSbd5MLw/kCUHKqnTfej5V1fGISEbvjyPcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rNdixRy4; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClSY/0fljpbBRozgXmgNwRKmc8zM+N5gSlCsx9R1nwu6gLJ8xXaLXZ+h+pPzHRbhkYHFoxDzIU6qXlfsf2hjZ4VczMqGIA14Y5XHPnHP4+CUSDfmkIu+JiKWy2qXKuLXC6JZ0zbdclBEvCDTI2SyIL6Vi4A8tA/Ru+irOQvqqyNFcAVvcnPzPAjPiaeqXCHMSSe2qr9UTnGn8K9RU7y7hUY/WN/sH/5CEYeldvU31kkGsps/l6FhOecL2NUibzCkPsub5uXoEe0TRPEo+4S9eQxeF/7T7VFBaI5PE1G+MY8E6UMuL+r1VQhP9BtLVZrPy/sDlcqL/ECDxiATYQhmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8nNzDQee8m8jkTEC+SyDo3WN7IxKeN1hiG6mNbVXxI=;
 b=UbdMssWHM5bGiYXFpqQki8MUleS70PgMyk71bjMZ8MiuTfHrTUsFzUJejppe75wfMyKUhVm5CEskXemQHvKUb2ceeLqokUGmxF97P+8dZbFVgn6B9UlPl6LY1gnhIIrF/0B5lTfVe2CLjv4l7seZ2gqom++/Nv+SCkYORPnddR9kEhwwm/tioDJS4MCJS+WbD5YGXcFlmLp+WbN8/sBBDdYAGcJyHLJGJd8NTIj9AuidTZUptiumPXNsXKScKHNH464ZcePpkjrRiLvRcugkOuhEnz5fJ5/smLZ8FRPlR/SjSsmkbUFaxJoQLdPY0OHgcvHngjKMZdPl5KYeriXtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8nNzDQee8m8jkTEC+SyDo3WN7IxKeN1hiG6mNbVXxI=;
 b=rNdixRy4tKpVhVErwtSCY5k6/fK2ZBgLMdOa5NEQ+mx3NbV3eSjkRV8f6ELSOgvSWQTVn3yfYdC4vvizHuNwvuLCAaZuL4bZtDZxrIR9Mf4VacmbtrXQlu3NEsUbEwfkR9GRUN2iEvW6z1DJAFvTWveoRVU8JIGwLRJIfVFCF4c=
Received: from BYAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:74::21)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 15:19:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::11) by BYAPR05CA0044.outlook.office365.com
 (2603:10b6:a03:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 15:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 15:19:12 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 10:19:11 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 0/2] PRM handler direct call interface
Date: Tue, 30 Jul 2024 15:17:29 +0000
Message-ID: <20240730151731.15363-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 625a32e7-9187-41e7-c17b-08dcb0aaf790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXZNdHExNVFVdk5XZ0hJR2FVcytoT01JZktaWjFuNmkvVXFVaE90bVg1Y1E0?=
 =?utf-8?B?TUNqRG1iZmV1V29rSnE3RzVibmZtWU5abytaa25tZ0VtcjJpeFhWbkJhaTZt?=
 =?utf-8?B?MEc0MEJzVU5vUWswZkJwWEgxWnlVQnlXQ0FiRk1XMVgybjZnYjZVdjhOaktq?=
 =?utf-8?B?Y0hyTytNejFlaVZHYktmOG15eHhQSnM3YWVCTGQxZHNMR2lLZk1KN2lBU0s3?=
 =?utf-8?B?WmV2VVZLa0hBU080Tm9TMFVmUzBZcEw4M0tmSHdhZmVNQ2tTdDd6NEJ4NjY4?=
 =?utf-8?B?TkFoMEpTMVVrbWZ5cElKR0J4VExnTWtKVk93ZjU4TkZrVmZLclArQUw3SHpM?=
 =?utf-8?B?OGZJOEZHc2VjdlByMWxFQmZDV2lDQlI5MHI2eWpTN2NDVDFzYm9lV2hJRnp6?=
 =?utf-8?B?a2p5bmp3ZGJYWDU0dXhoRWgwei9HeEhXd1JndnRmUlpCUGFJNjg1Y2hJZmZU?=
 =?utf-8?B?aVhGajI4UTZmeVdsRDlDQ3lTMW9iK0VzUG8xL2RvMUlBaUYrUUZOSkhIU0gx?=
 =?utf-8?B?eElrbnY0KzNXS1BFcFZsNGdJNGNTdzRoc1FWKzF0a3pmb3FRSm9LTk5tdDVX?=
 =?utf-8?B?UUFJRUorS1oxa3NPU1NaVlpXeGw0U1ovaDhsQzJ0OU1DcFkrZitnaFcrOWln?=
 =?utf-8?B?MXpEb1F4cmYzdWRPbURmZ094dExlamlJOGt3OW45d3puV1pIcnpuZGh2SWhx?=
 =?utf-8?B?RUNIUXUxMHZqVThrYVZGdzA5Y0FqSlNTVld4VHhVSXQ3ZWR2cGpuaS9YcFpV?=
 =?utf-8?B?c1IwL1ZBTUhyVjR3dzdPTUdUTzZPK0lqVStKeTZQczFhbEV5eUNnSFlRM3kz?=
 =?utf-8?B?TzRLbGRJb3docUtaK1c5Q2R1ZFpuODNoc0J5K0NFWlVHK244SUdRQy9Tak96?=
 =?utf-8?B?Vk82VXR5K05xY3lXNklsVU54dU16SHY4STZ0alArcjhHSjRxUGY1UVVtRnZ6?=
 =?utf-8?B?U1JuK2hPNHhJbEIxUnNaaW1zMk5rcFQ2ZU5mOTJ2eFRDU0ZZVVUveEppSWYr?=
 =?utf-8?B?MVZnTWNIZTlOZ09ZbHhpVEtOdW90VFUyRlRic0x1bVIzMWlGSEdhU3ZkY013?=
 =?utf-8?B?WStSNU9ORXBtTUZPcnAwVWRQOEVLVnBQMWhLK0FEZm5FQXFPY01wc3NJYVZV?=
 =?utf-8?B?OUtjTVVaczc0TFY4d0tPS0sybzBjUzJTcFZTY0ZqZ3gvQjl2VVNvV2RJcHE3?=
 =?utf-8?B?K2xiRFp1TXZEcHZoSmsvbDBwNkJhUytvV3JUb0drT1Fhb0pEd1RjYWE5Tnl5?=
 =?utf-8?B?UWZjd2xncFN0YmJIWDIxeEMrWHA1bENMRTNmZFZ0bWRmM3RVK01OR0JDNWt4?=
 =?utf-8?B?N0J3NlFGM0RIYzlnNkV6QmhyRHhSVUVNc1duY1FqQUdKaGdqMUFGZ1dETlhu?=
 =?utf-8?B?UEpRVk9JL3p6RkhJbERPcmV6a2tmeDZGYVZXRm9iNGw1Z2czSkFDS1NtaFRw?=
 =?utf-8?B?OWRCc2x1MWtnWXl0S0JFK20xSjlOMzlJOFNmM1kzOXlLcVE4cmtSajhhcys4?=
 =?utf-8?B?NUlKdHk1MHlORkR3VkhteDNFOFJPMUdoQ1ozVVFrU1lrT3hBV1d0bDNXTE0w?=
 =?utf-8?B?KzRreU9MNFA5N2Eyek1lcEQ3STJ1VzhXaVIvZ3V2SFU3MDQrQ2o4eGNRallw?=
 =?utf-8?B?YS9XK0RYZFhycDNvQnFYT0hFL3dCZTR1SkVFM0VORFlxK2JqTlZhdmNGQ1V3?=
 =?utf-8?B?YWJDSkNnOHh5K3VpN1Z4V0NJZnh6eHR2LzRIeDVQZHNteFduaWthVVkwWHNW?=
 =?utf-8?B?TzZ2YUpMQ2R2Nk1ESDZLb1FldTNYQmI4bFkwbElzdytBemhzbGM1OURrcjhG?=
 =?utf-8?B?QnVXSnJ4dHE0R3doS1kyRnNnemVGV1dVZkRJR1dRQ0dFRFFFeU1jU2ppTm45?=
 =?utf-8?Q?bs/IKpKkWbGq5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 15:19:12.2749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a32e7-9187-41e7-c17b-08dcb0aaf790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

Platform Runtime Mechanism (PRM) introduces a means for the AML
interpreter and OS drivers to invoke runtime handlers from platform
firmware in order to remove the need for certain classes of SMIs.
Further details can be seen in the PRM specification[1].

Future AMD platforms will implement a PRM module in firmware that will
include handlers for performing various types of address translation.
The address translation PRM module is documented in chapter 22 of the
publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
ACPI v6.5 Porting Guide"[2].

While the kernel currently has support for calling PRM handlers from the
AML interpreter, it does not support calling PRM handlers directly from
OS drivers. This series implements the direct call interface and uses it
for translating normalized addresses to system physical addresses.

Thanks,
John

[1]:
https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf
[2]:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
Base commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

John Allen (2):
  ACPI: PRM: Add PRM handler direct call support
  RAS/AMD/ATL: Translate normalized to system physical addresses using
    PRM

 drivers/acpi/prmt.c            | 24 ++++++++++++++
 drivers/ras/amd/atl/Kconfig    |  4 +++
 drivers/ras/amd/atl/Makefile   |  2 ++
 drivers/ras/amd/atl/internal.h | 10 ++++++
 drivers/ras/amd/atl/prm.c      | 57 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 include/linux/prmt.h           |  5 +++
 7 files changed, 107 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

-- 
2.34.1


