Return-Path: <linux-edac+bounces-4766-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4BB505B5
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD36170E95
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55035CEB6;
	Tue,  9 Sep 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BRI2Utot"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBB31C591;
	Tue,  9 Sep 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444302; cv=fail; b=UMYfr57SU8hh5ECYVVgk6Mw8tOyyjAYKKew14kKFxV3NYklG8o5fOuS1y9DG8qxL0V0OE6xhET4Lgz1BzCQIq4QzXqM4fAOM0HoTPLhmBoo2YjTc0KonT1lijDUhhPSqXtORA9Szz1ZDYacSv9DNWAC6NOYZuQHII/yli3+4MCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444302; c=relaxed/simple;
	bh=cViyOlrRjtwLmyqvbpghQ2EO4khuiue/fyXLuELqvrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6gIeWaLnr7VwMPGZSO5vF6enwfqCJ7pASGiDMUydDK/dv538g9Q5K/7sliS7x7zMsc1blU6P7I6cfojtGfQJjjNuL73bTt0mfS1WdM0giRPo8qiKr58mi4csqPKFmgVQP2qJ5SNk4l3NYnqmB/bta/wjY4pK0sUfkCoDlNXHio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BRI2Utot; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKXn2fYGl/Fc//Oet3cKOdZFsSaXRnQEkTgOq5NkO2x16ij+X53khvEq4drpp6TgahzNARJ03CVD9HOvWkC2tvUQG8d4AaMCwprUngDPTN0OgihVQDBeimOJBRZ58BhZvrDV3FOAZy/UvQ9M3nq7lH8vcx5GsEukMQZl3dXC3Ku3taXtUpe7uvFmLt147+6IcrwKev1+1Z6vX+Wu9o6NTpaTCfXfkjaHcMIyII8EVEEIUMB5vi9QcI7WHWX/jP+REtFEOo3GtCJiBFL9WqLh6lOd8ExdHC5GW5I1CHAvi0RW4iCGKpxcjYuye+8jxfVt7yy72nzYnN/9JikQvdd/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FBhmayHH4Vvws/qRJuEuIPAQWSRTrspZRfYXUI9UNY=;
 b=QbrG3wpdZLeAUv7gckhHS/oO+AtV6bl9kHHhS1qqMk9wtHOcB/UO04801IPPJ18JEfL4NbfEncOE/kSSr+U+ubU+UfKiE1rnxcAdN/RuS6URWv40Ck+JWoR/7pFBnFuAikxDa/KnpghkT8eygmaP7HVEGKx0AExvVj7nEdLroOJRt8rS9bTsEPIqJoQ/2vU3FiNpa2Sx1xGwQcXj4/SXc2ZQ5N7XTX1z3038/a9sEIEopaMGoaNBJtuvB0GeakOK4cKAEahJhEHway4py9FJOqUABTz6dUvo8sILsj2ECCJC+ST7fxGJYeAAre6KLsWJQXzjos86BfOITNLWE0G5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FBhmayHH4Vvws/qRJuEuIPAQWSRTrspZRfYXUI9UNY=;
 b=BRI2Utot0QX7Y7reuJHWEehIfYP72SP9e0IA7nb4xU3uBSB77ALUqu1/GDFddKp4FhJAIa9JBzk2DAT6BSBaC7JsUuc/PKBXTZCqlzFpK4qzEkk54mUX6jrXNWOXD3tWPIh9nDiD9c/PAD4qkqt1Ln1ukucxLJQEwmV3FN6UQJw=
Received: from BN8PR15CA0060.namprd15.prod.outlook.com (2603:10b6:408:80::37)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 18:58:17 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::e4) by BN8PR15CA0060.outlook.office365.com
 (2603:10b6:408:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 18:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:58:17 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:58:15 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 2/5] EDAC/amd64: Remove NUM_CONTROLLERS macro
Date: Tue, 9 Sep 2025 18:53:11 +0000
Message-ID: <20250909185748.1621098-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909185748.1621098-1-avadhut.naik@amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7d09ab-b204-4dd0-b02d-08ddefd2d674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAOF43NL9Vej960YcaJGHn/7Eod3nu/tWEqM7xr/jr43Lgi4WF+0kjKTJULP?=
 =?us-ascii?Q?dZqcdn7l5+97Qw3kEi4IwEqCoJ5gYt1Cvfykh6yHhoE2xU9cDL/+by2mOlxc?=
 =?us-ascii?Q?KNuIKDJWY9JLVphI4L4N44aiDLZKhf3xegzOxigjyoUU/E1pyggkRye3xL19?=
 =?us-ascii?Q?/xUesq/BcBWAvWEcXk2J5Or+Z3MQ1Kpa3di46cEMgc4lHVH9inkN+yz8AHq2?=
 =?us-ascii?Q?rLAfZT+jVVY1IUKEUz+5N5k40AARsseJTT1SZKJFmv6daWq1JeJwtK/SklEM?=
 =?us-ascii?Q?rJfAMFy/vWjavf3sxapDGQ2vUFTKgXyQ8CGf36/9+byoTarZHW0SY+MiiVIj?=
 =?us-ascii?Q?ch4Jjxrxg3ExVEesBQYWfLp0E191QLdukS3szKOW6OitMEeaQ6/NMkVGi1Za?=
 =?us-ascii?Q?+AxP6bjTzB1bU+CX1YZlOKAEvwiaU3dLBTCM2YaLGsd2kFXbwcehSWrXcTOg?=
 =?us-ascii?Q?wo7plvyFJa4HGT8yJ6h+My2nOkxbxsMzRsrZtUW15sDka+c6oQ3DvV1ieOqo?=
 =?us-ascii?Q?JIaHwayvjUEKOhvXjyMWvKYLuh0TrSeWlFOL/9ekeVgzAllRgaJy1H1hBi5j?=
 =?us-ascii?Q?qFjcZu6OfrbL1C1kBAs0fiGeOdNjpLu9SFzWvYIDr3HoCs/3MDmDEkr+4sk5?=
 =?us-ascii?Q?xkqyrcrUhUIndG8cg/ANaKF2q/vtsPAuwpctq0Now7uOSQIH7rjVAaQ+E20c?=
 =?us-ascii?Q?cwRhzcpFzzIz3MQOBq7APa5HZZb9yi+P7KmqrTsv28j7DDxOKn6enEu8h9pQ?=
 =?us-ascii?Q?9iQKwvgS+ZQDf1VmgULLiHNo75IwLtCrj1Qbs5tN1b+O7SBsdNDgrz+fYq2U?=
 =?us-ascii?Q?YO1MOUYbkQjyVE6aiucCAOmcdNNyumkNKXcOA77CgaAAqrhu1V487+BmYdT3?=
 =?us-ascii?Q?kYVS9lT7s/Km7aA2vuGW0INYgVJ4Rt5hkysX5yKVsfsefOWYrvgq9DJoJtI/?=
 =?us-ascii?Q?oh7pHIDz8e6p6YSAAPIrkby5PPdvb9biq6rVzT2QBKMYBEEi/4XWS7Yz+AIP?=
 =?us-ascii?Q?DlShwKlX/ABfCuV5fdzdWxupmFev1m7EqZU6kltLTB7OTLmrmVRbmCKFmco5?=
 =?us-ascii?Q?VKTYhbbxDUOyaFHoBPr6z5XTsOfeqyr0/l3mG1nbwnuCrntb6JTueIbbMUCz?=
 =?us-ascii?Q?HcYzIuz+p0q7svFTgD+hJTkQPMX2ZIAAd676S5D9BHvuRw9UkeYe/kCnMW76?=
 =?us-ascii?Q?clnBTC5lZlnkKWe3Wd0un2K2mui1GD8c83jO2PhGp6HUsvAzOj3xjR4YLa8s?=
 =?us-ascii?Q?j7WkWu/ilEu8XsT8QagMhQXDkL4B6C+CFSeEQE8W5JwUbwae5flyU64GVNFn?=
 =?us-ascii?Q?zyGj8It8cJMJXtrGoz2KrVzrxcrgat3PmiaAt+aAVOgJUqryXcCmzDuQxSWD?=
 =?us-ascii?Q?5mNreToeKg6s7IS8DOQ3IaZxaQgNHIE5uYQrci7gBKlKZUUb1pIRoIeoW8bE?=
 =?us-ascii?Q?UFqjDzF8jZ0fKyK2WHwfeUw8qy3srmNJJjeh2Hek+gUt5idrnCnQ99XVlI/3?=
 =?us-ascii?Q?T8at7ewZ4zubSf/Gyfom4CKLEaeNnNzcpue5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:58:17.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7d09ab-b204-4dd0-b02d-08ddefd2d674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

Currently, the NUM_CONTROLLERS macro is only used to statically allocate
the csels array of struct chip_select in struct amd64_pvt.

The size of this array, however, will never exceed the number of UMCs on
the SOC. Since, max_mcs variable in struct amd64_pvt already stores the
number of UMCs on the SOC, the macro can be removed and the static array
can be dynamically allocated instead.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v3:
Patch introduced.
---
 drivers/edac/amd64_edac.c | 19 +++++++++++++------
 drivers/edac/amd64_edac.h |  5 ++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3989794e4f29..0fade110c3fb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4000,30 +4000,34 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
 
+	pvt->csels = kcalloc(pvt->max_mcs, sizeof(*pvt->csels), GFP_KERNEL);
+	if (!pvt->csels)
+		goto err_enable;
+
 	ret = pvt->ops->hw_info_get(pvt);
 	if (ret < 0)
-		goto err_enable;
+		goto err_csels;
 
 	ret = 0;
 	if (!instance_has_memory(pvt)) {
 		amd64_info("Node %d: No DIMMs detected.\n", nid);
-		goto err_enable;
+		goto err_csels;
 	}
 
 	if (!pvt->ops->ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
 		if (!ecc_enable_override)
-			goto err_enable;
+			goto err_csels;
 
 		if (boot_cpu_data.x86 >= 0x17) {
 			amd64_warn("Forcing ECC on is not recommended on newer systems. Please enable ECC in BIOS.");
-			goto err_enable;
+			goto err_csels;
 		} else
 			amd64_warn("Forcing ECC on!\n");
 
 		if (!enable_ecc_error_reporting(s, nid, F3))
-			goto err_enable;
+			goto err_csels;
 	}
 
 	ret = init_one_instance(pvt);
@@ -4033,7 +4037,7 @@ static int probe_one_instance(unsigned int nid)
 		if (boot_cpu_data.x86 < 0x17)
 			restore_ecc_error_reporting(s, nid, F3);
 
-		goto err_enable;
+		goto err_csels;
 	}
 
 	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
@@ -4043,6 +4047,8 @@ static int probe_one_instance(unsigned int nid)
 
 	return ret;
 
+err_csels:
+	kfree(pvt->csels);
 err_enable:
 	hw_info_put(pvt);
 	kfree(pvt);
@@ -4077,6 +4083,7 @@ static void remove_one_instance(unsigned int nid)
 	/* Free the EDAC CORE resources */
 	mci->pvt_info = NULL;
 
+	kfree(pvt->csels);
 	hw_info_put(pvt);
 	kfree(pvt);
 	edac_mc_free(mci);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 56999ed3ae56..39d30255c767 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,6 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			12
 
 #define ON true
 #define OFF false
@@ -347,8 +346,8 @@ struct amd64_pvt {
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
 
-	/* one for each DCT/UMC */
-	struct chip_select csels[NUM_CONTROLLERS];
+	/* Allocate one for each DCT/UMC */
+	struct chip_select *csels;
 
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
-- 
2.43.0


