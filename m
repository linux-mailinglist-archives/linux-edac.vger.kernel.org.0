Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79438376A44
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhEGTC7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:02:59 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhEGTC6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsCo0/jiGnU2HPFyskrJHYcfP3HXkHCtaJnw9vKcEWScyWLC2mGmpvrXwf6HIcro/6DJ0t94DFX8hyxSJR4z7juWEIysOrBucizcWLSh7E42bPQv2xSbRQteIQXfHLrMEo5WKl/vbxAP2HwgoxaDzsCczLlrFzpFInn1kkMkWdAjf/BoeZyoMIBqxmUT1LExf+lLzrSDD40kIR4DxZPVeE5cjCsvBeQJWEVPOF+W2wCdcHXmC5YNb+oFaxGAVwzCWajIKrjege6W88q14TX6DXMq48Hh+FRG+Q3u+a0PFRTzv4Ywxti+8hgiiuZBJn0mFPYuEAT7m85hfrlxkmyimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLo7cqT4X01tMGPACbRkE0lmzckIglAEDeikafiQVn4=;
 b=PDssA1WfnHeZ9/cD8zhmpNAwUSM+TLFTORkCPesWMtlSQ8OoKrqcneoZ6l9T8CiolucEHzZQ3Q5NMqGb/g0MwQbSXBRqntZJp6h7LlO167Nh8I4YtY4kapUockHuD1BMueEkRLqvzhjOJD4VCyCUlKfF0HtPL9KFFgkko7UR3eIEFVUFOtTKhibZvUPuOCFtaJh6lz0dfDs+j9kFmOVejY97EicH445eUCiGcAyEcFW5aiM7lZKy9EiNZqPF7wzPOuWpaZYEiU6fLQ1TGj4ejpAu/qfKXT0qgvqV/Ym7bnMQnlsxztTjSPT6EKMrRsuP8CCfYDwoxIMmzX0hg7qfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLo7cqT4X01tMGPACbRkE0lmzckIglAEDeikafiQVn4=;
 b=23eGGPQxBrVmhM+vyXCHpTheVpN4/fpXa475qa/PeAjVTfb5YOj8cTFgIUomkvP2tBCQPefx4USI4Mtq3IoqXbJx5i23HO2wBW36Kurji3ftpGj0EMkBQC4wN2KgzcBPGZG0ZTG9lKp9Ij6f/A+HzCit4GcQ5xAEApSUOBO3vmc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:55 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 03/25] x86/MCE/AMD: Define functions for DramOffset
Date:   Fri,  7 May 2021 15:01:18 -0400
Message-Id: <20210507190140.18854-4-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c30a5a-7a25-4456-2733-08d9118a951c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB307303762D8ED1270F09FD0FF8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHzyuiTEVpKknE21jy8e45hXbdRVSuE1i0jC5JYHqpY1jlAqNG5KWXppjDMyWhoBaxcpPdUH50rOsqyZCzidMKgBqKv4BHrm5vsHI18/tC8q32TIhHNQJvcvqMxyWAajbl3fohl5q6NhGKY9j6JoSDkF5+xWXIhPcFruLEAvsgbHUjX0vROpsN0P5t4iqGUuQW7pPnkG+s9MDcBRNXaVG/m+byGQxXQJl5iVWMaldaUKQXpKckgW9vcQL9RHgPfJNYN32LNIbr3WsqDI+U9ImJWdrOXjM8vHV4GIL4rX2196yG32WiU1C+KabhmYMhPR5rE0Di/E3e1eiqvwK8lP8kKcexYZ9BXTG2lstw2+nzOKlbhox0+vZHqg2Ltvncmocx0F9U7mEg39NYQ16WjDmHmk0qSapOFH3sEZmvxBJevfJRLC7o92/vhyKE+UYtKoHkrq4ZO5j6ToDqQfoM0lE7CLa01S4yTCkmeR3iteoPeuMK0Uz1SQsTwWbwLxlA3wUI4qwrMZQTOnD4eyhwfivrr7HfQMAPNUECVWkt7uyDKysp+2So9aQl2bcy3J19yavJJJdaxJ3BcbR4TgLnpupSZYTrqmJ+mKZa+LAPcaDY50ZhIxIJRP0mgm4ASo5pw5NRX9Lrn0t+SdSX7xVaotwMLW2onqrF1Dfcdc6QXEigg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CT1yrd8EaaNELqoYEdZG/2eibcNS/GdeLSIDYqRpWY2bqYmvBOLWBCAGT/o0?=
 =?us-ascii?Q?llpPkYtsguyxmWy9hB7f5UxUlKMW/MpjWIJ/zeHnoHAx1alZhKWO55nfulug?=
 =?us-ascii?Q?OvrseOzRJZTMSE7kk2fvT1kCDd2pX+jrtR6Vhw8LV9jiBK+u32QvUx2KLWpa?=
 =?us-ascii?Q?9rxY971EdwYKFrToqUgKaVFGdPtQcWczhfHbfKUg7P/O/A8YH3xTLf2Vk9CC?=
 =?us-ascii?Q?n1RZM+qJY8WTJ/WzF5Sc+Jo/FAG/0fL6jn4DfMDsoCfsCalXhOK/MkMxgtiP?=
 =?us-ascii?Q?wO5B2UgTVxxF7qF6Sf5kP2MmVVxlAG+kg2tgUCSkyVHtFiSgiH/cCCfqH6Wk?=
 =?us-ascii?Q?qNc6UQhZm7e9tuHtbCByVzzs6x90BTV5LlBiUFRWh34P5HCAYxzAsC9CNR93?=
 =?us-ascii?Q?MWELsFqUVuG03rC9zhaE9DwnkuHMBC5GwdBDSEIpQ6vmTQYeFEp/HB0wuBRi?=
 =?us-ascii?Q?eFk9jqP2CXHArsZlOU4Dk0FihZEylAFdHyZjWeT/0wnEvv/PePudjigy5YrQ?=
 =?us-ascii?Q?UfpyM5P6SUa7MLkYewlDsGKemHb6Yrey9mSYXbj9Hc5ZNmJI5JMWPXC6Jkxg?=
 =?us-ascii?Q?M5UmQnVIsyzjmhwYWrtE0lC9dyVFZJ2M/suLdnkxsGiTf4YMU9iGJ5aYsPvo?=
 =?us-ascii?Q?a608hMsqJ4RJ5ibtj6shsh9E8Og7Y2PxQCJA0oM0tnV/HakB19ZQv52sTm9o?=
 =?us-ascii?Q?axKWch+Yz/K0HQ0qdUC6lM/gWpZZjCW2WbB5NSUaOB3FRxUpHFKJ3Qc7iC/j?=
 =?us-ascii?Q?NHcldR8dD5iOTRh/pXY64a9xpcujaLC8YqTqbUh4j5ZbAQuWKPvyiyK+Eg4Q?=
 =?us-ascii?Q?yh52OUbZpsvD/29sQQHrwX4BKlTcT4v45gfm4mC5jc++WFV4F+U71MJDT86M?=
 =?us-ascii?Q?AcCvfz60sjaBE7SdG8QhOIFCSo3qiPm6NANz+62lYxGQAQaKnlRC9KKjULd6?=
 =?us-ascii?Q?6Vl3moy0c74hBDIVrIBB+Asvt4DaJdRzK9ab9nN7mAvpsip0y0iFqjoCSj7Y?=
 =?us-ascii?Q?WM6+7nVkGoheI2dL4xCJGRdOfehWZmbMp4jK9exqZbGiAwhq0pesiiwOwzaj?=
 =?us-ascii?Q?lbZZD+iU3WdtAhsw62F5KMc9zfuyLfdxU1MKUBvy4NWRZqtoJ/zA81+kWqeX?=
 =?us-ascii?Q?1aH2H2SyMJoE3bPEngiJ+1GuV8qxAMuSAwIA1gWiRao+ApmhLpxOu3IgzAf9?=
 =?us-ascii?Q?qTseTEB75cdSTk7nvDrq0+/prba7pyMUB4OALCKntTu+JqS5XGUZtqHk+KO2?=
 =?us-ascii?Q?oTQvWotl3eNIRHWFhoE2Kti4stpB4eF48R3+QkqgSys0QfFwF7sOoacOjPmi?=
 =?us-ascii?Q?JF/9yCldnL+Ise9lCxYtSegq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c30a5a-7a25-4456-2733-08d9118a951c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:55.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS1qkzpgrRD91gWeMj1OoDjt/HD/76RoDrb+MlYfH5dF80tjgoAxGNbJd0wcGN58EQBZU3/XZ+TDip+Xun9LDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add helper functions to read the DramOffset register and to remove the
offset from the calculated address.

The helper functions will be expanded in future DF versions.

Rename the "base" variable to "map_num" to indicate that this is the
address map number. An address map is defined with a base and limit
value. The map_num variable is used to select the proper base and limit
registers to use for the address translation.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 54 ++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 86df58b1051a..20a6f34143f6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -710,11 +710,14 @@ enum df_types {
 	DF2,
 };
 
+/* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
 	enum df_types df_type;
 	u64 ret_addr;
+	u32 reg_dram_offset;
 	u16 nid;
 	u8 umc;
+	u8 map_num;
 };
 
 static enum df_types get_df_type(struct addr_ctx *ctx)
@@ -722,6 +725,39 @@ static enum df_types get_df_type(struct addr_ctx *ctx)
 	return DF2;
 }
 
+static int get_dram_offset_reg(struct addr_ctx *ctx)
+{
+	if (amd_df_indirect_read(ctx->nid, df_regs[DRAM_OFFSET], ctx->umc, &ctx->reg_dram_offset))
+		return -EINVAL;
+
+	return 0;
+}
+
+static u64 get_hi_addr_offset(struct addr_ctx *ctx)
+{
+	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
+}
+
+static int remove_dram_offset(struct addr_ctx *ctx)
+{
+	if (get_dram_offset_reg(ctx))
+		return -EINVAL;
+
+	ctx->map_num = 0;
+
+	/* Remove HiAddrOffset from normalized address, if enabled: */
+	if (ctx->reg_dram_offset & BIT(0)) {
+		u64 hi_addr_offset = get_hi_addr_offset(ctx);
+
+		if (ctx->ret_addr >= hi_addr_offset) {
+			ctx->ret_addr -= hi_addr_offset;
+			ctx->map_num = 1;
+		}
+	}
+
+	return 0;
+}
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -731,7 +767,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel, intlv_addr_bit;
 	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
+	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
@@ -749,20 +785,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 
 	ctx.df_type = get_df_type(&ctx);
 
-	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
+	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	reg = base ? df_regs[DRAM_BASE_ADDR_1] : df_regs[DRAM_BASE_ADDR_0];
+	reg = ctx.map_num ? df_regs[DRAM_BASE_ADDR_1] : df_regs[DRAM_BASE_ADDR_0];
 	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
@@ -785,7 +811,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	reg = base ? df_regs[DRAM_LIMIT_ADDR_1] : df_regs[DRAM_LIMIT_ADDR_0];
+	reg = ctx.map_num ? df_regs[DRAM_LIMIT_ADDR_1] : df_regs[DRAM_LIMIT_ADDR_0];
 	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
-- 
2.25.1

