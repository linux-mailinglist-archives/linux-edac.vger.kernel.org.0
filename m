Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBC3DD033
	for <lists+linux-edac@lfdr.de>; Mon,  2 Aug 2021 08:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhHBGCU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Aug 2021 02:02:20 -0400
Received: from mail-dm6nam12on2095.outbound.protection.outlook.com ([40.107.243.95]:57824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229805AbhHBGCT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Aug 2021 02:02:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+SGmLfXQKCRm7KFaQjPXkMveAXD7S+/yAglzdXFysDXWhbX4lKAUL8CO44uG2bJogog9TIaVfRYeNQth6ye3DQV6TbXIJmtvBHXGBHgGcS1We1BHDAc3N9uw5FBNaZ8BRq9x9L3sN/rruzCsiPATzMpLJLp4rfDyexSwc6z9x2c7NkzONWUG4ZIBEEiZHTzaQ7vX6DdLSNcrWm/C1AQxoDqnMIgyvcbqd6KhgLMBYYW+IVM5P7stdr75Y4pCCeclTpFZfLLvrMMtMfdCmhhAP2u0HpkqP3sd8C3WI75Ku+hPzN2qA8OgRKd11YMgqf7umhsrEyY+XnaIVu/vrQsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F98P+nC1+pyTJpl83TLg4/ceTCpLRhku1GsoV1tc8QE=;
 b=U0wxeChvsypTUjfLH/eMVxc98LW6JgtjJRsD190oUnG5mRKyQ6a9wPKDSNVj4+vxiN8Sc5Kyk/7ovW5NPmGf8iQASEwqcwRJgp3KRZ3kPcHca8pNZbEuwtR61HxLx3fqcKX3pFiqX5CfZC5SF+0BE5fWjF2vUtRRd984LnKVl4gdm18ZE2kv8mNmzhsDScCjatj5gD3mc7knOhiFTcRDGZCKPWqX3hwgEDWZLjb1/YX144jDpeMpf0kF2tumNqD02uaC7gAw/h+b+5NWBiRVu2O25hp3xEi8lHzVtP5SlOfdMuG3O7C2fpZmkaISRNdPJ2/w7ATz9Z3KWP++f48Ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F98P+nC1+pyTJpl83TLg4/ceTCpLRhku1GsoV1tc8QE=;
 b=B/42Kulmgkn4jvWSfbf1vxKUTfPV+dFbgynwc2VNUrmqOGYnWBiyHUOPtUT2mr3m33XQWL0MaJ2lPA4XYl2VNw+kSNoWSM3omOKBtMK0MHDAHHanWqdgxp2OUm/jsfRzVZrCsv1/U7/UEO+3loNgprGfq57UE0pPLR2gFgwBG2M=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW2PR0102MB3403.prod.exchangelabs.com (2603:10b6:302:2::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17; Mon, 2 Aug 2021 06:02:06 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::9d11:11d3:b589:400a]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::9d11:11d3:b589:400a%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 06:02:06 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     tony.luck@intel.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        opensourcereview@amperecomputing.com, zwang@amperecomputing.com,
        gregkh@linuxfoundation.org,
        Jason Tian <jason@os.amperecomputing.com>
Subject: [PATCH] ARM64: RAS: Update code to trace out more data for ARM processor
Date:   Mon,  2 Aug 2021 13:59:29 +0000
Message-Id: <20210802135929.5283-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:910:60::20) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR16CA0033.namprd16.prod.outlook.com (2603:10b6:910:60::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Mon, 2 Aug 2021 06:02:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8c53dc-edbd-4e8c-0965-08d9557b0df8
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR0102MB34031AB06B57E401342C9C44EDEF9@MW2PR0102MB3403.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKbxU28jYiduC3cibbuFobDwxxNF92B2VbcYiuNGM/oXOS7q/bUrnZpCUTj2Px36iPs/zONbpTEAlT1VBv96dmyd1PAuGtnS8aKAN60mwP7Y6Do2f6O8wbLRawhrCqLbbXm9ma2q+CX2A4i5RgOqj44S7X7d5tQeELX1Xzeo/9uSXzkIquHBgJ+mrKbxeEAvJ7RfTYWU44nQyGM7M580nrOi6BgkuKy4y+ld3wW8dbEWai/rlpYe1GScgIwkgfUtiIXd47eG84O2cXNLecwJSLep9dkFzrtZZzIAxXP0vgPVZuGI0IbmjLcsnTU6T1ln9XRn08iE/p4YZDqwAJnTeFj6wFk28i3gTh7OJqk42qZpgToFJsl7eVJwuDJ597DW1M6CnO1SMFSIZB37vBIC95VTZQojstRoZglpnGP+jFemEsfaC/ZsLYwNfWL5CYeV+LzBjlUN0ay1VnwFhphmnDy74DqxIcvJWM6qlVx/GE9vGAZNHrljLGqgHM8I7AF9P/jexdq6Prx1k+ICUcWHjR/ic2maPCf+sPXU2p+4dwieHV9fqNYBa8Mz6p/R3bvKcwmyt8ofpy0JVxK+Yccp6zcepbjJZL3y1WoEhY+J5mmuHx3EIBq/2av3+KhtojVLuJI6jFGgo1SM0PF0DnOyIsJf0KbbexHfrw2jYzciI7WoMp8bqdJSY213YSRKoxYn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(1076003)(66556008)(6666004)(2616005)(86362001)(316002)(5660300002)(66946007)(26005)(4326008)(6916009)(66476007)(956004)(186003)(38350700002)(8676002)(52116002)(2906002)(8936002)(107886003)(6512007)(6486002)(83380400001)(6506007)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohKWv42Kgx9nlzAxB6wZ9rqOWA62/c+q4h5usJmSmoXMC7a1dKcqm6dAWYtB?=
 =?us-ascii?Q?sGEGxEeDu3jIqZeO24Ad09+dt1DCfbPL7sWe8e3aGlEKzAvB+T9Qaw19jTN3?=
 =?us-ascii?Q?X2tKkvKpv8H1J/au4he+re1nbYoX34UfUx2WHlgLklXQ0MT433bJRRmIa5+6?=
 =?us-ascii?Q?uhH91B2I3B4RbXGR9lsPClKXT7BLEz4MfTQnWS1yGmMAxcrWDki4kaByeces?=
 =?us-ascii?Q?pGVxoazk/ww5br4QViTnSd9caE8QV4OCAA+SUNfvMTbBrZxVD28vwm4Y1rbT?=
 =?us-ascii?Q?VjO6obJz+BaWAdiJky71CrWX0yX2QH1oxwzX6Oqm8rOletqsKGMLNrbvLVg7?=
 =?us-ascii?Q?vwQ4qhUvJ+udUQXcdDJ859jbB23+nldObWrRdD5XoYweDYDbQvvsC/f+owJu?=
 =?us-ascii?Q?rmpdhDtpnQSc2PBCdh0lXM9myCuuxTaKhkeD94luA7nLxT/QxHR4xf12A9ef?=
 =?us-ascii?Q?o7SQi/nkBpUxqjHA3sj5VjYkdf/GtTjB8p5mNzPZZyMJxiocBolaDi2kwv1P?=
 =?us-ascii?Q?Acr2MgjwlpTrKcEGb5iWRw2hNiLlxCftcUMUZhYtvsaBUgeZUwD4bddWYE5n?=
 =?us-ascii?Q?k8F/AHO8kf+zBduBTIbBdHlG7GpmC1nUR45HPT5RYl8I3DiNAXDwzC+K1YHS?=
 =?us-ascii?Q?JHqHgIxjwJoo/xv+bx/lMwHcvZ64CKDKoN1vHvPqg7S99maGYcSIrlDW7h47?=
 =?us-ascii?Q?tBzVyPE10CzRyDztn2l0wgRpGaf9M+LasNTtfFfXowb8GO96Vl02tTZ4ks48?=
 =?us-ascii?Q?BXUqngpYLveQ6tx7SQfsP79Qzs7RWaPSvtfk/s1eGT/yKHACEjvQDyAi1lNP?=
 =?us-ascii?Q?3G7JJjP/kq3s//xjhzG/rNR5OktZd7fQL9tx2Rh8FDhakQ20WLxzMrsd80z1?=
 =?us-ascii?Q?rIqaAOYwoqH0OEecc4fQknGC78Zsf/QJENBALXE6EXrvi0+KXf2jYYKc5ZyN?=
 =?us-ascii?Q?CSDPNyLjR2vJ0Spw3QuSZiYzb5991bsFUv2IQXZForJXm+hDQKkHXur8CBCk?=
 =?us-ascii?Q?ilVu5Phgu8ttkcyUjBu1+tsHottOS3QjJeEU4V6yopN1xn7CVMOpuBkn5tbA?=
 =?us-ascii?Q?Pdg9V7ys4xP3au6dmiLdqHS0jYq3nqBz9mTxq7doEssanbpgemmQclG7od9m?=
 =?us-ascii?Q?3V/fxrLaaEe4nfB0eyAC3Q1GiqrPbXKULGYsrDFCzBUtlhoTNiQCVlTH8n5p?=
 =?us-ascii?Q?hLRU7ZfDuGZSt4BOk90Atar60HzQVWa4ta08E6nRO9tEa07aFfLhVYkvDcvy?=
 =?us-ascii?Q?JSB2xt42jJWF4Y3BM1B0PiiAIIUUqRZwJA+k4dM8dwBicf1heQicbNkc1c+f?=
 =?us-ascii?Q?Q3Jq1eq2VV3T1++VnEXY+cLM?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8c53dc-edbd-4e8c-0965-08d9557b0df8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 06:02:05.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leEp1bwfxVDZtmNupg9YwzknhL+i+4DU0R0h4fics5dc8KmLMAbnKyDwZcIf0mCFPb8JBezmBgFoKWjgUJiDFuQEN3o0GmIEbhD8pATku26DbMoql36qy1D7iuF3qzj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3403
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jason Tian <jason@os.amperecomputing.com>

The original arm_event trace code only traces out ARM processor error
information data. According to UEFI_2_8_A_Feb14 specification chapter
N2.4.4, the ARM processor error section includes several ARM processor
error information, several ARM processor context information and several
vendor specific error information structures.

Add code to trace out all ARM processor context information and vendor
specific error information with raw hex format.

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
---
 drivers/ras/ras.c       | 22 +++++++++++++++++++++-
 include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea8dd9d..6f3269da9476 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -23,7 +23,27 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len;
+	u32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *) err + sizeof(struct cper_sec_proc_arm);
+
+	ctx_len = sizeof(struct cper_arm_ctx_info) * err->context_info_num;
+	ctx_err = pei_err + sizeof(struct cper_arm_err_info) *
+		err->err_info_num;
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
+					  pei_len + ctx_len);
+	ven_err_data = ctx_err + sizeof(struct cper_arm_ctx_info) *
+					  err->context_info_num;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, vsei_len);
 }
 
 static int __init ras_init(void)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 0bdbc0d17d2f..fd9201214be8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,22 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+ #define APEIL "ARM Processor Err Info data len"
+ #define APEID "ARM Processor Err Info raw data"
+ #define APECIL "ARM Processor Err Context Info data len"
+ #define APECID "ARM Processor Err Context Info raw data"
+ #define VSEIL "Vendor Specific Err Info data len"
+ #define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+		const u32 pei_len,
+		const u8 *ctx_err,
+		const u32 ctx_len,
+		const u8 *oem,
+		const u32 oem_len),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +191,12 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
 	),
 
 	TP_fast_assign(
@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
-		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; running state: %d; "
+		"PSCI state: %d; %s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		__entry->affinity, __entry->mpidr, __entry->midr,
+		__entry->running_state, __entry->psci_state,
+		APEIL, __entry->pei_len, APEID,
+		__print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		APECIL, __entry->ctx_len, APECID,
+		__print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		VSEIL, __entry->oem_len, VSEID,
+		__print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
 
 /*
-- 
2.30.2

