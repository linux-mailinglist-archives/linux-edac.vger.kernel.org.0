Return-Path: <linux-edac+bounces-4214-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87987AE6857
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD791C21232
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8082D5C61;
	Tue, 24 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERq4wfXB"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBFB2D321D;
	Tue, 24 Jun 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774590; cv=fail; b=YrBA5mG26FQQrx4AgzTvGrYKf7NBgVId9hptRptq2VpI/tLe5Zr+u4W42u7R6Zvo4IEcRu6k11ilsr9AAT6OFIj3IIHEwaQfNTdRV4BG/46KJGTawL8fTssyYJ8V9oO+vy1Cr0eDdEabnB0YdC6VWgBZAn0EBNi15FWKmYctLEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774590; c=relaxed/simple;
	bh=avb12mJUpmk+z2+fCJyY1MC9aPsyIXO2RAD+x3SfHI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=me9tmOi5GFChk3k4qWQ3t4fFQ31NhfjhLzS9bzVibU4H+jIKnNNV8RFX3+2Vu7EwKWE1H+YPm9MgHwmL7RZw7gcicW4/fMPZ7IZDezO2dozOT9Mu/N1dlmJ6V4LF3ObK0L3nQdKg4gPnWcCBJZZCFtyLpLDi3h1T2RDhjqtczus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERq4wfXB; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4g5xnoAtJpPDeaZPOibHXOjGHMXI4ctb8PNCAn5OKjNtsJuyh6h9Ub8JH0mMqrR2zUNkdtgNyLI+fMMCeiTO6hzfDO4cbzAK5eDckneRBWNRmEARSC/Vf3Mi2rvAaJN6cCmoUyBd2PQlsovI6n8EG3vflec0UypWtOnEzUfSKav/rdmVjchkAp2BdT2qyn8qZXBgvuFKsFkxadfLJKFZcT9qYm91NfX/Jq7t17bINCuPkLQkR2AzC20vu5zwPMAQRaNH2lixd+oYws7CniYKezJSmcyFeqGFQhPLzogDVjXdKDkJM80QpVyo7L/1TmjfzHKJUJXvmmx34Nnf3XDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnLDuHh182yB8YN5atCJRAE1GZ6CuwAvZlepIQD8X5A=;
 b=ADF+wLy0LJfPK+5Puj09v/kM3bFDPzP0uoDvkTIcPMnODabfN3CFpi354XMXQS5WDZVqldesESh71vTBgCEsr10vFpGB8ZPAJgN0VQWwORzNbEDNeEON2n6KcsoZ8d0h3PMxj96LnZVJ3aiMWfOu+txpPPZ92mXe2H4b2HCL6DPUdvFVKyqxOciRxNuCj+WDWeeZbSeXvkl4Jq3dvDcpN2rgdGfk9RfrMthyjXCTza9V1BIMg/qy2W4jiZ1ztPCEjhXtRvWnvTtsoIpUUKnRvnx7t+vWvz+9G3Mg+o8kt5lRjoO7+lS+KjOd1J7AtLgkC646/cGc8SD0dnVCWrJO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnLDuHh182yB8YN5atCJRAE1GZ6CuwAvZlepIQD8X5A=;
 b=ERq4wfXBk9jvycW9x40ZEgHvOdC4NSbtb3uw9V2RyD8yRPgzg29iHw3P+LcTEp2SJE12LT7gwbzMza5jPjLGgKSzfkp/+JnDa8wt5asP4sGXaWkbxObiooSERjtrvMoyMzH7ZzEaah7bjCJFtBftV81gHsXhpIXOq+L2oZ03xus=
Received: from MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 14:16:26 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::b5) by MW4PR03CA0237.outlook.office365.com
 (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:24 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:15:56 +0000
Subject: [PATCH v4 01/22] x86/mce: Don't remove sysfs if thresholding sysfs
 init fails
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-1-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b0b6cb-296f-4efa-97ae-08ddb329b4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUlPU3hhSTFaUzdQYjhqZk4yM01tVGgxdUsrSzVHcWl0dGVKK1hzeVBOS3dJ?=
 =?utf-8?B?b1llTUVBL3d4RVFHdE5pYWZmb1dKVk15UCtsb2c1YmNlVzVnMXVuYk9lZ0VY?=
 =?utf-8?B?WEZTbzVnbDhobFZpRXlJc24vZmZld25NeERGSW5yOERlQlhKZ1gzUHowWDAy?=
 =?utf-8?B?ODNIVVBKMTRKVzlLYVZ4Y3JudmdDaXZWeXN3YmhTVkt1aTBvaytXRGozclF1?=
 =?utf-8?B?V1NEK0hMTGlYR0l1Z04xZVhEQnIwMVVCb09nYXRNbmtWNDVjY3g1ZmpxZFp1?=
 =?utf-8?B?NFRzaXFZdFZRUUg1RmVxMEY4VTBtQXVyYWpaa29kaGNncTM1MVRrdDBQTTJD?=
 =?utf-8?B?bzcyOHBzV0t2NjV2NU1mTWhBTnZSU3hCRzBPRXhiWVJlYytoNEhLNDQrZjZy?=
 =?utf-8?B?UlhiRkx0aktqT1lERXBMcFpROG8wakhWY3RTaW9SM1VIU1E4dXJkZlZsZ3R6?=
 =?utf-8?B?QjBCaTF5ZnJnUTNBWkFMZ1VrQi9Ga3hYQkc2cEx4R3QxMHY1dHFhemV0OG1v?=
 =?utf-8?B?MVJESnlaV0NHdmdHUmhPU2JvVVZhditVQ01vSThmNWd2MURPUm1XV0gzUGpr?=
 =?utf-8?B?WjVGMnJFcnBlTVpsUFJVdVB6a3BqdndnV2hyQWJoTExBMGNMYVRRWk1yc2NI?=
 =?utf-8?B?dDJDUGtMZlMxT1g5Z1JUMGRYbmFmVDlja2ZTNENrUHJpYUFPTk1EcG41NVdW?=
 =?utf-8?B?VlJnOHYweFdhRDU3M1pJZVhlTlkya05nSUMxd1oxc2NRbmw1VGN1SkJja250?=
 =?utf-8?B?c0dMc2djaVJDb3FyK21qVitxend0SFIrMklhb2h0aTBpK3ZMb1R4R3FsaG1s?=
 =?utf-8?B?Q3hvVEh1TFZGbWRLcTlHc3I0STJvakc0b2ZJSkFZSFhJcU80TnFyUVIxcXhN?=
 =?utf-8?B?SGI3SmtySUY1NmVObmJpYkdXQWpzb0c2ZDRWRWVWVEJUSml1WjJXaGF3bGRS?=
 =?utf-8?B?VWZiOWdyQmpVYm1NZ3IveVdXTnlLUjNiMk5BWk96RVNHQS81Qk5maVVGZXBy?=
 =?utf-8?B?dEQ3RXlrOGE0ZHdleGR3MW5iNlFKVG05b1FtclMxTlpOZ3ZiMkpzMDROWkdm?=
 =?utf-8?B?VkV0ZUprRUtzS0c3dEliYXlReDZVTzNVNGxKT0U2cHNpOHdUMXR2aGcvcHZr?=
 =?utf-8?B?ZStKL0I0NnRtdEZ6aktNVFRLdXZCNVBMNGhmUWNJM2RoZHpTd0FWVUN2U0t2?=
 =?utf-8?B?MUFuQ2NvK2xOM2VhekhFSTAxcjVnTDJ6WGNteEJGQzhXNCtmZFpaKzZCaXVp?=
 =?utf-8?B?OGgxU3ExcHM5TitGMDZGMGVxMEJyWkhCTDQyV0hnVmh0eFFocW5iNHcybXRp?=
 =?utf-8?B?QVJpSFR5ZHpGZDM5OVVmTHluRWNCaU00dThXejFzekdnczVjb1hZWW56MVZM?=
 =?utf-8?B?RlRpQTRST1lPVUUzM3pmUHJHdXJWdEd0QUZ3TUlyUlZ1TzJ4N1QzZ1VFN0JD?=
 =?utf-8?B?MjRUOTlGZzBSR2xxU3l3RG43K3BRT2pGZWZZU1BWL2R4cG9Jck9QV29QbVdB?=
 =?utf-8?B?L2xCeXN2YkhkeTY4R2NtL05ZNFIrRE9YcVlpUlBqaHRoQlJndjMyMW5FUHEv?=
 =?utf-8?B?R2M3MHNxRmtqcFZtRWNSLzNOdlpIWmFOLzgyOVBBY3U0dExSMjdWMWg0VWFB?=
 =?utf-8?B?NnFQRi9wLzVxK1plKzdIYk5nMUFTSlZBa0J5cUcva1hQOGZvblFmRlIvdU1T?=
 =?utf-8?B?cWdPeTFSd0R2c0dqaEpnbzZmUTUzMnNHQXBFUVd2Qk5vWUpiTmZFTFduMUFj?=
 =?utf-8?B?UEdoRUlvVG0zL0NsOFYxZ1JQNkVsdTJYMEJEWkZSWnZrY2kzd3NNL0NtVHJE?=
 =?utf-8?B?MG1Na1pqNkRKU0VlQitibTg3elRmQ25zckV4NXJBNlExdmVqN1hGdDBvK3Bk?=
 =?utf-8?B?alFOWEpjWDRwVjRCTlV2SVVFa2Z4QU9BR0JPZVdUYng1RWFBY2I5K2UzV3RF?=
 =?utf-8?B?U0tSQlkvaVpFR2RyazJqUjgvOGxtRzFkRjg3SGtzcERIbk55V3pnZ0NBV2JG?=
 =?utf-8?B?Z01nTzhXUlhqVkZ1RnBqWHk4WGQ4bDhjZkpqaG54Wkx3T3l1aTJRRG1qZE9s?=
 =?utf-8?Q?HMcSbH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:26.0583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b0b6cb-296f-4efa-97ae-08ddb329b4a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

Currently, the MCE subsystem sysfs interface will be removed if the
thresholding sysfs interface fails to be created. A common failure is
due to new MCA bank types that are not recognized and don't have a short
name set.

The MCA thresholding feature is optional and should not break the common
MCE sysfs interface. Also, new MCA bank types are occasionally
introduced, and updates will be needed to recognize them. But likewise,
this should not break the common sysfs interface.

Keep the MCE sysfs interface regardless of the status of the
thresholding sysfs interface.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-1-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.
    * Included stable tag but there's no specific commit for Fixes.

 arch/x86/kernel/cpu/mce/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9b3c5d4a52e..07d61937427f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2801,15 +2801,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;

-- 
2.49.0


