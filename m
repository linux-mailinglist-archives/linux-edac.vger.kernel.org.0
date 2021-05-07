Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16B376A4C
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhEGTDI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:08 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:18843
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhEGTDC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbd5yYS6KRnV1MLwT6YQtICij0mo1v5fdWC03RZnOJrb2tclOilOfrBdKs/74zrQzAyjh8igX5GoVJRKxhvYqa2E8TfOuPlR7kYPTRkmhEh5VX1fStZXV4uriARRewTRVeTUlbyuPcFO+DvAuPE8Ln41qEcSYLQM3Rs28/DgDGdmkpeYSf8GXZi7ga1oWqFkbblbxgBF0CGE9A8GyuM45gCNYsVKduak+LHU6sDcD7phi4wtyN6dyUaklfRJL75GbQNYAuLaQ4Ah5RJXj+tT5c/VVWUcf8vTUUSr9UFQzACK03aJkPRXyIIaDD+LR05zRHzTPgk2niVTc0+YfSoecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf61jbWmeTQVqQwAWSIJdaXrcZFgsbuuo5AQXXcrVUo=;
 b=nNzuDqi/OoCzpYYWh9EJbD3E8TtryB9LDzmpXsJfnSbseMgtidWU3gjlOSVA989qwhA6inmZAYsrfM665epn6wiq+TXgyphWQMOPXOlu/bWt72yTAIcRwAzjKEhPHq0KA5a3jkyx9WMC0adjl3IB2j9419odb4cGqP/wsjhEab/Pnz82qfHxueufeZH4snQThp9A2Ddpk3xmKbpNFgxZp8cZ+CImUDdEd+DhYFdZghhfpMTfiT6H3e2EN5G9VYckbViZkc8UoFMyiPE3lgCwRMtgrRXPF7l9ZQJb33OjxJc4lJWxkYRvzQRpcca79HHtF0wuXB1iPoE7ZiwRvJaG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf61jbWmeTQVqQwAWSIJdaXrcZFgsbuuo5AQXXcrVUo=;
 b=l6n5mNbVAxmpsbiQdgkg+Kpp/b76ZMOQCsfu+O/IFo+sws7+NOuD/CNmsG/TWbLq/DEqDIEbbAPcSiPvILPzhOyMAp2dNe2WZCiQF7GtrIo62BxiMQJdiGApG+gfhnkOkHpd8XGW8v8lxfKllRpucfJeXugTQ/+HDcHeYem1b98=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 19:02:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:00 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 08/25] x86/MCE/AMD: Define function to dehash address
Date:   Fri,  7 May 2021 15:01:23 -0400
Message-Id: <20210507190140.18854-9-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18d3a2b-7ff4-49f1-c3d1-08d9118a982c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17483C6762E5679C1D289DD7F8579@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZOp80gNslJmIDAnKNdVfxTyUujW+aoEBE6GrfgbrGK/g5sQqw0A5g1iMNASt1bPbq/hRTgpjTlrS5FoUa4KhXc/EY/QEj+dBQeMZmkX/GmKu8pWaPw8s4yDcedKFH+bPNrFVMy8Lscveq2hozGgasF8RfuL0I+ev1t0OUbv7V9k73bxfQlKk8fTacU1zUW4u5Cqh2S+MAgX8rUZu6MZS2jLbGWELGNwiPj8BqQG0oEde4GrN9Dchkudf9wXJxNOF4PvZm660M5RN5ZTNj/sjVjUjw+kaN3iS1S901ozUrUM7vL+Gr063NU3NSWNoiGm60sFrooeezpMD+TQa/0K/jX87YV1djm4l0PDsvrZzy+zCadz832gu1Id0sp7OKJo3c6Kqdfju3+5IgBqGfLrspqE/0ffgivCGKRHsVDtVHnAvwiwxR3CVWjwstZHn7Ec0iaXvhj9J3eAf3iSh0m9OdJY8VRmkZLrYA1SSpnvICeZQHaVmiV51/lM6CskmLWuQOBIQ92i5WFyxDASdWyv/sO+w6x6wkF9Cbw5GmPrcvpie7PN2BYBhlso68Lg/tlActQixxkfAvF/7iA9ldfRs6nY9h7rpaMDuOSwXc7Hz9eA2hUGkrFzALwWSrpuN/bO707cpN+1S7wq/bU135lvzsg7egRiBDKatSmaJZD/utQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(1076003)(6486002)(186003)(38350700002)(38100700002)(2616005)(86362001)(36756003)(956004)(66476007)(66946007)(66556008)(8676002)(16526019)(8936002)(6916009)(83380400001)(26005)(4326008)(5660300002)(7696005)(6666004)(52116002)(478600001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UBQYXQPhDTuf5+m09pgujdFnYmUZb6w54Lqdy2lIwLnRXzK4xm3zG326+hNC?=
 =?us-ascii?Q?OzCEhvmIJhDwZNhrtKBnBlQxAs/Ww+954TRPcovTa+PUImOEMhRKMAAan2O6?=
 =?us-ascii?Q?SGHl9iMQ/Et4YR9l7jgfJE8FvUMWhMdNwyGOIhClGWonnpt61+57ESVngcw2?=
 =?us-ascii?Q?gk4//0QPMRFQi0kVuy44S2mgUVY/NWez/vtbmkHWP7SKfVAnPnmiPgI3gHeB?=
 =?us-ascii?Q?gByaGe0seMbNovxCxU3pbZx9/WlTyjHZdycTqfxP4fAZcRuWN7LBhvI3p+PY?=
 =?us-ascii?Q?sapX89eUIApZMLuEGluYROIw/QT6vgds05Tr9SZWjCfUcWf6AY7UN3wlhhUO?=
 =?us-ascii?Q?qoLMZ1FG+ZPGruVGLMGN16cPyJ8SsJqPpQVesT1G6yYjnVXdgiJGs5cwVh4f?=
 =?us-ascii?Q?KAQ6mBOWR3mnLEsJ/haPETyR3bNiZ/hrK4yf1ZT3IZboLVACbU9SoM2SiAfA?=
 =?us-ascii?Q?UDBIstlomL97TN3CbceK32a3RXLWtSuC57kKej2BV9VTUfIpmrltC1y+zLaO?=
 =?us-ascii?Q?gjRO2Jb6saVFFyJKkeSu5CHroFvMQfYEqzHPgUIgte3FgnO8TE+x6seRIwJS?=
 =?us-ascii?Q?nFm3bZ2psAgzFwVeXr7DrjirXeNA7610oFVuft6Wr1dSFaVN61iADH/cdKat?=
 =?us-ascii?Q?TssZF4g9msOFwyaBAxfoWMM/hiHk6dxOkCaoVOYSjO9hEiNlf94a8ZERqvzN?=
 =?us-ascii?Q?NQmF4Pb/Cm0HS7btuqnDcYRHHFh/ObWgp+8cHMa5OXIyokTriqpv+i54uMyT?=
 =?us-ascii?Q?Sv0/2Z6vwL5WHnOplwz1cllRZEsvHrDELydN1V3A/iZfHTwXtll2HiKm2rO+?=
 =?us-ascii?Q?ox6w95b27691KC/SsfBr7N9rX7BdAtG5qy0rQu1DuJrHgx08AvbAFR/Rp8TG?=
 =?us-ascii?Q?EYsrccQce695GghRJLslV3dkIhYa/2mSpY1R/mZqZHG6mzf/vCtn4YISJitI?=
 =?us-ascii?Q?iHsabxAcuv+Ce8UznyLIjqSYDR9Vcjn8tlYaJAlxgvKvHbgMmL6An2zVsLwM?=
 =?us-ascii?Q?774G3L1TkXE3V3do/vidDw3D3UFBj5ocaoCBrndytW72ydq8elwTauy4d8TY?=
 =?us-ascii?Q?5DywskZefFhl92h0GcxLMCDxeorXZAGzC5DuqSu6zdk5I9KHbscdd/BGQqKW?=
 =?us-ascii?Q?l/cOW+Bpokk+VYygIIS9EbXpThM+qzOKyRblEoMC8DR6dSAMIDbvKUHuBEGk?=
 =?us-ascii?Q?xsUrznY6Dz5R/WJ4S0hT40eQPNH3EMdEbTRPp2ThW4I1TJ5OQedtoJmgzoPD?=
 =?us-ascii?Q?tXmKgN02dWv8eU/IjloeF32LiqlqYmcUorOeENZkq4d+FC5zaisyYY7HKo5Y?=
 =?us-ascii?Q?Vb4KzVCCwlfGY/gkkoBC3qhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d3a2b-7ff4-49f1-c3d1-08d9118a982c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:00.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J88ZFG4YO9/aK71r6CWQ0CZGsThIt7q58I2aZQXUga6r5WZX14uBqmUSDe2QkMAsGXl6HP2d6kz7KWjsZZtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move the dehashing code into a separate helper function. Define a
DF2-specific function for the current code. Specific helper functions
will be added for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d1a6405bb990..e341737e03d4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -961,12 +961,34 @@ static int add_base_and_hole(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int dehash_addr_df2(struct addr_ctx *ctx)
+{
+	u8 hashed_bit =	(ctx->ret_addr >> 12) ^
+			(ctx->ret_addr >> 18) ^
+			(ctx->ret_addr >> 21) ^
+			(ctx->ret_addr >> 30) ^
+			ctx->cs_id;
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> ctx->intlv_addr_bit) & BIT(0)))
+		ctx->ret_addr ^= BIT(ctx->intlv_addr_bit);
+
+	return 0;
+}
+
+static int dehash_addr(struct addr_ctx *ctx)
+{
+	if (!ctx->hash_enabled)
+		return 0;
+
+	return dehash_addr_df2(ctx);
+}
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_limit_addr;
 
-	u8 hashed_bit;
-
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -996,19 +1018,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
-	if (ctx.hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				ctx.cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
-	}
+	if (dehash_addr(&ctx))
+		goto out_err;
 
 	/* Is calculated system address is above DRAM limit address? */
 	if (ctx.ret_addr > dram_limit_addr)
-- 
2.25.1

