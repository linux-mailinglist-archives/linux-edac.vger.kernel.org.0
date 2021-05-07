Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB0376A4F
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhEGTDL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:11 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:34138
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229791AbhEGTDG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxbslUB9KclIyTTPcBF2n5Oh3ceiSp9cRCuihAHs25oUTw8+uxrS7k5mdbXEbPTi6gBiDp/08eR48VwfjtlS/2wn6Oa6K1GlHWRDE5p1rzeO971gfOvBd4eN8Wrgq1Ef1kOigAPbckA+L8sYdk2HMsAVNLM7qF/WAcK0/U640fQ+p1kmRIDqmgOryLRmOj45rN+3JVS0wu5UoLnKb3ruwQTqKDmusac/NmMQx1PK5RJ2Cky9VArthFbjm17M0lhd9Yc+WdBrz4aK+q8LudMmNl50Wg5Z5c3673AKVp09AHRvqQ0IGCrq+z2c7N6HdLOhfR9o53zVvjx0AFYmKZ1KiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrGj2YD4nr3KhfLaUoK7DhhOD8puGiPmXxMIfH3BKMM=;
 b=SxV0zz1skVTH7VeMU25cjVP+NbvnRqabBL4QFqE6McdJ2Xwc/lG60+gzqt4MeUrFENrb05NjvgMKZ8Qs4dWLbWgcRfgrUAcQCTDpkiImQh5THNAF+tB8QYkE0FuRoefxcOrJbLmnxS9HSJxX4DcSa64SN8OvkBkCQDh/r/ilBof1WiuupWhlm/uu77c1U3ZVoNZKkSI66vohIdQf5XPsjGpCoT49rp6DATYV+dqtPwkgz0vU1L++oBnp7BgS7aXTLkRQdz3mkKRcuVU6LpOo+J3cOoMrrNOzUOM1TrK0WDDvzq5PNHhYkn4vZNUr+pYqQafX1TYRqFD7H5tXTCYSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrGj2YD4nr3KhfLaUoK7DhhOD8puGiPmXxMIfH3BKMM=;
 b=qQMLJAUoFmpWhYSiMLyKnfSNxVg9G0AGJ0rvI7uS4c0wniFSDCRnoWjYH8eqSc84bsyeJotAEoHH7L+nfB4VdzkLpbdylx3v2dpWogbtulEy4B7IZ/35sAHxKW41pIs6ZsGj+J9uh9sGf9El2bl5RHsfYqiNcZX7trsAwJHEnrw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:02:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:02 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 09/25] x86/MCE/AMD: Define function to check DRAM limit address
Date:   Fri,  7 May 2021 15:01:24 -0400
Message-Id: <20210507190140.18854-10-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc47f9a9-43d2-4b9e-0f4d-08d9118a98cb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30731957025602E5709FE71AF8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pslJWjdsD2Pfr4TKPdp2KaJ9TabVW8ma1/xmPj4h2UnAnhkDdT2J/r/ciFq+sMLUEx+EmH+WkGJnXBilStRyan7MdEZcBrZiBbHl4ZIELeVSFwpvQvdPJIcfXfRwKJhyrn5NlyI+CMzEt6CddTyPeCTuTMz4Mb1rqgq1cSh0LErEEk/97pft8frAp0tFGFiyl7vP3jfFCN9NGwqb6hmPe11yDqjIB400pd0ClD9JLSoPDsTQrEOTfmq1yDGPpOhz8hgHV16AzPozumQvik1Ax8p4bnJwV74oKQWPDYXjjgPOxt2JFM8JiHKB5irc/ZaNCJtrNfTnOBNRh6M2aIeRH6Z7od6la2Chi2Rt7dToudsRMxQB0MoeJ7GNWxDjrGirkTNf0hqDJsg166gvHOIY6jom6y3LKH6n29y7GSN5RgnHEFhlnlfjFlwvL4ZfScrzgokqL6Co3512sTbtpDj0RLA3u+DT4efui0Q6bfoKZD49Ge+7gVag+RcIQFVE+WzYsuD209LLO1Nue6N3FzR5rdeGKC2YLgxe45G/iv3qFYTHtQTnWIkPrqoA71jvT2J1CDxaimGaL87Mh0i5fpBxQb//iiDy6d1S6ql2qsLfYEBW8vuKG6JGAc4OUMawWw3N1jzMaZk/5qWMsxPfwPoiN4mXC+fT7qFPkP8ECYnYHs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J0cUcVa2rvcf5lFa/tNtcWgDZ+BhoDmSiDU7K4YDlSJNDaJfSwv2rpmsDKCD?=
 =?us-ascii?Q?KVJLuxMSGrSe2rjqeZAlHDlTwRj2K7N/S1fClldMVcbh2SaVNWc7KNGCqMu0?=
 =?us-ascii?Q?GseChoWPAv5qlxqnJdGNntzLTQG1eP0qVXhYG1uov6nGh4WGQnwYD0fephRr?=
 =?us-ascii?Q?1yGAdVtiEGlpgFc7yD/MzIUmqI6lbHkWdNcPyKMuzLPi5xS+E5JYHfFQVl0u?=
 =?us-ascii?Q?rcLR1L6LNarIaic0CrIqGpQoyFx8HoVZJi77sgaw3jjGeSZfu8cPqNN9u5dc?=
 =?us-ascii?Q?JwdavofTS7bsemc5B7HyQ9VCr0eeGXPYJYvQP4nS6qNueevS99ddI5yXUXa3?=
 =?us-ascii?Q?1XavzMxogF1prSV9hVoSac/zrKgNyx/mQPuQffS5AXSTZzkem/UVWs5A1BN6?=
 =?us-ascii?Q?mDLluhyWihV56LYUq3Aoq9BwEHqb+Ir8XqN+jV1qgn3B1YhvBCKh/dtTRxkk?=
 =?us-ascii?Q?DoxGo2aq8MsciecmCLg8Duq6nH/DFJ1JsNi3w79IAgy4Vqm2SfAzbpw8i5Xr?=
 =?us-ascii?Q?9+pBR8jBOkqwISxmNPvcdnAHZ2OHz/97yC5dsAYfJrZxW/fGEwqn0z/YQFT6?=
 =?us-ascii?Q?TmgRsgE7IWpm5eQmRwRkXM2cM5p+v8cKuJPg+tmGy9T6oA1doBcTDtgTIg1c?=
 =?us-ascii?Q?PYjLdTXQ4sSCprc4Y+D737Li8ts5E2/UdEjeYSTLaF9huQ+1Vmo34n4nOKum?=
 =?us-ascii?Q?jIAe4bjEfVGv9DocrjFa3ThzyixIJaYXhTTPaHVQpazlM2PcJd4LVcnZcaaO?=
 =?us-ascii?Q?5ZliQdZ664eEfZ1emS1NYjY7htryTpuBnN0xnxo1gpaX+yGdM6qcshm9Vcp4?=
 =?us-ascii?Q?IrPMMzG43AUc+k/tYqNn2M6EA+PJcv5vB6+ufYxkooAwLw5Ev/cD8JAjYCYs?=
 =?us-ascii?Q?U1EI22kUBcqvsUG7iuXa2DMHdX5TdZAthd+20FTdm1NArMDTDHILma2bDHF/?=
 =?us-ascii?Q?CII3wwVaQnnUluJKsQuFHlIy5jT/83E1ATOxhug854JG0yivVr+LEFIbKgbu?=
 =?us-ascii?Q?P7cfBF/Ov20Yga5Nso2xbYq3CAH/ie3uEz5SHIZL7ebE8gmlMtaedW/0meqr?=
 =?us-ascii?Q?8HN2mSzq5KuXIS9KAFsid10+bZHUsfM7oAeaLCmRNczlUpSxbLkLmsBBv4Od?=
 =?us-ascii?Q?zEphA2LttL/jv4RuwkXbKQjq6RUEG1jZPb6uea9xH6T90pQjX4RNEuGOajHu?=
 =?us-ascii?Q?vBZgntYpUxPN3TTI7LWqxsIK26flEmfJgXaylUxERiMMMWT/H+eTtcu0NgqX?=
 =?us-ascii?Q?eyf0o+CPTCtwLD+WC5uMZUw+bdD79kuAT6G9IXCzbmMGE4wfKgndXAeauhy7?=
 =?us-ascii?Q?rF+7rGsje7evu0HZqbpNt/Pr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc47f9a9-43d2-4b9e-0f4d-08d9118a98cb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:01.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVq+1n2YbeoOqR1u6zdsFBEYSk1lxZ/9l819J1hDjvE7c9DK/1M/9Gm417AKrMUt9IwgQp/OqUDKGBxRdKG9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move the DRAM limit check into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e341737e03d4..7aaf8a1dce2b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -985,10 +985,20 @@ static int dehash_addr(struct addr_ctx *ctx)
 	return dehash_addr_df2(ctx);
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int addr_over_limit(struct addr_ctx *ctx)
 {
-	u64 dram_limit_addr;
+	u64 dram_limit_addr  = ((ctx->reg_limit_addr & GENMASK_ULL(31, 12)) << 16)
+					| GENMASK_ULL(27, 0);
+
+	/* Is calculated system address above DRAM limit address? */
+	if (ctx->ret_addr > dram_limit_addr)
+		return -EINVAL;
 
+	return 0;
+}
+
+int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -1013,16 +1023,13 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (denormalize_addr(&ctx))
 		goto out_err;
 
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
 	if (dehash_addr(&ctx))
 		goto out_err;
 
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
+	if (addr_over_limit(&ctx))
 		goto out_err;
 
 	*sys_addr = ctx.ret_addr;
-- 
2.25.1

