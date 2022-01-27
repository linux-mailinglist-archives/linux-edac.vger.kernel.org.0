Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07A649EC9D
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiA0Ulk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:40 -0500
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:24801
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344090AbiA0Ulh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx9HV5OUV4gYycFnBy9GR83m3AvN41hmDewuO7q0Hu1h1QC0Fhj1aq6JQ8/3TC/c88hcVGCWiU6DKQpWCO51h/gXWTER0QPsMb6/g4BXGv+V7vHiNTakGCQS+yFXNdlQk7XHJ1gepcBkL0ntH6mgkcz+s+UL6nZ33xaA3N4rjl1+SpCjtrREB1GF5/mbbUywxcHaQ8tSXR/Iu4grLDTmRWA0G8RlvVOvd2ZOyQxH9FmnSYVSzIFTg23o7snguVnlGEXRmSCH4A/t6n+bqDqoqrpvco2tyMT6F5SvJl05478ILIltXlxdFNoYJI1T92uotmYxxrbpYOdZW9zsbWbn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6/OAn7qojhlagErBwD/8pHE4uH3BJi1gDS71igGXXA=;
 b=lqh6zVGQRSgidP6O6SKOXpVIN2qOeHVdE86fgtVI0zpJIBZWxzO/U4Qo2K6T95mohU9HEtYZN0r+d5XN5QazPd4s/3gfjRyjYSFzFMJdUp13tZcgMewEhSCPs2Yfz+9ns0ivVFtAFhHvAtbYeFoGyN9EX6dv3UdMl0iRU7dqTaJc7PUr2rDOVsPTRRkCegi59i3cy1dDpJX4+PPs8xDKsieG0qsdcHaih23p0sLulQcGilJq+UdxL0/x9Q7u8gbfxNjT0g/hd9ri//xV/fY/lNHsCg2he7kwGYZRwUdTL3VJGR0nbBl1S+Hr84F8uwFE2UmpQPWP+LX85vmoC4tYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6/OAn7qojhlagErBwD/8pHE4uH3BJi1gDS71igGXXA=;
 b=CeFOewFFN71oQ5yAPu8T6FUrvGDXI2oogtzokzQm5VAktfWI1RuIq30sad8pHe2pKmI9Je9ElrgAXFqn/lwMxOQZxagvGB3iGg+qh4bYvCxCXE8OfjgypvF+VD/30Wusc8a9mHB4LnpBbG7c57/CGMWdRudfOWRLkYByN8JqKjA=
Received: from CO1PR15CA0056.namprd15.prod.outlook.com (2603:10b6:101:1f::24)
 by MN2PR12MB3456.namprd12.prod.outlook.com (2603:10b6:208:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 20:41:35 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::af) by CO1PR15CA0056.outlook.office365.com
 (2603:10b6:101:1f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:34 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:33 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 01/24] EDAC/amd64: Define Data Fabric operations
Date:   Thu, 27 Jan 2022 20:40:52 +0000
Message-ID: <20220127204115.384161-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6bd5d02-1723-4404-9f00-08d9e1d5688a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3456:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB345693D9E5BDB7667E311E9DF8219@MN2PR12MB3456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +H+STWuw/Uo/gM8bIhfTu3Ki7EFDcYe1MgXWQjX7DelMiRzO4QXFbC9EGDtqthTYGd8gWY+wjLsy6MaPiOlbj/pSrLGwM49a5L5Mbqvaf7NGRjdz9dz5Dq4k0gTfrT1EUexNW3zz8WG54R/+cFWNsW32xQ4dbaZa6YlNe9rbev/2F2+SO0jJqDejBGipJYg4/V84zXya7J8ki76KOifw8EYFdGWhja9m9ZzWmMJatmry/Oe4URMIeXzd3DrqPlYcmPpF6TpLqZlnVLrtkzrxwr40TJQ8Pp3MaVqTV+iQ3FXKqs5lXFSKZNFLC+Op27kjHQctsmScoM2Y5InYXyr27r/iM7DNck5psBKi35FiD7itNVQMgq2ZHcoubbtFCaitB+msgQaeVxngv7gZuM6MF2SaYdAoRWPVUjxFvmCF7lfirFoCSXB0k/n222nvZP6WLxMZn8w2oExxpa1FwE7Q6ZRDyzUTeK7lxY5nOW6q+NiuM9exhCgRvCOTVwd/Lx+jOZPNU+yUdueHfVUfnFm/Zfs10/92/cYPX4ty+9j/cqkhFmcVRUZlVWBo0K7Fnvpn/QnejYyflOT4bPWhiahLla6vJ1OFPB5ni+XLnw8brcIcBUH6ld19lvWARWnjlrHxtcjVBZBoF65WF/FwQg23Io9y1RqbHQ+wGMItP+NBhL/HsdY7Cmr0sdSEnDHPW2VOgj2gYpojtGTAKaa1DePiqHDdx38lUxfg+Sv1O5mRNU//ksf/Nruv0q1O3CyAVADdicrFLTSMdIJ1aNFtHoUjXnmSQ8Vdbm3s9QnBNTbMtU3jUokhnXEWIRjqQuLCAyEMYRyfk8Bo+NG8WwkADARsZEoaH2lbnRYdWplZqhLvmTfcIEv1VpJNhZKk2nXkw06p
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(356005)(82310400004)(186003)(8676002)(47076005)(2906002)(6666004)(26005)(1076003)(316002)(7696005)(44832011)(426003)(86362001)(4326008)(70206006)(508600001)(2616005)(81166007)(83380400001)(8936002)(36860700001)(54906003)(36756003)(40460700003)(6916009)(336012)(966005)(16526019)(5660300002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:34.5959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd5d02-1723-4404-9f00-08d9e1d5688a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define a stub to hold operations for different Data Fabric versions.
This will be filled in following patches.

Set the operations at init-time as appropriate for each model/family
group.

Also, start a glossary of acronyms used in the translation code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-6-yazen.ghannam@amd.com

v3->v4:
* Started glossary.
* Included pr_debug() for failing case.

v2->v3:
* Was patch 6 in v2.
* "df_ops" is set at init time.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..639dfbea3348 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -988,6 +988,12 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/*
+ * Glossary of acronyms used in address translation for Zen-based systems
+ *
+ * DF          =       Data Fabric
+ */
+
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
@@ -1058,6 +1064,14 @@ struct addr_ctx {
 	u8 inst_id;
 };
 
+struct data_fabric_ops {
+};
+
+struct data_fabric_ops df2_ops = {
+};
+
+struct data_fabric_ops *df_ops;
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1072,6 +1086,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	struct addr_ctx ctx;
 
+	if (!df_ops) {
+		pr_debug("Data Fabric Operations not set");
+		return -EINVAL;
+	}
+
 	memset(&ctx, 0, sizeof(ctx));
 
 	/* Start from the normalized address */
@@ -3958,6 +3977,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
 			fam_type = &family_types[F17_M10H_CPUS];
 			pvt->ops = &family_types[F17_M10H_CPUS].ops;
+			df_ops	 = &df2_ops;
 			break;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
 			fam_type = &family_types[F17_M30H_CPUS];
@@ -3976,6 +3996,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 	case 0x18:
 		fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
+		df_ops		= &df2_ops;
 
 		if (pvt->fam == 0x18)
 			family_types[F17_CPUS].ctl_name = "F18h";
-- 
2.25.1

