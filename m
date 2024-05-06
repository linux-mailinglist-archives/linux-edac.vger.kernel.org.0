Return-Path: <linux-edac+bounces-1010-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C9B8BD412
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB601C21B9F
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394F158845;
	Mon,  6 May 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aXxnds5N"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5B1581F6;
	Mon,  6 May 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017710; cv=fail; b=AaX80NUl5EwiZToEw07LHABkn2PVpT8dnhUkOAVFbMZesxr4igCmFFfENpdlPND3kn3OtgzySdcodJJ5MWkNDVgMCCs8FtadasMJpoe6a/TY+ZBUxDkLldAPM7HmQmtdei0QHnrQeRB6+YvE6SeZltzUB1nf3iCx3aYh5XCgHsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017710; c=relaxed/simple;
	bh=eb51zKQ+aP6EEhzG8Qnsq7E8lu066RCanfOeyy00G2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAqjrqxxmgSJnUeqrmwmOCWbWSQ042J1maENlAyazBq1VSXNzpGFtTBJ5Y+3FBEnBTLb75ow4THGufGQ+J1APXUl7Z7YdOq30fGWOkNzIhvkuoPq8TD0PY17qTEZmRL/XlW1Ez31BhHw4/8v3s8A6hULkI/RSp/3PtK6NahrW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aXxnds5N; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRiD8bgXHVHvzKuWixaqqjiQsMuG/6L3lbyoRxWOmZB61bgC2ThDf0KLbrx+wA3S/bY9D4t2v0ayMC78kvefFvEl9zbJ8xo+QoZyinMfJ36D3jh8kCI0y2uTHYlN53wgqrSWn3N17f/xbX4505jZ59rEFqS5CNMRptPA+d1HReTKNCeoyfNJvuKxVxjHAkP/xp6vFSfrd/diJEzWPshqNqMpRG2lDWjazqcrAVUk/mUMwXqeJ35OCrz3xG7cXXOD/ap99JnSZx+k080PvaSZvZvxn1Ef4Y4Dv5DIvsyOyy6wTCU3GVwVQ6QZAV4UNlKW/LBBA9E+Qft2oOrgwZs/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StKeAzigTZODwHCE2UnmZz7m8/CKDASlEqRFb7tnBaQ=;
 b=UKO43Xn/LGrQsmtuX7IguRcZqmXZY4ITYqZQUY/nAgEvPIbKF1RQekxSbMJUIzmz0j1u9ngZcXSttNsscSu4aJyWQlL5wT5rPCbY97Vm2OJ6j7LACAO98FQAyXEZoJpn/OvbZbsOUvOdh2jENM2GW3X5s6rbBUH4i4Y9WEjj/LeCYjlAiC6TN1B3VVZ3uTtWF6aIF8sFXkODno2u7LlEMk/zbyTwso/i5Vyn8kYCYoxWQ1J3OgzdtW8g6x3ci/3Mt/Z7NrZ9RlPgX6Cr20xzS/2FxgO/FE1TtijBn0NyihdpUdGYboqGVi7qUuovKiaiF48OJYwM+nj6yMb1u7NSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StKeAzigTZODwHCE2UnmZz7m8/CKDASlEqRFb7tnBaQ=;
 b=aXxnds5N4IyYpFWdIAFQ6W4EiEUvo6ibZuhLkZsSsBUiDybwAavwvrZDu/bQBhhn5GGry2BM6XL8HCtgV3X+uhB3ERw425AzwQsQ0Sxa2mHc05bZq5b5Zej3ij3BHo1Bfe5SKlJI+BHLQ6ehcLCbI/wTOydzsaR9yTgViij8tFI=
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:48:26 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::2a) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 17:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 17:48:25 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 12:48:24 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 1/2] ACPI: PRM: Add PRM handler direct call support
Date: Mon, 6 May 2024 17:47:20 +0000
Message-ID: <20240506174721.72018-2-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506174721.72018-1-john.allen@amd.com>
References: <20240506174721.72018-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: aaeeb9e5-a1ed-46c2-25f5-08dc6df4baf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RNRIK7DKWn4IzN0Ax4vumWAni7ELbVsN8ID5qqCPHq/rBA/IhFGFR7szoX9D?=
 =?us-ascii?Q?7BZ42hrqTdkqdFDZAJ2Zmu1Y4dCk2PgBdjjyrW67HsM+fzCpbK7oXTljUzBj?=
 =?us-ascii?Q?BCIcySX9Wk/R/sDdSxF6BdKjabxC89f+GXWv+zte/meojvg4EXD2fcqBZhbz?=
 =?us-ascii?Q?IIA23YwqaPQo4m/o0hpA5Ko6J4aSZtBgnVmUojTMeteU+xf4j/SvmIFC39q2?=
 =?us-ascii?Q?YdNzm0Rc5EW0NdKCXt0vSxRRnKyrtBA+a1zQoUVxAnnJ+CabSXCX2ZJon/aB?=
 =?us-ascii?Q?nrI72ACmTQb+DStV+hhJRVWj5GCEkkSIwqsD+hkEH52spSZgJUx4/iQbXEIT?=
 =?us-ascii?Q?JJt1T4MXILWa9WXSNcZ8paBYwq70ebPALzV6B/0iLl4j019HdM9n5GwA4Am5?=
 =?us-ascii?Q?UDOv5fVyRIYCbhfdu3rSWNzKDE3+Wjdefep7ItAGWd2CFZ6w270Ul1rWwHWA?=
 =?us-ascii?Q?SL/BhzZoGoGaS3Nvv0KNz34oithARd4h1zqfnezEpGrt+ewAH0m8AdAmFvWJ?=
 =?us-ascii?Q?2pjXLpRcCJXd24GJRWcRdckXIiVVK7O/u4tWzcAbv/yE/9P/6CtluyZ3YHCc?=
 =?us-ascii?Q?5xjPRTTrREzSesxAQeUOIAjNpHf3SqFM0X5lNpjTNAQvWmvMAKWOKM5x/ItU?=
 =?us-ascii?Q?OzIlPtE4j0lShlOdEKwTMMZOWl6cjCyQnixE9ZCKeW9FKNtPhyaBynMusU1M?=
 =?us-ascii?Q?yMcJm7fmdT4+yOtl+G88lOXc3YYHBx/VzygKA16jbQIdTQ+l4agZqGo5JoTN?=
 =?us-ascii?Q?S1zsgNd2qRCtp8fPuTRS40xERlCuQYTBKT6yd7nR+UwPga7yqI+ym+j52oGg?=
 =?us-ascii?Q?sFeUhag223Gmhdv9YNoK529a60s5csPP6L63oGLc0XAvj5Oy7Z+MVKTjr34g?=
 =?us-ascii?Q?XYVzi2Z1GBxxW42b5ESfAJOmu4b4FkXk+ohLX0rOoRgrhEq7EDGQnMGPZ7Jt?=
 =?us-ascii?Q?7jjWouJwRBw53hbpxNArg++j+mo+0Zhz4XLS1BEd9l7CCLEqC2wRWOP40Wk4?=
 =?us-ascii?Q?B+QbvfzZDa531E0Ujtanbgmems9Ktt2BULhswn/w9qN3Qy/d+6KCeNp4ub7y?=
 =?us-ascii?Q?1q9T8m5wB/UCt+Q5pjK76H5k+SY8Rumzh0YRKxa1QGqrPg9+AFYusBnnO/pq?=
 =?us-ascii?Q?IxceC0WNeVX5UCrHcQJ0kg9+XFRrVKlTkOtiipOUxqW6VIwTkHRmbMbY0SvF?=
 =?us-ascii?Q?74rfn22UDbYSUsU2FSa2sVxONU2OWkHx0fCYi4JdvJD6L1CcC9dQNJCgyUgF?=
 =?us-ascii?Q?8P9sYeBARRLz28ymvLE/Zdiu6FPPZRZYJ4h0XJBPg6lBFHocXUurTief1Lrh?=
 =?us-ascii?Q?sHT/fmGUqHIaZOXwdgxAev1lEuYfDQS25wtYRfYHxYgZfhkCBdd/Ebu/mYGC?=
 =?us-ascii?Q?l7V/9J7x8BfMJ3ohk1McQqr+9TW6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:48:25.5440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeeb9e5-a1ed-46c2-25f5-08dc6df4baf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

Platform Runtime Mechanism (PRM) handlers can be invoked from either the
AML interpreter or directly by an OS driver. Implement the direct call
method.

Export the symbol as this will be used by modules such as the AMD
Address Translation Library and likely others in the future.

Signed-off-by: John Allen <john.allen@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v2:
  - Align statements setting fields in context buffer on '='
---
 drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
 include/linux/prmt.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..1cfaa5957ac4 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
 #define UPDATE_LOCK_ALREADY_HELD 	4
 #define UPDATE_UNLOCK_WITHOUT_LOCK 	5
 
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	struct prm_handler_info *handler = find_prm_handler(&handler_guid);
+	struct prm_module_info *module = find_prm_module(&handler_guid);
+	struct prm_context_buffer context;
+	efi_status_t status;
+
+	if (!module || !handler)
+		return -ENODEV;
+
+	memset(&context, 0, sizeof(context));
+	ACPI_COPY_NAMESEG(context.signature, "PRMC");
+	context.identifier         = handler->guid;
+	context.static_data_buffer = handler->static_data_buffer_addr;
+	context.mmio_ranges        = module->mmio_info;
+
+	status = efi_call_acpi_prm_handler(handler->handler_addr,
+					   (u64)param_buffer,
+					   &context);
+
+	return efi_status_to_err(status);
+}
+EXPORT_SYMBOL_GPL(acpi_call_prm_handler);
+
 /*
  * This is the PlatformRtMechanism opregion space handler.
  * @function: indicates the read/write. In fact as the PlatformRtMechanism
diff --git a/include/linux/prmt.h b/include/linux/prmt.h
index 24da8364b919..9c094294403f 100644
--- a/include/linux/prmt.h
+++ b/include/linux/prmt.h
@@ -2,6 +2,11 @@
 
 #ifdef CONFIG_ACPI_PRMT
 void init_prmt(void);
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
 #else
 static inline void init_prmt(void) { }
+static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	return -EOPNOTSUPP;
+}
 #endif
-- 
2.34.1


