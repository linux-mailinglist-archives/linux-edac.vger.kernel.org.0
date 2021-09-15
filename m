Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04940D025
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 01:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhIOX3m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 19:29:42 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:25184
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232910AbhIOX3l (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 19:29:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeRinztX+iD/Gj9bGgEpasfaJkOVCiai0PkMF3QtjiXfy2CYOA9sA8MUVFrmXdk/zokFDfqLALfYvA8Pf0R2ZfS/njdHFlSr9hxkbi2I51RH22cRMeqEogvoPBndAXQuQqNnodzlVpNeE7Ty/N/criFPoq3F+G1tnCNyW0MhKnZUQubd8PQrQcV3K28UvoeZMJGQGCHTMCgxJRRWyE1LGEiiD3dnI8gCdLe0SUBfmBNebdERetQ5ZniO21DhK+rl9hmQ09QzUMbMQPT1r9eEP2+Rn2p1LKK1KpUcTtcMTccZaU/FHyLLHUnk1nE8HtDrp3EiADyfzMK3pSP+j4NX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kQ3W9/z+MRGSJTP+GR3VjXdHkZH+E5wIDnUaIslCNqI=;
 b=l0dhKTDBO6s5INLNw5O0W3VoGkg2QCg3qQTLQYH3luyjU8amfyQdTCdxW8FJ88K9AFPiHFE5vuLOf84UxcRElpwxAGeJt/IK8n6GfN0iIYRkiLdPvk4b2NgM2uc1/Y4I3jF7VULAmzrhWEoxDxbAQjVuYW7ln3YJZ8S0rlaLRtN7nxB16llawoQHotXIIPgF+1blJITPOnniXE3P90s0GTtI46+BH7yBus6QF9cPrX9fv7E4sfPE7UmzjzEbWm4kRYx7KC+8nV9ry+MEqO/BX645WsnCmnHLvkxI1wh4wcj16DdPVoNYgSEKmTQiuFrIinxJ4vjSzGY+bVz1gCCdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ3W9/z+MRGSJTP+GR3VjXdHkZH+E5wIDnUaIslCNqI=;
 b=vfhfdtcdyBqGsjB83JZi+hDlYzuYfOMrxWpEwuJjo87eKw5L9E+ssC8sZkGCeszNfEvrRZJI3SOHznkFlasHYtTvhMFEyFr9SwKA+mIlgRcQkQZUyCBIPybBsxevEzsXJMpOQma+IfEXAe8HV6eJjPrQ/HSxnX6CiyS9kBf777Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 23:28:20 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::4913:ca1c:92c3:64c%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 23:28:20 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 2/5] x86/mce/inject: Set the valid bit in MCA_STATUS before error injection
Date:   Wed, 15 Sep 2021 18:27:36 -0500
Message-Id: <20210915232739.6367-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
Received: from ethanolx50f7host.amd.com (165.204.184.1) by BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:28:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc128f2-ad97-4c63-9ea0-08d978a080c4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45120F41A36F532CC937236690DB9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTBXOiXOLLyAra8D0X9wwjXE89ryvLFkh8eYg8mm4VxYcznhFseVRhp9ymsWEmseQ16vjfe7gPbjs5bw0dQ06fhWVCKIiVGxdr5phnmiLLUj6cdwlwSvrwJRaO0Gkp4Y2QtPdesFLspYKhPl6j/ZeWjoqzzK0UFYSBYvUjy+YEXb6abX5akBo42r9OMLyboe+42J9ytSbpK/DAK1u4iFvUbx0+hpR4VqqXRQL7cNnxuuVbXI9C0BR8iF3qXjxrci+0r806W4T1qnnaA9pEEdMh+FL71YnfNKI5ZGbhWcoG8xlgpMPKz78McUDwrWZlUc2yWMqUj3L26tPVQyvaAAPb4YYdvIyuyqvvFlHr6K2EmKnTi8c/035n8wB2cC67YFij5o7W5yMsUYBJcRWT+26fANqv/ysbGKZysBuSeqBaRie9yNyiTTtctb1ClBXB+bj5hrBQzBXkslJsjbRZbCPucQCEjsGd/cgaiIW4Y475tExhcEEMijjpC9F+FO52niJbxI8n/XGUKau0R3CoeL2i+r0oAxRoBXfziTUC/90ty2YdP70h2eKWvYGSjKiZku/8kYa7eH8RszKHNyzH84B5uFksUHx/myy+L14p+8G9d4tbnGlLx9+yPdfyaldpOWf1wCR41IXEc9U1LOtsnvoK1O2w7m4rhd7Juy6kxLnwYSemL5YpRtdoEr5h8LGAlMt3ezqr+je5QxQAd7XZ7iYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(956004)(2616005)(66946007)(4326008)(66476007)(83380400001)(26005)(478600001)(8676002)(2906002)(186003)(1076003)(7696005)(52116002)(4744005)(36756003)(5660300002)(54906003)(38100700002)(316002)(8936002)(38350700002)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3F5FJZmur6uKf0nsfRyHf6Xnrqmzr6YLKZuN2MO4s5lRjfygordMon7X8CU0?=
 =?us-ascii?Q?vEyBxgUU6+HohLOpxCh89CntG+5iuf6ppJsRRa+xWhuaJbBw9teVT2h2NZvz?=
 =?us-ascii?Q?1Tcx2PM04sDWFIR/7PllE8c6Vpl2Jvz1dpCJ3dGACoir3J7zESIp+YLWCuk7?=
 =?us-ascii?Q?3nZNV9rqNyYPUUXnxCTArstOIwL/V352nIRFEx/+u25Ny7V+tWbvILoWMYh8?=
 =?us-ascii?Q?DHqwONhPkCTOz5WL00H/9VWzmJphk3kW4syptbgsro18EcRkqjnHAIv1L1xz?=
 =?us-ascii?Q?blFmIH+lKhRBEPrWp6h58bmYpk73QY6N8AFke+gU42Qsyb5L8ff1O9qH+7x+?=
 =?us-ascii?Q?aw67ABitTW27TdRgcWh58R0pjtivGnQeGMfm1v/GW+gyLrLL57/pPIJvx++Z?=
 =?us-ascii?Q?LP6Dqc0i0ktHgN4Oe2hAO7xAs/rPIK/yNvhwIWl1WnGM4lnFBo6vo/98hma8?=
 =?us-ascii?Q?mfsTofLGbDt9o/+9jhGnphqdVT9I58fs72N7RO3Qk5P8YiYwL4J3BLTuZ5M2?=
 =?us-ascii?Q?fWv96F+H8R4eRfSqo2vkJrNuhDRjBEEBxYmPtnKQvPnWipJrN1J5zObtsNxE?=
 =?us-ascii?Q?z+ZHzjJBvkA+qEm58Lt7530y9c95CvQ5bKe4SBvzcm+I38vcHdL8EM+M0n1n?=
 =?us-ascii?Q?RRdR/GcrmOiHxpcpkRddys3h69lpgguXyYgoBVohgDPM5qIdvjvGPXN5Iu55?=
 =?us-ascii?Q?8VLhJ8Iq1Ho0Vk6916d3eg168xm6gSrRUZ9gyw+H1l0+5BDeyNXo7BStSKdW?=
 =?us-ascii?Q?Gpv+Ltu439u/Ub8ix9v+raNUVrjUf2h9U3N+lRS9it6XbplDNuNq5gtbI6Al?=
 =?us-ascii?Q?DAxRubxjQy3JlnbalUkhPxC0K5J4x3nUQhqjf0d8XvUk33ppXgJ/mNpRhJb6?=
 =?us-ascii?Q?m4YjkxeIS9/4bnsCS2TnL/YvJ7jQqBgu+ZIZBzrT5nwDfYqo+8JJNdhptsOw?=
 =?us-ascii?Q?IuiI8BS2LlcvhDSYMlmWBVSUmCZpWg8EU2o+oOZ+1WdKUSH8ZMH8oRe7xoR1?=
 =?us-ascii?Q?5pM9E3tfqPqBqJK14+0mf+loYAhkib8JdR+yuB9Lq+YDOLSfcDPGynnElpRK?=
 =?us-ascii?Q?MAsN684NuI8Ez5lGcQ1RoVj+duCSn5Zw0pQRP+n3c/MmN4E+pCFUXpR1CLia?=
 =?us-ascii?Q?gcztWlaRcIWh/LtBWSVnf8JumqgixwdSA003sXJIi3Ki1CQGAoNPUofT7Jtm?=
 =?us-ascii?Q?pZwcs0NPggtTkTK0dmi3v/AAgM1XVs1c4T0bosonPIG3xpQogqjaCWitdJpM?=
 =?us-ascii?Q?+IMz7NgutlP6fX2Xa6H1r1SxxSpCJXLHupD5gojPaON95S4F4Vx/RGjzcCTr?=
 =?us-ascii?Q?wkmHBlgwAlAR7uJCVWJL1tG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc128f2-ad97-4c63-9ea0-08d978a080c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:28:20.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kTlXQSxW/XjqA/szkbw0PsVmF6Y0BJv+JickdNe71sHnpFcoB+m1VMFc4XzBqS1TxGLEAfHksuitWrl/w5NPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
and examine the remainder of the status register only if the valid bit is
set.

Set the valid bit in the corresponding MCA_STATUS register if the user
forgets to set it while doing error simulation.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 51ac575c4605..8de709b049fc 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -490,6 +490,8 @@ static void do_inject(void)
 
 	i_mce.tsc = rdtsc_ordered();
 
+	i_mce.status |= MCI_STATUS_VAL;
+
 	if (i_mce.misc)
 		i_mce.status |= MCI_STATUS_MISCV;
 
-- 
2.17.1

