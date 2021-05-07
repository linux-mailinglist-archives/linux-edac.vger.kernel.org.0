Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05402376A41
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhEGTC5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:02:57 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhEGTC5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1L/ge3tiAZwG2hTIANBjR5cV2Be6J34o0Zu4JZJmS3K3cNnYcQWdiutHA13EDjVRpc0B4vW0ArJnR5MZO1qtK6LZ2XcRDQcG9vZ7J7jjD5qwUsz/Il620KKnhit2xen2JUj9iice6X42USpYJg9Q9+atuMWBziepmA2cBiwq2rll4DeP/KM5NRahamuqSuktc+FKue5ctgVdArc7/hZaMUVVZTtb7eMAhiy2c6jiSG/F73tqnwDEwzg0xs7jRhTDVW8rWSpezVHEiH5fK0FShP3MI12d9FTpt3XsmgXI2LGtZHIxCj6WE1PBh7/qECwuA70y76v8vQZIuatEID6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLG0OYzquNIBre8C+jfIP/xMfyxACL7XSpKs1t0oYPk=;
 b=ipUoyM+VXTilmxk5K9Z+ZTAxR9M2EeEPMS/Q4kEqPHSSiQFd9Nmj6Lp+tNzvXq0fTBhzpSVKQOxvPlk86lNw3SsbjG0YNTGY6W5nyiyRN1V+6NEqoPy/D7wBJ/WFeEd8yBv968NUy9lmXKlVGh3sDPYV9UePybBdbIKnQxi0kjDnQHbFDMMabvQvQ0yDj+8NW8JaLwWmkj897aLgqEM8AWncQJWF/A0rF8qeUgNl5ar5LUeHEIDDszgpWecAYYuAapSbkSqLjKsGqlcSGsbmr4+m/wH8tt4roHPSX7dbU1ub7664xH3MZ2F3bmt9HnrSBidb/7RhBso9fj/MruqbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLG0OYzquNIBre8C+jfIP/xMfyxACL7XSpKs1t0oYPk=;
 b=m0yURBQLcRNibPhB0ByAYsoOAjAYE+hvzXf1Mm+FjiawfbC3rdJC417I8YVOupcZQKT55prtcONSZd9XE+OX6qGhaHNAkQG5w4hZDPX9b1JScuCSgFO0RZZvgIiphu7vMibuVdHeJAXbuu4UYCan1f/Yk5qYCYZOl2/jh2Rb8/o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:54 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 02/25] x86/MCE/AMD: Add context struct
Date:   Fri,  7 May 2021 15:01:17 -0400
Message-Id: <20210507190140.18854-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 450bd8a9-05f6-4669-0f8e-08d9118a9481
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30738B774329EE142FF5FABBF8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wst62H6K31qg7vr78luDKj4SU7AIHYch4k6UNdCJhxilX3PG4/g/YWHPOMXFHs0mz3nBdrYQPW5TizKav2hpqqM6zqZtx2ibhBYc+RAkTOOqz8g1/ZKe+usn9pK8IDjuJrfbJFHRyShpeS9EU1L48WWmiUyjGqYdeZppdoQa0cPo3+k/rmT6V1gGRVhu61vlS8Z3DfNA31zqFagfC/lDDBGlIQhq/bQ78/rCekKKiqVZx3/ACcmOkPtsQVI7L5R9Pmm3Y2n3RhgwCAk8f77WEDIB2HkGc8fyBNZN8KjdTXbYL5yFBlYSZYf23nc5MbDcZMnssJ/7ZaESj2hV9MruLYa3/eo2qE1/Bfl0Xdq4aDieoO4GAnn9/2tAGY+frtG26Jr3voRgpnX7N09WwPxenp6h3/s/1qcFIwHewu6a+r3yQTu1gjzkIyBCxjYaQIzQ0zVIh7xpyT7JfWUTE5vRbBjQDRnjgTeQhLaM8z2fEhGSMUdtcVo1uuTaIJ5ON64H5A3zapTTt7NRQLqaeK4r7dgjc8Jy3uXfhJtLUvniV98ef9G0gScGV7IFguvMasihQ5l4FKfFsx1L1bzutTYdwp/mvG14jA++VJFOG+X0KhfUeSefbmqxL5Us6E6jzXMZNMiGgC0XJpBiGFTsu8Mq6wpxb2/PeY/67l4cyA8IU2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8sbFZtZMY3CyLJBakFBkGL55S24hcAVGOKRFXUBuGdqJK4rnKLgmV9Jpg8h6?=
 =?us-ascii?Q?rwniY41CNCOpAJ8Grd/LG3GAUPW8Iqh7E5HfCbeoznfVPaHN3ReCuadYvs/T?=
 =?us-ascii?Q?i8BYXJp0SXdK2poOElZtHP92Qgz4vvQLR3eDOJCqSmNvt/8r3Io/O7CgR1fy?=
 =?us-ascii?Q?W5nQJpWRmYHpi5xFwXwwKot6QbuTKucvdjd4M9pHXATesOWGTB8abykoq22e?=
 =?us-ascii?Q?GNQdtL5jAruQxXFLp+hzO3S8SZPgj8BoEkEz7gGj06Lq87kURTIOzQLJiHHv?=
 =?us-ascii?Q?wsPpHJS4tj1KnAeErJ7sORxjDBH6Sj8MD7apmCu2zOFN7bhDaDzCuvtII0Kk?=
 =?us-ascii?Q?/1gSpdmHsuLGwBBkBAESZwo1WyXoO8BLrd1ciDqG0r5mnuTmk1hkgK7razvN?=
 =?us-ascii?Q?+vi8AmQHCLMaTQn8OVQnBPiIV4Llm/AOnfPB7Tt47F3VH6LQT5/B+DIu+uE3?=
 =?us-ascii?Q?IwV81wtArXFruXk679TS2w/5nUf+T244jisRgpBEceV6W+0xC86/QCTCMFjb?=
 =?us-ascii?Q?ypY0lR0d+hPwjWmQZCSQUxtStr4wMlqi38vBlXCk/BA82SgfsRunDcU6lxLA?=
 =?us-ascii?Q?syflGuX5gNDYM8zUtHddI43YV6rN9kSywnb27POJadQOmM8dYOeFlbRlCp9m?=
 =?us-ascii?Q?CncDJJtRytLJ67D17801vYMNMysyrawlXTLFz94LnHuqVk6TSXytsHGo33aw?=
 =?us-ascii?Q?kuQ0Ps31wczbw+NVhw6l1/UVJRYtainH3RbCsqwAghSKIxVWk/QPty4tIgOR?=
 =?us-ascii?Q?q3g1zBChDaoFPmDtYPTP+WrJt20Q2V+3kIVVnswppdVcCOqOX8Y5ZL6So8+1?=
 =?us-ascii?Q?4Qhv1eT4nojqxWh2g0Wz+SQ/Jcn0z8DOqahL/K9PGtg3Y5lmwXCFKp8Z8eWN?=
 =?us-ascii?Q?fJ/VyWYzOrdgmBeRNrfrUeQpvfUoQFT4qpdOvLz/PHGWwurvfAQrTslzHptA?=
 =?us-ascii?Q?DVwk5ZzaprBYN61QwU8Z6P+PXBmvCBpy+Kl62WLF1xukQR8OYqAxdP4HN1r/?=
 =?us-ascii?Q?GFl8ADOuJZVdAjCJO4bZk5HC4KG50rO+UemN8DHF8CTrqm3ko86kNolCLHiy?=
 =?us-ascii?Q?X4wAh+X2NjKJZzJQ4GodhOs2sYEn7J7l+muCiuNMlyX8kjuybb8DrL6BoXSp?=
 =?us-ascii?Q?2Ut2ryqODj0qbvTxERIG+Ofu4h0OM8HNg/UIHvCeeJFUpZ0gq4826kurcUDx?=
 =?us-ascii?Q?WzkrsZHFnwUjg3qU0EeuCS65iTmwVW6RErBDFQAkdyNtLglYj91vrrIdMsti?=
 =?us-ascii?Q?INaz3C7hAvhE5VGhiLj7nN6Qkh+tFfbThLGlsa7eZxPd7Y9d593TpHR211Me?=
 =?us-ascii?Q?6bi3/nK+gWsaDI448tAAXNck?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450bd8a9-05f6-4669-0f8e-08d9118a9481
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:54.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9749cUE+xcfPRe7fwh6l5xU85WMHQPiXCk44bzQZDruQkheqJy+RI7kB3Q5Ng1jg2mfSpNdNWO0d8iL4oItiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Define an address translation context struct. This will hold values that
will be passed between multiple functions.

Save DF type, return address, Node ID, and UMC number to start.

Add stub function to get DF type. Return DF2 type for now. This will be
updated with new DF types.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 61 ++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1b459c143886..86df58b1051a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -706,12 +706,25 @@ static struct df_reg df_regs[] = {
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
 };
 
+enum df_types {
+	DF2,
+};
+
+struct addr_ctx {
+	enum df_types df_type;
+	u64 ret_addr;
+	u16 nid;
+	u8 umc;
+};
+
+static enum df_types get_df_type(struct addr_ctx *ctx)
+{
+	return DF2;
+}
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
@@ -724,6 +737,18 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	struct df_reg reg;
 
+	struct addr_ctx ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.umc = umc;
+
+	ctx.df_type = get_df_type(&ctx);
+
 	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
 		goto out_err;
 
@@ -732,7 +757,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
 
 		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
+			ctx.ret_addr -= hi_addr_offset;
 			base = 1;
 		}
 	}
@@ -861,14 +886,14 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
 		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
 	/* Add dram base address */
-	ret_addr += dram_base_addr;
+	ctx.ret_addr += dram_base_addr;
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
@@ -876,29 +901,29 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
+		if (ctx.ret_addr >= dram_hole_base)
+			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
 	if (hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
+		hashed_bit =	(ctx.ret_addr >> 12) ^
+				(ctx.ret_addr >> 18) ^
+				(ctx.ret_addr >> 21) ^
+				(ctx.ret_addr >> 30) ^
 				cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
+	if (ctx.ret_addr > dram_limit_addr)
 		goto out_err;
 
-	*sys_addr = ret_addr;
+	*sys_addr = ctx.ret_addr;
 	return 0;
 
 out_err:
-- 
2.25.1

