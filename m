Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB45D25612B
	for <lists+linux-edac@lfdr.de>; Fri, 28 Aug 2020 21:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgH1TY3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Aug 2020 15:24:29 -0400
Received: from mail-eopbgr760087.outbound.protection.outlook.com ([40.107.76.87]:43375
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgH1TY1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Aug 2020 15:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laszgpBZC9veB8I9taR+pfhIX58IxxDW/RD0Ggh1puo67ZOm+MLi6nDOnG/TADqn/H5OFCP++7S5MEAmigiUbjeyDJBiIQL34shl5GUBSofsbFt6WUV7/xqa6salRl7/bBcx2x62VKaeC/WtDuoMSiRn3u9nbe1xxPuvOXjAkRXYaDld4vr4IuPLM25gz+yWJO3QgYW+hhxcZkK2SF5Tioq1q0wEqo5sounp/frMGnwEBrTNcGlNJKHTydjuECYLFZqIBRtcfeUdIdV6IULFb6XCt9dNC4QWOVsCh8126Lo8F3KXm4AwWFjHwFD1WQjBSrc2AUO+9e4IBLlsJTQmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpvNQ8OyiIgQSKv+VxgukPOQL4nb4VdiYCkLzXv2UMA=;
 b=mxpo2j84/RKgl+gQx3Kgl2Dk7QapWk9a/p4Z6mOomXltC0CRXfNPooExsPtTRsqtAXsJaCTEiYK1QTreJd1nt0w2E83g7WPF5fheVQwCBZ0zLRzuAR9rRltvDUwjTrVRgNLoioJi5KT2xIr24sQfuf3B3i1/s0aFIjYfP+uezJWnuXqGUNl4j0NzY4fy7gQHO5sjO/PlTzcs79jkba3MEDMCgm8bH9ty3vNLD2EO/4FmCPCsUhRCpsquZzHKqdcQlRVji6T6P099QA+N45X+8QPDh5pS04wdFq+DB59r71GnajX+GeDesrDzUgiN9m86pZKlMgSIZEaigxPo/hXUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpvNQ8OyiIgQSKv+VxgukPOQL4nb4VdiYCkLzXv2UMA=;
 b=qd1OH7YwYC94bo1dX3FGhPgsqjeLKI/XTwU0Be0FhjUKYL3eASNKdWyosXNRCU6kOGT+ambwanvg2tbZajnd57/vXQmRWMqKYGFxgmhZqvFX2NqhW7wM2z5/sIkbb6HiHmhhkPERkCaWr4qzE8upgtDKJqfvOUPgV5tCu85yqXM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 19:24:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 19:24:24 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2] x86/mce: Increase maximum number of banks to 64
Date:   Fri, 28 Aug 2020 19:24:12 +0000
Message-Id: <20200828192412.320052-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR14CA0143.namprd14.prod.outlook.com
 (2603:10b6:0:53::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM3PR14CA0143.namprd14.prod.outlook.com (2603:10b6:0:53::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 19:24:23 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54e70bed-03c6-40ca-8698-08d84b87f915
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0148B6E235D5A94CD6D080EAF8520@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y28+MM4f7uw55bhXgQwNVizCR8GvhEYtwpclWKcE+oaMfGZZGaUSIFmp9UfUK050ZJqhCMVV0+BODLPfgRPF+GfZKFxM08WKHJNUG5f2gcKgo6sA7OE3V+gZa/3noay4jHsp4k8IaA8K39IJF/LJMeQb/N6ZYK4N71PLCzFgoqYI/nQt7ncsDMCKepCx2xF0CM/keHxcdOte0Jd6S9nYPY2Vmft9AF8O8ud6u3bpEJmFprGSBkU7c7wf3rU4BqHSVjEJzqaPgLiCT9ui9+tzkl56PnUioPUhbKVMNvUYJIoE4nk2zbAlYLDOV0q7LLlWfM4BR0NcPg4NuifUCZGJqk/TYhPqmwmu7Y1uuGOAdyszrVho4qKMK0r2n9x1Gu4ZrCwxMvKjmAscNEqaQKOLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(5660300002)(1076003)(66946007)(16576012)(316002)(8676002)(8936002)(66556008)(15650500001)(52116002)(66476007)(6916009)(186003)(86362001)(36756003)(26005)(2616005)(966005)(4326008)(6486002)(2906002)(83380400001)(6666004)(478600001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: m4w4LcQaPKWwsIBj9DP8QWvKUypfRp0COiTkbEN82tvTixG8kNJXV5bm8Ido+Cb/QUBiOt+axGcvo17Eodri7mvJjetiL/2e1emj/nKrGBIHPEegO4onkpBs8AeMRjM/A/tzDKKGRL6sje3h19LjTLlxfc3LXIYcBFrcwxm10dFSYKAVgqirpahLAGB4SpZcjMEUMIx3+S0n/Z/Gr4DpqmMN+8blmyKg4GSrGNonpWjMJGlAYDVoVoTbWFFqgkZIQKDcHzY/9cZjK0khVVNx5kyIs1WoxAPGwXGcWyH3cJj3hfD2NLIKBJ819wthtgzpbciWC4GWsFMX0UhkXA455liAVYQA6NEISXMtK3HETq4iU3UOGyki9AbrmLvOcsXWM2gm6NdpF9YjxoICk1dUC1sqpjTxM6AhkJpYLGEBXUZ7ry+Mfkv/CmIg3anQRbMi3lNbQLkz9BvVQJ09sYVpd+xqytTVHFt1VUGc1UbAaM4NV8LN5Y86W5TRQN9LEUzm6YNkW+RJGsMIXaeHF3ABRWTWeAAUim7PcZ/K9+EfvBEY5jgY7uyk1ndMxRW2uxS1M/xuqlZLTiuSFMtKTjlmqjcLp3GEPCMALY23ifTfUm1ZBrQvdop0aVIbPI41PvQHK+1J2oZAlvyhJwZGfEUOoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e70bed-03c6-40ca-8698-08d84b87f915
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 19:24:24.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDTd7hPRniNO9JMfAQxxYKmej9GHLJYgWWRixTbHI6DXl/PM2ihXLcNEtq/mxQdWXkBgm5FUZN1+Ko+Mo3EpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Akshay Gupta <Akshay.Gupta@amd.com>

...because future AMD systems will support up to 64 MCA banks per CPU.

MAX_NR_BANKS is used to allocate a number of data structures, and it is
used as a ceiling for values read from MCG_CAP[Count]. Therefore, this
change will have no functional effect on existing systems with 32 or
fewer MCA banks per CPU.

However, this will increase the size of the following structures.

Global bitmaps:
- core.c / mce_banks_ce_disabled
- core.c / all_banks
- core.c / valid_banks
- core.c / toclear
- Total: 32 new bits * 4 bitmaps = 16 new bytes

Per-CPU bitmaps:
- core.c / mce_poll_banks
- intel.c / mce_banks_owned
- Total: 32 new bits * 2 bitmaps = 8 new bytes

The bitmaps are arrays of longs. So this change will only affect 32-bit
execution, since there will be one additional long used. There will be
no additional memory use on 64-bit execution, because the size of long
is 64 bits.

Global structs:
- amd.c / struct smca_bank smca_banks[]: 16 bytes per bank
- core.c / struct mce_bank_dev mce_bank_devs[]: 56 bytes per bank
- Total: 32 new banks * (16 + 56) bytes = 2304 new bytes

Per-CPU structs:
- core.c / struct mce_bank mce_banks_array[]: 16 bytes per bank
- Total: 32 new banks * 16 bytes = 512 new bytes

32-bit
Total global size increase: 2320 bytes
Total per-CPU size increase: 520 bytes

64-bit
Total global size increase: 2304 bytes
Total per-CPU size increase: 512 bytes

This additional memory should still fit within the existing .data
section of the kernel binary. However, in the case where it doesn't fit,
an additional page (4kB) of memory will be added to the binary to
accommodate the extra data.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
[ Adjust commit message and code comment. ]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200820170624.1855825-1-Yazen.Ghannam@amd.com

v1->v2:
* Update commit message with discussion details from review.

 arch/x86/include/asm/mce.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6adced6e7dd3..109af5c7f515 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -200,12 +200,8 @@ void mce_setup(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
-/*
- * Maximum banks number.
- * This is the limit of the current register layout on
- * Intel CPUs.
- */
-#define MAX_NR_BANKS 32
+/* Maximum number of MCA banks per CPU. */
+#define MAX_NR_BANKS 64
 
 #ifdef CONFIG_X86_MCE_INTEL
 void mce_intel_feature_init(struct cpuinfo_x86 *c);
-- 
2.25.1

