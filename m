Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27DB376A53
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhEGTDS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:18 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:18843
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229779AbhEGTDJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+x8wI5hOz5qJU8Z2wPdham0kkO4tBDYQit4trZoFPXj9pzFqIlYO3UgwbGwreDJpZwLgpMDqJLOCwxna5SvGi+F1ilk+LmTpsw/7mR6jj9oUBKVAFT+yZ6UWLfhj/c6OO2VbldBfVkZUfNAWh1rxm65mdFEiACleC08M5vdoOT7Q+jz+zDwIEwCzqcYCUFw1Jb3je0fg2LAlxG+AJYX5xU2fDuvBUjOLC6PJWFToQ1kgKcKo50rr5pB37Scm8A+IkeCVyrpc6uYhzvO/5yhZSXRwBP7oFjJwgiEtUtk29icPw+BewpkVsM3Hsj9WOn+/xesYeXTMHCw8S6pwtHAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMIEb9P33Qa98oHboZBN6EHjicb+oPhLb24xX6gKxNU=;
 b=Tx7WWJzyCNbjfZIFtPgitH3+SZZv1F9qLN50nykhV6bB8RNziL8LlTqlRPEdOR0tgTo0WZOSmBc5wvPJmsXEdnG/Q7j0kgeEj1ZqtdVI0VG9mlO5oiH/qhDh7ip6J7R4wRl6yzl4To2R+kMxX8MZ594jygNyueNE/3a6q9cJGSV2Syp681kAMZ2w0NaofPOifFnra8cA47C1hHY4ia1W/yK2LmAUDiATYEHrW8G4hVCczAKbfa/WOSRIygRnHbUpGDoDp7sfrwFhN07HENGxjw9bmGwXUUs8BlB9Tn+xL4IdK9dels7K5JHpIwWoItzabb8zZd1jOMWxhNgR0khlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMIEb9P33Qa98oHboZBN6EHjicb+oPhLb24xX6gKxNU=;
 b=ZcaP0Otnmb7bmHrlZ1Fm/F9MipFXQgIUIwBKqog92GaRtyprZtDhb3hUi5kbKD4lpP0TGOcXtS4vnUuxuR72aq3cRRbPSlMlNhdg9/YVG87n61d8rW7YtFFfuL3w3pbCBVFhn7roPCQxt/vKpwdk0YlI9HJ0+i3DFxHEQ6aPFj4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 19:02:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:04 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 11/25] x86/MCE/AMD: Simplify function parameters
Date:   Fri,  7 May 2021 15:01:26 -0400
Message-Id: <20210507190140.18854-12-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d98231-4d69-44b9-1cab-08d9118a9a33
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17480F021C3E9ECD17DA4061F8579@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPENQoOmcm8yGEAjscnWKk5a1xfEYGUwOyTwvvNtcJxZ6wKw37woBNun6sMelqqQj5JakOOE5sNWoolgU7/pl35kmDhqVzrCvkONn7XVLkOWmP9EW11fIakC+sLDwucZQ5JrVDupAsHw8sMSktAS60XnjWSp/nEs+RTkPKzzhpwBY/qn4eL/xepBhVP2YdjleLKci1g5MKk0lVKszyAu8IELIpfp8MyCtuTNJVX4jsc7321xmLdn2iOUwhwNs4st6Nz9OBbQ+9rRXTY4BEskTCW+8GijqG8g4wZd+Sap381LtMVB8+Ix5fQiPdlO5zZj5O0YqZUa3CuH5e9+b5zk9Q5RlJJT/lZ3VI61gTGDDey30VYiGSD78py3yhl4UXXHJnUgSmPMP8a3qdkWXH6Ww5NaDcdjhtBWjMNcgXnvHE2yP/TNHdRNGDLmH1i1UBV/Zb9JWtJ3hZjSXgj8lnnHGFN6mPplHcA3CjLgy3SlMxo94wBmPjFRMjK910WZoX97g7kiYeHp5HNLmxqucrL/pEnf38MVE6buapHLL0DCbgWuYQs8MnK0JQm6Bbii3wzYn/7AQWiZrPX12AvlAoWT431W5xqhXg72v/hrE0Bs+o+I2GX7a9J42+x7YWILbP325IdKXDRgxP1NnH0e2yVtl1g0EhirQMyCjOpEK2N0jUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(1076003)(6486002)(186003)(38350700002)(38100700002)(2616005)(86362001)(36756003)(956004)(66476007)(66946007)(66556008)(8676002)(16526019)(8936002)(6916009)(83380400001)(26005)(4326008)(5660300002)(7696005)(6666004)(52116002)(478600001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cNSFHDuruGGtNWMv0vy6kjoMDhFYozbeA2d7ziYiDnAKxSPlqYO2cuTcLvGK?=
 =?us-ascii?Q?KmNAkHB9m09krWy5iNDlns/PEUTqpWUGJREaq5B4FJN/SCkPL2Mnan1KXBbl?=
 =?us-ascii?Q?5vEUKi7UfnBNfIb7ir5XevkLl1NxWyCEYy7gSLBgU0JlFxUTYxsuwC/atzu2?=
 =?us-ascii?Q?kwPK/5VjOSpVfEYF7yQtDLp2kXGU1x5HmGFYOHDtCesdysYdUvtPlw814Cbq?=
 =?us-ascii?Q?OPO6SBhAvpgzDQ6jwSfMpAmd0PrurishTdmU78+1yLGhkcZsrklvZs6ZDJSo?=
 =?us-ascii?Q?XdywprfVDAuSGg8gjKBNGlXBMqqfyqbSWzqlQrc+/8hFf/PmLwGLaVNxtiMt?=
 =?us-ascii?Q?dfaHTtGZcazhma3zp+0Or4eQpJwBXspRjH+nafEtYyE0gz8Lj0aXnpHWQJYZ?=
 =?us-ascii?Q?ii3+qsUNqWxQbimOVdBJ0nkTc2HDhciFH5JyARrWqSFvwtJfQ5Sh5UT6NHNJ?=
 =?us-ascii?Q?Z11hYSreHeqDdSH/K5QsjtNpe5JjImtmcvacwLkkQqzSNZtuSj3uo6Mc++Xl?=
 =?us-ascii?Q?99/HjpWfyFYEsKC8GlBzzBDh+tjG0iqwcz5kKzSefRzi+XrtrFmKUEi0RqWU?=
 =?us-ascii?Q?rZ0sSQDOLFMuFjuy81HMVtsQXey7lNhpulYDdACmVM3QVA8TRCc0o4mCE8vZ?=
 =?us-ascii?Q?/VR96HVtQZ3n757n8iJMTbOfTf0aK2iiqWomsjvZVYRfTsk+J1Dw9VyU78sZ?=
 =?us-ascii?Q?DBBpv8oCzcXeO/UpcV+Xi6fpNv75qvtmZCk7/8GQdWW7q2L/fi18hQ1nuWdu?=
 =?us-ascii?Q?KrN+JxDAD3fpmHm/O+fUqwmiFHDQQ0ZXYm/BEANEjjK+GeCZb2L5fjn+LSr1?=
 =?us-ascii?Q?eOoovwI4P52+GIfRIZF7NFgwKX1EP42PDaLDL5CtYF0kwYS4F0gnb9cHk0XN?=
 =?us-ascii?Q?mGU4zHab/sXTpebUDV/UWM5woTWEsft/gfXxlK6AGEATG2VUaDTwMN6c+ZsT?=
 =?us-ascii?Q?ZfxVlAUZxE7R4YSBBFlcu3Nq1TiEsN1STb2ZLqjk++2SgQMYhxeWiUEEGM3V?=
 =?us-ascii?Q?pwsNq/LbeRcibi1K+EYOrdfc1RkSmQ1Eb0d37CrnF9xBMSAyJOy9TMda7tni?=
 =?us-ascii?Q?HBiqNweRmhsCmdKjJiZRbyb8kJvCqSG4FBhvLTM54vBdqEKLDthOl4H66w2N?=
 =?us-ascii?Q?OxJoKRwTo7TSXzd1kFEpH8SRYN8R/41gTDC/zRmOewF4bGDDRGazLaDHfDaR?=
 =?us-ascii?Q?BqIkXQkyB12G0/v+QCCNj5yJyE+XUHTgyfnGawQfkT2gUCtLi4McIzl/P5Pr?=
 =?us-ascii?Q?Fa0O2ZCVhv/kLe8F21aae3iSQhLdgtuNNbxDw+XcfCEvNtrEbiXtZUoJxo0C?=
 =?us-ascii?Q?LbfEx0FWSQWkrkqxZYm9qd+l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d98231-4d69-44b9-1cab-08d9118a9a33
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:04.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G69b19HwoSIZPxKSSnNfxYP6AHsX2nE4YhNM2QplipDZAoT9I6UzsLY2qeeQtxWssbwMucTYhUjwmCni/j0zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Use a single address parameter for input and result to reduce the number
of parameters.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 5 ++---
 arch/x86/kernel/cpu/mce/amd.c | 6 +++---
 drivers/edac/amd64_edac.c     | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ddfb3cad8dff..991ba48a4c0c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -351,7 +351,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
+int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc);
 
 #else
 
@@ -359,8 +359,7 @@ static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
-static inline int
-umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
+static inline int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)	{ return -EINVAL; };
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d51ec5c2f319..58899c57eb76 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -997,14 +997,14 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 {
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
 
 	/* We start from the normalized address */
-	ctx.ret_addr = norm_addr;
+	ctx.ret_addr = *addr;
 
 	ctx.nid = nid;
 	ctx.umc = umc;
@@ -1032,7 +1032,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
 
-	*sys_addr = ctx.ret_addr;
+	*addr = ctx.ret_addr;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(umc_normaddr_to_sysaddr);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9fa4dfc6ebee..dc4a642d5d7c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2896,7 +2896,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 	struct err_info err;
-	u64 sys_addr;
+	u64 sys_addr = m->addr;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -2927,7 +2927,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	err.csrow = m->synd & 0x7;
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.25.1

