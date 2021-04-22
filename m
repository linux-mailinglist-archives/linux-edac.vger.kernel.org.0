Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C23367CE9
	for <lists+linux-edac@lfdr.de>; Thu, 22 Apr 2021 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhDVIvV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Apr 2021 04:51:21 -0400
Received: from mail-mw2nam12on2095.outbound.protection.outlook.com ([40.107.244.95]:38849
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhDVIvS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Apr 2021 04:51:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2mXFAkzujXoS+ZeggGHz5B1PYbhCRj12LC+WEBhgsJLHI7EJ8y7dmuZOGjomk16JUnudg/hmIr8IAk8PIyOtHq0zlupNJ9CBYiojekfyk8hLS26icEJg4IUb5CyKBVUMqcOR2cuiriu11jJBF3+ohaNw3GHfSPesBO79QeAeXLKgN7nCcBJv6voI7tNLMh/jK80IvUPzs28nhrEX0+lfdJpOnnchIfxddgncEHfa4N87HUeCNrSeUk5JrYNBCP0SGMQ60kgeqJUIfUCJUPcrwaFc64j6ki/BFB8qX4aTvau3X7xerv0xMbZXv9LX2LR4qYoQx5AH5Zd8OncN/bjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea1Xv9+wgD8vUczHouXXUjztdbqJAHjoeNoF9wEGGSE=;
 b=fvbzun+ZjuDgo+G0KkOc5iAZ7sBkSUyaxvxiOBjmBp+Yx4Ftu0Sc2+wwWlNLiW27QGnAvDVRm5gnh6pDX85+7yHQxuIK6+r/hPuHbHY56a7S+O+ZF5l3Qyt8Ul5+VuFk81XbrMsTgBynl8NsILSk0d8N0fYw/4AOpaRS26fYOxHO4eIzUXP78Pqq3cg4KoTleufaanOg6z5KlEuzZ8AeSXlTM5PEvhPqzp3jrRPJGBoWC3NDhZP37s2UtkCDvIPH+nbIjoa9yNi3jEkDTdwJPNMgmsejrbxWAjsSRI3dsSAOEqU8ncduUKUizoFxO+nC7awPCyTLO2zlwwAr7A91mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea1Xv9+wgD8vUczHouXXUjztdbqJAHjoeNoF9wEGGSE=;
 b=qXprlLnb3uGtpO//n7jmlH/edhES5L3zsLnSvjpdAKgNK7x4r17z6z6hS0i2xZFT/th1ua/lMUBiQoBPu0pby6PnSBaYoVcNWX+6HdWjrqwC/CQaK+TMIXw5truzAiZOEIDY/m83WgKBfYgcuazniDy+/pnPT1ASgcHIXAZ6zBQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2482.prod.exchangelabs.com (2603:10b6:404:52::12) by
 BN7PR01MB3684.prod.exchangelabs.com (2603:10b6:406:88::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Thu, 22 Apr 2021 08:50:42 +0000
Received: from BN6PR01MB2482.prod.exchangelabs.com
 ([fe80::99b4:6ad9:28e5:2944]) by BN6PR01MB2482.prod.exchangelabs.com
 ([fe80::99b4:6ad9:28e5:2944%11]) with mapi id 15.20.4042.024; Thu, 22 Apr
 2021 08:50:42 +0000
From:   Jason Tian <jason@os.amperecomputing.com>
To:     tony.luck@intel.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org,
        baicar@os.amperecomputing.com,
        Jason Tian <jason@os.amperecomputing.com>
Subject: [PATCH RESEND] ARM64: RAS: Update code to trace out more data for ARM processor
Date:   Thu, 22 Apr 2021 16:49:44 +0800
Message-Id: <20210422084944.3718-1-jason@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To BN6PR01MB2482.prod.exchangelabs.com
 (2603:10b6:404:52::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 127.com (180.167.209.74) by HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 08:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c0494a-9bb6-4d58-3a40-08d9056bb5d6
X-MS-TrafficTypeDiagnostic: BN7PR01MB3684:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR01MB36846A24E6F76D5DF16EB84480469@BN7PR01MB3684.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9lHSYxYjGI+9Alib+pfN/y0UCQUL+zEqgXpfrmGRldrAcGqpHEpjkSi+HNbXMoBxl4g8T9Zma+QdQZNMPXRVvfuCFFRN3relkvRW0h/7zZxfI8pIUCeSjeNXrcYvgAFqoj0gkfnde41slrJ4Nok2n6guJRp1gbZJd9fBKjvXfSRJyO2sQwm9DUd9xIK2e69PuyZcFi7Clb0pQm/uQz6k8vugBHQ8blsp2eFs58G5mJWV40W+/UyYrX+W8ssbQPHxDL2eKAYu1tllb8B7dc32Vnp17msJZjaAwFxQoQ83MbgpgbE8yj229KIslZ6zd4M5TV8tHYSBjzMkRLi1cUwTBGrHG8B/Hq06AuuAX1i4p9iXWyFtkiFn9FUZUKk/2T3b/H7sa4Gk/ztO2z4d6lU+1qS7i00mMNPazwj51ObHpk9zSyKDShxgKok4de98mmBpHT+o6aVn8dpOh5G9xq0nOXS8Nuv6ey1e6W3iaEn89YaTlV++MnV46uXONP9a1B5uKrZbss/vHgn6VMgPNMgOsvXHJCdVpLJ1qnRbk5CPJ+GMpBnk7w0oNHWwDMriVfNYoH3/DCrlEA7+RkWOyWl9aJpu+6sSsMQ6/nFlGH4MiGkEtj58/OFnbPNpK3xnJNOXmTpiIRonBIt1mRmr8/MW/GFiC3hWYf7JXznMF6eoE8gX02eCADjKV/A6Bk9wCZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(38350700002)(6666004)(38100700002)(6506007)(16526019)(5660300002)(1076003)(6916009)(6512007)(86362001)(186003)(8676002)(66476007)(316002)(8936002)(8886007)(83380400001)(52116002)(66556008)(2906002)(2616005)(107886003)(6486002)(66946007)(956004)(478600001)(4326008)(26005)(44966006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uPT3MDC600OZUeY0+bd3lVXVOzz3Y0plth/gPpKJi4V8t7woMMhSftqArMer?=
 =?us-ascii?Q?4zY/J3Ge3/7T4HMDc/DxbD58KqhIMptn59DlptAbJJQTWrdg0ivl9SZaOK6a?=
 =?us-ascii?Q?VDGpfsL0LNAtAKjkgqNwN464YPpWeHYccQIOb5mu4UfjjUr60nTGzsSaiTKn?=
 =?us-ascii?Q?ZLWMIsQ6+ne0kxtah1oF+w0NrUBg03rRq9yGpM7WX+IEB0YaikHWjXEg5uFU?=
 =?us-ascii?Q?CxBOR3j8yQ/6LvxrMpKsjT9r4aJ+P1exa42t+GH0GdPIwX4KHwt1sh7BssE3?=
 =?us-ascii?Q?QdWlqU3GGPEU85QjfGf88uB1NyT+N2Gx4vYeWX4dALBO++BTfyKgk6ExItk1?=
 =?us-ascii?Q?6GF8hnth7vusvg5RbnBunvCsYidQv1MhavCp7wWiM0E3imppcmovNgiiX4/k?=
 =?us-ascii?Q?gc/qC1hUkEAs8q6UakDEYqKLLV4nHPtJLG6rgxq4aVL2xgpOicyGT0ufv+Rk?=
 =?us-ascii?Q?2YRZ66feOMOavhySf7zEMEsi3o0cnebzHr+5xC75BpnvXZHGTfHjgRtohoUb?=
 =?us-ascii?Q?1GkIp1gGpq6J4ST3PVseTjU+zguiGc6yh8V1iooFCSBAFf94ZNEM0grAcJWw?=
 =?us-ascii?Q?oBn7mkogK8XOpv6CVmTQ4R2Gbvn3vA4u89VIPLfWa2RupvwVPLnQB9C6mq3n?=
 =?us-ascii?Q?83Hwuckq9W542+lHOEoaE4/A1o9YHGeUcsBMyHGou8KVvqY9erQ1raoPOs4L?=
 =?us-ascii?Q?ed1AcGYoGSuYuhhNkidW3HJ5e71pxU8dtkYLWy5JQAiL0nSmrwLUxEicImzj?=
 =?us-ascii?Q?4llZw1kOTFRqqpbj6Px3PfFAjKuK75NX+NDOJ1ByJSjcr+jXyWp8J5S7HMkA?=
 =?us-ascii?Q?m6UYspsXZbjYb4kZhz6lomX4tYIOyv+vBP9RwQParQRlskov1hmppyeX8rNl?=
 =?us-ascii?Q?aq3NIUitIrMnn7mb3savrC7BgSQDa9dVgqhJDu7yOoA7qyqByAa/Nf8NmoDV?=
 =?us-ascii?Q?Vsfy9nejVbC+lb3q94+pVN9CIpwFWMZcZnxQOTGbcQyDV7Q4/05at3MyjQew?=
 =?us-ascii?Q?jj2NbAsaDXAznD44gOh00LLCZTG+69MzhoVYyiOimJJBALzoDXGhaeYc/wkn?=
 =?us-ascii?Q?iCHDD8lXO8jvEZyGS3JJsNxZgvTqnC5RAZMMitSzgCFl2t+PnrnHMEUx9BjK?=
 =?us-ascii?Q?w+d7v1JNVeQlknUs4eOaR4en/LtXE1ozuEIbUIMtmSuVM2n9W+KhKJCyVd0m?=
 =?us-ascii?Q?EjjZfJtIWncdwiVHWxn5bmoiQgylKxTCHDGU/xtJFZh4/LdbzF2y7RwUEtba?=
 =?us-ascii?Q?j3GQBuhxDVMguP71jWuoLpt6fCNHTFXGmDrk8MiXNWT2DE0gZwhOBBwl/MeQ?=
 =?us-ascii?Q?BqN2HaOWK4F/q/6hYW/A/TnG?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c0494a-9bb6-4d58-3a40-08d9056bb5d6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:50:42.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HndKgfOUj/mNl6mMpt5mNKqkTZRMbCBkp5QGkeh0oAf3eok/lO4GZYZPvDoQ8S2RDKXrZJx8AwkVijLN60iE3PB6evvhCdpEyrhxEEpPgKA2sYiBlKmbbhlgXWHbTJ0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3684
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

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
2.25.1

