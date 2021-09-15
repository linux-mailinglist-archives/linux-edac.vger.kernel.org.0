Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449F840D029
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhIOX3q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:46 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:60466
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232910AbhIOX3p (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAroH0ReaTH+uUMb05q62b6Ez3L2ZXzIZR4vTWNDvr7RNmoOxUC4Ox5dLTwoPDyEVRdIIRZvmIaRrhgTJNokfJz5BDp1ihrTdFw6UAuP7TyofIBdmO/itlV+eJJfTmFWKaMaIZYlTwGZMmPZK834NzK4iXj9+DRzQ+bNBXtNrFW317IiSFaZiLbHfbOqtVeYfJDIzPy2sWqmlMjgd2TelNJSzxHi7dWcaT6AaroqZtHDSGi+X2O752Ge7k+PLAg7xH5yE2z3/cKhNRwe9oDf/1kpNKgnbLM0CREaaWkvi5HD7sijd7SQvW1OooP9VP51jBFRIg+c2Q2D5mE7cHgS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7/pidV71yr/nXhcHwctfP4pNH/VvlsDf+YCfkJUVzX0=;
 b=KubdaDIf7SV4KqCKhyL1Skb0wRgW5/fWoQK6TeiV91b8fomAiFaz7vLXAxzQBqECwQ2xhUOfK3g3d/J6k+4R4M2zUFIPgxpNZZAKtP+hUJko7MMMQTtlF3IT4qHR4IUwczQa97L9JTUVY9TtoB2KgJOKTFuhCtLBttBvlyhxBj+1sqdiXQ8T04jmiTYlYO6P+6liqRsDMuKuKtRLz1Q3L68jT54DSAZWFS3bN/B1zDJC5CDlngOTEdbFCG+48q6l/dBCNZhw9EfA5oMRUGjrmOB/74zZU9dUIoeTqMCe6gV9isOLR+Vzg2tosEb6xOEf8Laj4d//ZCu1D0U2j6Kknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/pidV71yr/nXhcHwctfP4pNH/VvlsDf+YCfkJUVzX0=;
 b=F+TzJ4RZnJD+KnnayQ8SRLLQqobGiq5GiIleyc6Ez6R1dmafoB2oAv48cy5bx3dcT1GwWoeIoSlPlTz9u+dOgXqWF7Q65xAEuuspkhEJTdmsCIFTJCYIrcqet+VCMe8L363OXm5kz+99ivtzw6l55y1M8cgw/xh4e0eTBXpFncs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:22 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:22 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 3/5] x86/mce: Use msr_ops in prepare_msrs()
Date:   Wed, 15 Sep 2021 18:27:37 -0500
Message-Id: <20210915232739.6367-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6dce37-26c7-4b0c-b78a-08d978a08241
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512C34A93D27C2C20BED82B90DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYp/atfsfOqfb3NvKUNvcFs33jc6Vor938LmXCy4wCGA0cTixBs6bFRFDmJf6MZbYZ0hHzud8kq4yhgS6b/sR8UCSB5EaoAMuAfJTfQEmE9p5TuBNDyTu7SgJhyF+aVJ1ODCePLLnVXXDase8kNmIwolr6rBsjf/8rNvSucunaAWSg4Y+/X2PdvulqWHT/UWMl4UEHjNsm2dbE+7sohOoJ2mbct1c06CX4ZfFYK1nJ8nwawheAsHd8wclkN3u+/lpwyQkPtWJAqkPPTAbMcYNT/ICibMjH6gXSf+iG6GJjpqrXw+k0C88acWfnBaGpunRtyhOW6NqjWVR/lwm7gF7sTiek5gR1ZyrAkQlCD/3zCi40n7KIOKSFww8A94Uv49EkMnukbJUN8O9CRHFF9cw3+mpkgI2JW8zxP8yvNfgLdENvVFaiaOzaVQe97RgCn4IHWV4ZQfcdHXqyMwYxYqvMIGGE1QX5UC0WF/eFt6440veOW/HclSdYSVbjLY59/VcuL12gXUbtyBgxWuzOl6ip4RA4M/rnKu72y15iNTDfsPE90KFPR+SvD6YAs5UOaijHXKFVZpbMH3deS1mKOnfqeL6n+uWZDWcMlgeF4H2di+/cI9ck5KEziKS9aURIA/p4pmywTwsSz7CFn8d0XU5pnIkZsqAEPn7jirMMoYCJNVaapFiPLVuVV4apaC/zmOpOgJvvjDGaKWqOEUHm2KNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(36756003)(5660300002)(54906003)(38100700002)(316002)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxCnPdDMwZICjHGUBcrVMxLYHztvAAVgpql0j6RZj0fTjTC6WrrspV9mYcRB?=
 =?us-ascii?Q?wRQdiwAAklE23BE/jWOS37oPN7RCJqzwfdzfg/v3VGE207mxqtz5j32N8HYE?=
 =?us-ascii?Q?/6MxuR7I7g78DKAAuxIuPgW3e68misvze7Zt+CMEPp/D/8kKuBfExwgp+aZ/?=
 =?us-ascii?Q?f5yyXe1Scd1DKTs9VJ6BSq0ipoww0Cx7datjunvALM7Q3zASBjRXmM2+WTQw?=
 =?us-ascii?Q?xf75Z3/tQyRKCh6odFn6n+DZjksP5ZdfujoI1W89/CY7cyZMpUuFBvWpbQmh?=
 =?us-ascii?Q?X40Rr/7PsIRC+zPYvLeghphSrVqZw0g4hafXtSAQXJnP7rOcuxCowFb6Hpi7?=
 =?us-ascii?Q?0xtfawA0dwoqUWYonk2OrRwXi8AgvkQlgwhb0VvufaTMxYAzsljKlftWUgl2?=
 =?us-ascii?Q?KJVHU24j+bFaLZnka68En8XYZ3erf4cZChiVEV5Ohq/MuDbaUefWzXaYZvBN?=
 =?us-ascii?Q?UzU/skD1XX7cyaBSMdCNYKhAv2qkC92UJl0yy5fgJlDZeUB2oT++Zi6aP/z3?=
 =?us-ascii?Q?ku8tPwWy/2diBvYS4gLWDbLekR4+gh0wkkTxWWN0/2vJp+zXT3D7bj3gX87I?=
 =?us-ascii?Q?afhb3Qp798vBRWMIYDp+0qd2j7JlVS7FqabzS4ONdAiTKklhHLcn8szj17w4?=
 =?us-ascii?Q?ROaFDqkhonS8H9G37iWNoqjpKkSQR1eK+RV5pDs3A2/V6Lw48W8eXTimdMpt?=
 =?us-ascii?Q?JWiYKOlPaiyHIAA0upiFsEgOlQpQJZpsFqtdFzKD5xosi95DqInavoU9TQsm?=
 =?us-ascii?Q?827GdUUoy1Fy7q4LqVVHqYLaY+DjQtugJIeHpkhxSxnsS1IFdq3FXY1tU/OR?=
 =?us-ascii?Q?OOrmdBm8G7EVMgcqt+QoWgh+oJOhhfx4F0fjkQQ+jCjWItibO6rEjmlCXvVO?=
 =?us-ascii?Q?kpFqjEaZJz9rzhNZs88tGz2dr1H0+61PMwLgjX/GIX0Ipfr08MBWp1r/wurw?=
 =?us-ascii?Q?70UQwgFzGmLXyzO/qv8fbKxb1w2l4opAedBHUEQ8lzg0qJHgTHF1VOPeJcdf?=
 =?us-ascii?Q?BZZy2pqNEueWfwAqsFlAN1H8ZqKooIJrilGDG4Fv6nEJZaoJnW8z7/183aZh?=
 =?us-ascii?Q?HSwm9R63viASOH4zV46nckg9c3J55OrgzWQynqij3SivyqPmc26sy6zJTY13?=
 =?us-ascii?Q?MoBbZ4SGtTXgyCedZv8iFdWJF30m19WJDs9w94xIgUqxaPTdLPxtE/PpdqMv?=
 =?us-ascii?Q?vJP/ecZ9TVKtLZqs7iI8CD7PgrDhSl82CKBFOeYoKnatvFxjODFOrGN9eMRO?=
 =?us-ascii?Q?kAFoJrvwbpPIsmt2T92u+FGSnCyfLUbVePBlUseeWGkOk2NZDVMb++ppSB6s?=
 =?us-ascii?Q?fqi5JnZeC2v+UgqGSulEPIhw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6dce37-26c7-4b0c-b78a-08d978a08241
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:22.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhMFDKTvo1Plpp7msYzYysIJvJW4/JrPZ1x/D+vYcyocqQjO0edZxraN0xXBHwVZZBW7Jm9C8K1ERzOZzwFdJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace MCx_{STATUS, ADDR, MISC} macros with msr_ops.

Also, restructure the code to avoid multiple initializations for MCA
registers. SMCA machines define a different set of MSRs for MCA registers
and msr_ops initializes appropriate MSRs for SMCA and legacy processors.

Initialize MCA_MISC and MCA_SYND registers at the end after initializing
MCx_{STATUS, DESTAT} which is further explained in the next patch.

Make msr_ops exportable in order to be accessible from mce-inject module.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c   |  1 +
 arch/x86/kernel/cpu/mce/inject.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 193204aee880..9af910acb930 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -222,6 +222,7 @@ struct mca_msr_regs msr_ops = {
 	.addr	= addr_reg,
 	.misc	= misc_reg
 };
+EXPORT_SYMBOL_GPL(msr_ops);
 
 static void __print_mce(struct mce *m)
 {
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 8de709b049fc..8af4c9845f96 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -464,22 +464,21 @@ static void prepare_msrs(void *info)
 
 	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
 
-	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
-		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
-		}
+	if (boot_cpu_has(X86_FEATURE_SMCA) &&
+	    m.inject_flags == DFR_INT_INJ) {
+		wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
+		wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+		goto out;
+	}
+
+	wrmsrl(msr_ops.status(b), m.status);
+	wrmsrl(msr_ops.addr(b), m.addr);
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
+out:
+	wrmsrl(msr_ops.misc(b), m.misc);
+
+	if (boot_cpu_has(X86_FEATURE_SMCA))
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
-	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
-	}
 }
 
 static void do_inject(void)
-- 
2.17.1

