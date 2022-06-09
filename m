Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4D5454C0
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jun 2022 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiFITTn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jun 2022 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFITTn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Jun 2022 15:19:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614B2FA635;
        Thu,  9 Jun 2022 12:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZHm4VzQw3z/Ha5U7Lqmuk7CqyuGlQTW+bzM7gEvBxSu8p7gTQr4I4ERQhcRBKGz6R3SuqMSzb7rkF3AdufRFbvXgI0AOHMAGdqxkMsPFvjgGif3HRdZE15Apx1BwvMbL0hv61f1M8HXR3tIa+UymTMe6j5mHM9Ihfq1aOBe2Y91Zn9wK63L6nXve+ijBqsgOeznYlyaDK0kmbJezhLaEgJ5MFVfZw1FIEryxN1bNdGnlFKLY7dQBWln1Wc7tNkw5sBbckt5aYxRQVq1ucC4I2cCbkIPV7mG5PSwnKz74vqgogJ1iDxSIRR6lprBjwn9YBF8RlMoSSSMa/LoobFFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8qK72Ya1CUrBlljsT11CR13uJxA5bcK3iQ8lvqE1tM=;
 b=Nb1NPjvj5uo8q8oWHj9oHzBGe2LFGSnR6Pe/ofKvPYQS9K0B675Kpz9D3fN5l4fUTiKqpkZILQazTMiWtpm+SH5V/5utzwgIlj4kmbxxpZHwOpu9MpzorTZ2uQof2vTzcqkd1eBevXQeU363ydD5ny63Bkl7fD74RQw3D0XE0ED/viAJDOl5/XxnP4B1bKLN+RK0AfkPKcQs9mshWm6w8MM9bQD5RUVW9aEEAyudbpTr+YY9npRGhuM85AqWtuqmOlYs6cjD9by1+FrDkxx2dlAruwrf10bK57waHhMRcFT9re31F+oUX4o2bvA0pCA/kmvwzOm10Fjy/NT4JkTmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8qK72Ya1CUrBlljsT11CR13uJxA5bcK3iQ8lvqE1tM=;
 b=Xr+nZ20FQlAN1NpcbnPx+KixKYOYZSm9qRz8yXnokwE1PCYFRYE0iotSIsHKd5Etlxle9GxbIYjNLe+nmfj8FGvukw6d1jF6cUEDTRd01IoxLD2cBe6abNF2M9uZc/Vtvj89Atm6iOgCseCpeQvEphGI0osHm1jH3nT+hOWeZEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 19:19:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.014; Thu, 9 Jun 2022
 19:19:38 +0000
Date:   Thu, 9 Jun 2022 19:19:29 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     bp@alien8.de,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YqJHwXkg3Ny9fI3s@yaz-fattaah>
References: <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
 <YlmHtlKABn9W0pu5@yaz-ubuntu>
 <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9556644f-05c6-43a4-9a3b-08da4a4cfeff
X-MS-TrafficTypeDiagnostic: BL3PR12MB6476:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6476D07B9F3999997D413049F8A79@BL3PR12MB6476.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKQotBE7JD4IvpzeTX5KcdLuUW1O/yPmNGrMT6VMZeIt1Y0k2k2pgaObibYPr/SQxixzgWEd+zdw4/DQW0t4Ftqfx2adpfZIV+ykPlYYuAv5XGnqRBMX2CCizZYM5qLzHzzmOBICwIVoBW0TPDyF1y1WtRtxLjUlAVR4gts3bJhjSuyGD87w+gyDgQcIUabQSzOuSZtn7Q65ydT1LE8f5NiEMKQqbZF6Ht0h0S/jf6KEkbG9FAE7vz6i7oFOgo9NwsPkyUSHiEgrwTeHOUdHFRvV4k8TAFAJqEeodd9O5BHab1XaTvisYCbK/jvNMHyXk/CNXkogQ5ykIiQ/maiYwLaBC+SJGqI9yqqvvfG1JmfOjI/GEO7qS75qx5Mhg6YYWaJRw0aXtgEXwZYwARK/61P5XQAP6amZhG22gkGL0b0+OFl/uEDp343cVc5zFCY2cTieYcvtAKYIo3hPPEcvC3sK23hJKI24/YIqIskxQ6W5BpC82vUbxjUu6M0UEZcKuN8xcuAjf4mObHwgzSCyc8tNuSvMqqNBuiDvsmSvurWBjqB1MqWkLmgWKuOQ5LlJOc6fHAOF9XKLuUFPxESHhSnxXLiL49HmLc2a6eX2q6kxVnv9suyG/1LIBn8drurC9Yhdra9cbwRKGpb55AnfSVj8kVuglLmFWOmthOhdZ5spyKKre9PTd0X7ZNY2LtU4nFv6eYQXHCyQ5qEW4/5y+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(86362001)(38100700002)(8936002)(508600001)(5660300002)(6486002)(2906002)(44832011)(316002)(6916009)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(186003)(83380400001)(53546011)(6506007)(9686003)(6512007)(26005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ke3s7lJYDPJqsLmy+jTH8sbVigI1MdlJoykSoyQgDm/mwcQdoDU44SK+i1d?=
 =?us-ascii?Q?wkUVKZqbXwsPqM3adCCuPzE3hULfL7quqX8JC2geHH3QjZt5HxTj+uufgOAA?=
 =?us-ascii?Q?tozZa26Rk37V1ZdSmM0HopMkGvpBaZnyjg4NltkIBkBcUFRS39zVP2+IDOfF?=
 =?us-ascii?Q?9Zk2lhBqfKMaRjN/uL6HR5XaTl4pwS0FQNKSPrB/tPtY/VfwHm2j6EbqJNhr?=
 =?us-ascii?Q?nZA3VMtwwvySbj+0XgcgVXm9CTQKHyBBDcz+hwv4WrKWqD/83hQCrox3L9nf?=
 =?us-ascii?Q?2N+4aG1sfG6IliDyyFOWsI7rkUAmFuCvH8RE9rFSQfTPOFmuNR/57loLg+Jf?=
 =?us-ascii?Q?nafN3d5CYkT82xOVuvZ9Bxx6vrt7Jo6VAqnDfrJ67BOqIh1BsuKOQ4x6IoDy?=
 =?us-ascii?Q?J0KkqOshsPIbSvxUgs+jNSRAKQ216dymFpKiB+c7UtRdxBAkFAK7KwIa0Ycs?=
 =?us-ascii?Q?a1S1bYARqA5cfeMlhldbFn/1iwFoguo+1XL8bqLnvfpoS601wdu+3TleboYq?=
 =?us-ascii?Q?t3TcYvbzad+fTKPnD8cLQj3J/7c+I5Mg5GTdRpNJVeX/fOmin6242vO94fQ5?=
 =?us-ascii?Q?pb6iYuPidZxkQEh6/gOHQHjYN6fc2ACroY0KVblYDuvnh4kadLpYTEISRyTt?=
 =?us-ascii?Q?NriCx33rDuPJNIWWj+HdwmmHegszcZPIm30tOOmM3CCXLjzgn/tJjFAz7dil?=
 =?us-ascii?Q?7AVssXFXpASjvN/fEHYp5K4AyFYTIvg6tAfW5UeLWDW6YKSwU5VFAH4YsAWs?=
 =?us-ascii?Q?bK3Gj1Sigze0uvCUTsIesNO9Ho3PmPFpqaU0a8Jv1hjxu0rQ+gjZpjd3eUj+?=
 =?us-ascii?Q?bj1FecWpIgPE80J0IE2snNYBFu4HZn92lbUYqlbQpedymzSoluydTWZZ1QEk?=
 =?us-ascii?Q?vi+fjsPq8Mt2gZ4YXbj08C6BHyeHmOlgXTWlMStHtEHQMFpysXeuxbbxbJNP?=
 =?us-ascii?Q?T+Lh6ihyMt0gldfyA2zA/OqaoDdiap/iayW0qHp3wTBLVNuRdSL+U6N5MFN3?=
 =?us-ascii?Q?vclk4vEqXmqf1JE2dJRTL6aeiLAe0rJ4daJRdGidnzP27+JQGwrqT5ljeSbE?=
 =?us-ascii?Q?JqikCmtDFbmnblUv7mE/M6wtf9CU1BQ/GJTF/udo/zvnUKd5Q5EtZBItrTR+?=
 =?us-ascii?Q?PvDH/dVZF6SBIMgSFGr5VeSxetcSokqeR6aDcCrtE6/BDrOoDtQKkgeY7iwY?=
 =?us-ascii?Q?in0E44ZDjZV2E2tyCj0v/NagvQSqN+oXwupW1MKR6TQppkIE5ELNCJqPYa7E?=
 =?us-ascii?Q?tkSwlzY7TooRELZwlK769URkC5D2okheI0zUp/Rkxaj37mtoT/9DYejeRvMK?=
 =?us-ascii?Q?NcB8gbNzKFP5UGQ8NEr8Fm3a4+wjM3CrbN6hOaJHuDjcGOJjh55tGVDPAaXp?=
 =?us-ascii?Q?6+jCx2VTIyHQ6zdAVDcKom2TD+x2NOHwL7M9pHQAFj7NmHUjMpApdEEKlw8z?=
 =?us-ascii?Q?ecPpXvsk/sF4OjYs02M5n/KCI6SoTzqEPyTOhznPulxs0aSED9VVBeN9OViG?=
 =?us-ascii?Q?Y73npjUVlZmHIChHyc9zwd6o5aKbYMbRKsqC8lVDucdInMoy+zcP2qIoWtIj?=
 =?us-ascii?Q?988albXGG4OraEKMtSEdCpV8zMqUqS5wmwtscCLoDRYbbWFOjY+mHWNH1T/I?=
 =?us-ascii?Q?OrsGaAMzAgOHlSrW/bldfg38hDBsAsNd7lph2P0FO8tJvoDnItQ/zv5iZ72v?=
 =?us-ascii?Q?XWG3eezsjT2WfoeWPdkkCufABUd63zE8CpabY6oujsi0YHNEN2FjVd6dwdan?=
 =?us-ascii?Q?oAKISlX2Cw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9556644f-05c6-43a4-9a3b-08da4a4cfeff
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 19:19:38.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwHdDQkVc7Ribayzg5C0LPeluSa/NlWGZhaSRb2SWFQg1LjVXBdV0uV2GmkbPz9F/JVldSnBITFu7WF8tp+EFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 15, 2022 at 09:37:57AM -0700, Luck, Tony wrote:
> On Fri, Apr 15, 2022 at 02:56:54PM +0000, Yazen Ghannam wrote:
> > 3) OS, or optionally BIOS, polls MCA banks and logs any valid errors.
> >    a) Since MCi_CTL, etc. are cleared due to reset, any errors detected are
> >       from before the reset.
> 
> On Intel not quite any error. H/w can still log to a bank but MCi_STATUS.EN bit
> will be zero. We've also had some BIOS code that did things that logged errors
> and then left them for the OS to find during boot.
> 
> But this sequence does give more confidence that errors found in banks duing
> boot are "old".
> 
> > I agree. The Intel SDM and AMD APM have the following procedure, in summary.
> > 
> > 1) Set MCG_CTL
> > 2) Set MCi_CTL for all banks
> > 3) Read MCi_STATUS and log valid errors.
> > 4) Clear MCi_STATUS
> > 5) Set CR4.MCE
> 
> Yes. That's what the pseudo-code in Intel SDM Example 15-1 says :-(
> > 
> > I don't know of a reason why STATUS needs to be cleared after MCi_CTL is set.
> > The only thing I can think of is that enabling MCi_CTL may cause spurious info
> > logged in MCi_STATUS, and that needs to be cleared out. I'm asking AMD folks
> > about it.
> > 
> > Of course, this contradicts the flow I outlined above, and also the flow given
> > in the AMD Processor Programming Reference (PPR). I wonder if the
> > architectural documents have gotten stale compared to current guidelines. I'm
> > asking about this too.
> 
> I will ask architects about this sequence too.
>

Hi everyone,
It looks like the discrepancy between the Linux code and the x86 documents
isn't a major concern for AMD systems. However, it is highly recommended that
the banks are polled before enabling MCA to find any errors from before OS
boot. It is possible that BIOS may enable MCA before the OS on some systems,
but this isn't always the case.

Tony,
Did you get any feedback regarding the sequence above?

Also, please see the patch below which is based on Boris' patch from earlier
in this thread.

Thanks,
Yazen

-------

From dc4f5b862080daae1aae22f1ec460d9c4c8b6d20 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 19 May 2022 17:25:47 +0000
Subject: [PATCH] x86/mce: Remove __mcheck_cpu_init_early()

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event
done in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
Also, move __mcheck_cpu_init_generic() after
__mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
MCA polling event.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 20 +++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..f65224a2b02d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -681,6 +681,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5f406d135d32..9efd6d010e2d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1906,19 +1906,6 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return 0;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2139,10 +2126,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2308,9 +2294,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2327,8 +2313,8 @@ static void mce_cpu_restart(void *data)
 {
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_timer();
 }
 
-- 
2.25.1

