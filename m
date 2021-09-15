Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EC40D02B
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhIOX3t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:49 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:60466
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233034AbhIOX3r (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMk/jzAvRF75qEIxzKFKZDL1mAarmGqQ4YbEtG2ypP6lPIdOihF9caKyjjWN6+u+WU7P8oJ0lZuSN2/ngrJc8Ctdzsu3AbkAtJXGwdFCC5YfGgf6Wzj98eAOUWVQb6L3vFBPmRD3BMcM7ElTOX9m75Ynu51GbsrQnhEHKTSLOyyccI2W5eDvkwSi56IM1C2i5VXkvbAhNPH1b92H4G8qCktnYiEXgK1O74Ek/Dn51lgMGBrJPISgxQm0Xqc5eQ6Q1Pm7jSxWyLzJBZHzU0ngJxlw2WSFtq3hRqe7Lmww6EZuJzyD9w3zUt52cvtxbndEBKDHxfmts4l2Lv0bHy2mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XmQHWHKq7INKWatnFo5aw2hxeXO7ZzfpLq+0CTgZH2E=;
 b=S6hTX+JPMj+6g3bgz6jtEftzlLQFCxzJngSX5XqwKUgJeFj3O//u2WSkQzhD5milZ9jPvHs+EKGTH8FQXhyvXNs+kcZN3/QS0R6GM7KvMit26LQZSMTh/XV4L8PlZdiXHldhd3ZtGz+lM+EU4drqXDuJWIV7WdwqGPJS1o0sYGDNyLQcMLyTOIvv2V9cmVK8m8s+exvmxchVyJYjj6aQDLNNGJlSVJdw8h2pPFffDyQ9amZ30yITiTccI3zpLfPOuVvPS84evEDlNji0bDOvoEnrsfF6zI7Gf+qv5VHd3S8Xx3Q28+ct7nfgKuOzZG+F86mLXFUj3AKnQjLRmaNpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmQHWHKq7INKWatnFo5aw2hxeXO7ZzfpLq+0CTgZH2E=;
 b=OskQj8YRTcuErB8SGux9M3rTOi28C0uhJvIKL7SWhBtZanEw99e3CP2ZHoXDycCuAqhXJwwlpE7OlTpSZb0YyRhviNMTFTHpsDgaBMJPlNLs1z6spDGbMN7HPeWrv8OPpdHTuvYnx9WXpMVB082m59QLmNG5XCzxbXo10tc2Pto=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:25 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:25 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 4/5] x86/mce/inject: Check for writes ignored in status registers
Date:   Wed, 15 Sep 2021 18:27:38 -0500
Message-Id: <20210915232739.6367-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6b7a18-bbfc-44da-444b-08d978a083d1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451205269D8886B942555A9090DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N21liSHUgKeP27DphQ1UbAVx0mw5H9SK5IY1rTOsOmmk6/LFogolFtyWxkyx/MSf6ePLMU3bKALCeiHmOv9DAj9W+yvyXRhokka4j38zo2PXNaCTOrtlc8QBa2mnwG1CMhKKQa4CrS5DBcohW2N+ACBIYGiTQhP7DVSF7bDNnlU7rLpv+ceI3IhRt+SBUAN/FixZPjMbMXIKbeRfXcNmOMtQE7iRbhOTG8TTNhwe1TquwAJC9MHDem2vyYNdJrkOzE1LphvmK6pZB9E/c+WAazWFF3SUzOYAQ/VE/qy1Q85En+OQG94yk3MxAYAGOu5z1AvN23qUvwlmlDa/CsOAirSbDku9dNJLBl7iLFlDykT57pTksdXF77tCkA3jA2LVYJZY6Mn4L+uhCPt1BATEVTVCEoMFP5KVQSo8c6EFc276NqsV5t0nMsPi4R2BdD2MJ9vmPGg3IlM19uhhFQgsDGE5sfDi9fod2ZQsVJuA/9+Ti54ZYLgmJlPqV9kYqJ65aXNJLc750wC+zICs1VU1l8tk4tvgF2PiJQ051hhVom7jjqSjntO/1J2OlcWGZ0uzPkc9dY2rfaZu0Zr5xPlRTBpFTZmdmZpnW+bwUx3/5QRzWXx4DpEAHUnuZ78j3NG9o571Cqe7dhDO77y19fIGCbM0gCrsJw/xh+o/xiXqwefKF5Pvjz6TkYzM4CZKSKKZil2/U4hkK8XSW2rC9ABK7j/sBLTITOlaovLDP4LXQFaehxqM5gPyXtCxvVtV0RjSQu6UGTgYfkl/NAmTjGpG5rl1DOFxNjWnzaWG6RVM0cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(966005)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(36756003)(5660300002)(54906003)(38100700002)(316002)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wOMJNyKqmLP5Mvq7R60RK+P3PpK7go/0ay5TI9XnAkTAgCjT9A4Fko/COb55?=
 =?us-ascii?Q?ka4Fa7Q55+QLiP7YejaE9tO4IlLDsrMzLgMDzhxdYZRQtUXO3yv0JrYRRjSS?=
 =?us-ascii?Q?UsMKTPIs845LLwTJAzNR0eLBK+GZvRaiOa7huuh6nfk7pprvrfYHGOV7CtVK?=
 =?us-ascii?Q?AjaGydYiVlfdQT6aloVIoe66R4omMAy2/fsDLDSFl8Anfypj9azqoqU03J6v?=
 =?us-ascii?Q?Sv8CtaXu3SmNlIzgswsfrTXxzDfD8GoxAwx4CEONKRp1YUSm6qGe5CcprEYA?=
 =?us-ascii?Q?yLzkbt3Fjep2d64W6jcFa/9DuBVAjTDO2YEOGOWrZeCyK1qy1Hx06mcQg3Ci?=
 =?us-ascii?Q?JGpRv4/8HtDq32a8LybTL2j/UUQGCmLMtTbEyJzzpm1ol4exxnWJHuWAQBJK?=
 =?us-ascii?Q?xkkXN0TOGzC2xkAqi2L0XPqm12lK/u9KIfsCc2jJybfcRS0leAPHEbb75wwx?=
 =?us-ascii?Q?sUcoZ9UPLnMQaT2UpH8hI3aulTHsqYk7nTdY5E8xVQ5Z0rif1YXqv79k+0mh?=
 =?us-ascii?Q?ywsGHOqHxssjClxRw8qTS1V4kaHKQBRSPE42viq8mBx2DUoBMO+ARcZwUesj?=
 =?us-ascii?Q?GOShcmNSNgd1qpokmf5FH65arECjMzHK187GtGEM9wEEqmRuKGDTrkxqH6pa?=
 =?us-ascii?Q?IkovgPuRzGPmY8pg4ZrLrMsorRtcY+XO0ujOX63ZhtXjJL2/qiZL42iKKUCP?=
 =?us-ascii?Q?UI3uVR56KGtjRqaytRgvL7pellFfte4SG8GkFgDR7XWZkXITWQbYgNimllLq?=
 =?us-ascii?Q?/M2Rv2n26t4Xe7+dqZfy2ONPCMEvd7Xg7zrV/tkoo8xDjD0+K6A/8hw9f0ek?=
 =?us-ascii?Q?thIJViX/I6AoY30BB5kRbG9DrDUDztQzY3bGj+bp40bqbppYg5d9UJ3fe6Kf?=
 =?us-ascii?Q?btKrjufy4YEgnWgcO6tLa9FLM/JfRVFmiDSTu1e/Ln1xRk98g+3qh7w0RiTJ?=
 =?us-ascii?Q?vHWyp2CIrZGCzqoU6CU9o4W8XUPROSH7/puoSeswA9QerBZQ8E4CDDx/3r9P?=
 =?us-ascii?Q?XwHvhYhcAHhXUJgdZnj0xis19R0LyL5wAJr6+EZPVUWH+HaRSzgJUXzZ47hO?=
 =?us-ascii?Q?gO7GNb784QT2mTH2UunSa6Bdqe0E4vCRL/EkHC44hX8JP0UPUj6EmR+OvZQR?=
 =?us-ascii?Q?fBRSYOoB8LW8ahk1l1cMZmomVxrslnSZfOM3vaja89lP4N9F7RcDUvMj78g6?=
 =?us-ascii?Q?gw3BTfC4FE8ZWjT5vj0ix80lU51mFlZL2Kd1EHaTLFvphwQuRjiREXrjnYHa?=
 =?us-ascii?Q?nyPZhf9msQOlzskE6dZEzh0mU1XGSmAfq0/rFBQ6Tu2k5gCL4IU3JcmlrKrf?=
 =?us-ascii?Q?nx94oWW3Esn4WcRvHNX+2kCe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6b7a18-bbfc-44da-444b-08d978a083d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:25.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE1LJqjXB1D32AfWXid7FxxP2i3ogxh3tZA0XRsDkvgGI6xT6yIFzDozJnu6UGK+HxN9U93bBS7IW5qo0z+H9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

According to Section 2.1.16.3 under HWCR[McStatusWrEn] in "PPR for AMD
Family 19h, Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5,
2021", the status register may sometimes enforce write ignored behavior
independent of the value of HWCR[McStatusWrEn] depending on the platform
settings.

Hence, evaluate for writes ignored for MCA_STATUS and MCA_DESTAT
separately, before doing error simulation. If true, return with an error
code.

Deferred errors on an SMCA platform use different MSR for MCA_DESTAT.
Hence, evaluate MCA_DESTAT instead of MCA_STATUS on deferred errors, and
do not modify the existing value in MCA_STATUS by writing and reading from
it.

Rearrange the calls and write to registers MCx_{ADDR, MISC, SYND} and
MCG_STATUS only if error simulation is available.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 39 ++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8af4c9845f96..c7d1564f244b 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -457,24 +457,39 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
+struct mce_err_handler {
+	struct mce *mce;
+	int err;
+};
+
+static struct mce_err_handler mce_err;
+
 static void prepare_msrs(void *info)
 {
-	struct mce m = *(struct mce *)info;
+	struct mce_err_handler *i_mce_err = ((struct mce_err_handler *)info);
+	struct mce m = *i_mce_err->mce;
 	u8 b = m.bank;
 
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	u32 status_reg = msr_ops.status(b);
+	u32 addr_reg = msr_ops.addr(b);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA) &&
 	    m.inject_flags == DFR_INT_INJ) {
-		wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-		wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
-		goto out;
+		status_reg = MSR_AMD64_SMCA_MCx_DESTAT(b);
+		addr_reg = MSR_AMD64_SMCA_MCx_DEADDR(b);
 	}
 
-	wrmsrl(msr_ops.status(b), m.status);
-	wrmsrl(msr_ops.addr(b), m.addr);
+	wrmsrl(status_reg, m.status);
+	rdmsrl(status_reg, m.status);
+
+	if (!m.status) {
+		pr_info("Error simulation is not available\n");
+		i_mce_err->err = -EINVAL;
+		return;
+	}
 
-out:
+	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrl(addr_reg, m.addr);
 	wrmsrl(msr_ops.misc(b), m.misc);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA))
@@ -487,6 +502,9 @@ static void do_inject(void)
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
+	mce_err.mce = &i_mce;
+	mce_err.err = 0;
+
 	i_mce.tsc = rdtsc_ordered();
 
 	i_mce.status |= MCI_STATUS_VAL;
@@ -538,10 +556,13 @@ static void do_inject(void)
 
 	i_mce.mcgstatus = mcg_status;
 	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &i_mce, 0);
+	smp_call_function_single(cpu, prepare_msrs, &mce_err, 0);
 
 	toggle_hw_mce_inject(cpu, false);
 
+	if (mce_err.err)
+		goto err;
+
 	switch (inj_type) {
 	case DFR_INT_INJ:
 		smp_call_function_single(cpu, trigger_dfr_int, NULL, 0);
-- 
2.17.1

