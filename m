Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC53102B7
	for <lists+linux-edac@lfdr.de>; Fri,  5 Feb 2021 03:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBECYK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Feb 2021 21:24:10 -0500
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:56224
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229816AbhBECYJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Feb 2021 21:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMWXzPH9FtyDUIYiuk9ronPvzuzq4exeY9k1ONYeYq4yFJvFlopfPx7sKEcc4PHE5QdVUXsBRDaiNtSNsTC9A3gN5PEVsXSGrQY/7K/sasVSIEcVXISDCFLFHGEgbxVdSzq3RqxC4l/+7s++K2YwywNpbhvVf3OcfzLPtu8OZwDkHAMXHqyaVRP3bbWgwOwOF8VB26nMLwne85k3n8pTpbx3spNdtOIx7XS4NAV/5yDGSWxbAik7yAoPuykfAFUj4vE2GvCt9XbRkxPK1spTVu5JLvw6DPxvSRrs/B2VJvUZk8D0neygKgOkW+NEwllW/B9I29uE1XfA7TKFwe/EUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IyHSetl68LtSlm0rJ0PBLkDzogbwcmhrE/r3FLc9EY=;
 b=mkS8sqfLZ5sNaCl3NCyNM5O+Nn8nz5doE2XmIFHadvdT3vtGVxUsXqF5cbKBmIV4s+AG157DD0GTOHDQf028fUlWiOCI9QrOOF8g4fNP3zsh10YdF8q3LJy3WUMSaAEqj3oKWREREdfTPaiwu1j8sM+Tv5kB9jktCVDS4JgBkZ3roaOMFcpEwe0MrHAMdDG22eGgDS2w/eNeCuqbYdpk617red8oF9ZLthpsUiTwkTg9wfv/4XJZfqWYvZsWXDwdRp9c41Qu/bMo3d1/iHtTodojb32R+7XkQ8fxsyg6lKIotp0cZ7YIWBWsPNvj74560g1pM99Fu8Vl6Ogm3CfrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IyHSetl68LtSlm0rJ0PBLkDzogbwcmhrE/r3FLc9EY=;
 b=DX35u9MOyO/KmqaUm/NtbByOdchZgViGuKFaFZz146gaXdH4Asqy1zufl9oWzKeoJjC95sNzIwvjEYhKEXWJJWgeGW054WUM3XH9PDb/uKBcfHmINol/CCJ0q/31YcMKs+BptHgF/nmzdABcS0vRCSWJU69/QHICgFWNv6TaKBg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 MW4PR01MB6324.prod.exchangelabs.com (2603:10b6:303:74::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Fri, 5 Feb 2021 02:23:17 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742%5]) with mapi id 15.20.3825.021; Fri, 5 Feb 2021
 02:23:16 +0000
From:   Jason Tian <jason@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        baicar@os.amperecomputing.com
Cc:     zwang@amperecomputing.com, jason@os.amperecomputing.com
Subject: [PATCH v2] arm64/ras: Update code to trace out more data for ARM processor
Date:   Fri,  5 Feb 2021 10:22:29 +0800
Message-Id: <20210205022229.313030-1-jason@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To MWHPR01MB2493.prod.exchangelabs.com
 (2603:10b6:300:3e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 127.com (180.167.209.74) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Fri, 5 Feb 2021 02:23:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040e118f-9efe-4186-96da-08d8c97cfecb
X-MS-TrafficTypeDiagnostic: MW4PR01MB6324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6324AA23FE3BAAA8DB40B6BC80B29@MW4PR01MB6324.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNHatDcBdASbV/hJQ1xzR4eQTObaFPpUVPX6zeDxz9YijDoh+Xc8tt3iE7zMjwrfmtavMXV2wOx/c1SLrAaPEtbqYAIyijgj6E2xHXFXLJODF5rmoywFc7UwNv7TsW330P+JruOHhDysHAdrn4K1Q4VMyBkK91PkNLWQVHSuaTg43cPQY435Ou1am4BHvrktWZSd8wEaaEWISZUD+tSoV8tmwwaHH6N4hd9xce8xdFzpRSpG4G9cPV4JLUEue5sPt99+GQge9PW/CrsB1rRC21GO+brQRlaLUKpi5HgczSizD1Vl/GWdNdkAVkqJEHFzryx0uExNXJ+D8h0S7uMt6mjrzpLdueDvzn39DNC1q2u0k5L7RqVh4SkbpqyWVgF67YG0gyzlC+DgbFqyp61+2C4aWUAAha7YgMwU2g6h2HEodIbX26FtnqBzF3c7H/uN3Ot3yQLPtSK3/9i3kGHhiAemRKmZTuqX63jXpUhtFKjBIuFHp/QZjM8cW7z/UWAGb1gjH8L+NxcTDtaKAUSW6c5qFB5FFohiVTYm/J5uuuWRd11KXCSJcY99DKsA8IPs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(6666004)(16526019)(66556008)(186003)(6636002)(2616005)(66946007)(316002)(8676002)(956004)(86362001)(107886003)(2906002)(83380400001)(1076003)(478600001)(8886007)(66476007)(5660300002)(26005)(4326008)(52116002)(6486002)(6512007)(6506007)(8936002)(44966006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OqoTymifTN81P9LFt5OyiSI+TKbwMDxz0x3aq6JMDARwPFJDYIaU0DvTbGeq?=
 =?us-ascii?Q?SJTqi0hS8h55SPJ+EjJPRHvD27KKfGuKQsZSKGROUVjDOjyCgVcYWFHiaasf?=
 =?us-ascii?Q?Do/bivdo/T4ekg/1rZG5yl5WT1Cu7v7cWVlPZNg2/evHqCrBOh85a1P2uiiF?=
 =?us-ascii?Q?VGbyuRZ7TBfqGPozGLrDqsUwD2Ht/f9ojOleDp7MvXbXlUYW2RXbiT76xOOk?=
 =?us-ascii?Q?uVSbau0RUs+0qUKNVyUFlkND+QLubSnwjCYGanFP7VZ6VPpgNXNJ1IL3mK5e?=
 =?us-ascii?Q?HMVp3ttCTBj8YNx59Vx85aoAE2HD2V+T4vQ149KZranACU2MJj1veveAmrvT?=
 =?us-ascii?Q?oZdK4D/Z3s9BLWRduclgeu1xRlTynDZQHQRgQgTjryDp3yNLJiov057DiGPl?=
 =?us-ascii?Q?5kGpC6zw3y+oLetSwPdbVrm94+VrvcHFU4WGq4289Ys6js87uKuxJ+2lXOI9?=
 =?us-ascii?Q?WwZyeA0bUUhhtP7zrGcBImOPjcXwcZGgYKouezvJY6aCej/6ppeuxluR8im9?=
 =?us-ascii?Q?w5W51VEPGhYfSQMMpy78TUCgWk4CmFKER7sUHaHwcAj9HnrzIqm64NiCSpqr?=
 =?us-ascii?Q?MixoOmAumQDpKbKXTI2TUnMqcvdvv9E95/jlukhC0wJXIiKdIHaT3PvhV22a?=
 =?us-ascii?Q?daY3Equ0XIT44XNwCpH0pnwN2InmHNBEBpc26SCZgWYE0giimUC0mRlsIuOH?=
 =?us-ascii?Q?W0QPUOT77o7VvaILMkll6XHvDbGksDLvcz4lSNKkxSIOfwJSYB3q/bajrsS8?=
 =?us-ascii?Q?VNSB8FPIGXOqx6PCl9dW8sZIW86zx7iIoU9DEyKWOTiNHmr+wN1aeqSRdVnm?=
 =?us-ascii?Q?UkwqXwC8hHq72qGkSTDr8HqI+A2X68aYXzoc6wZJVqqHMA8nHUwePuRS+rMn?=
 =?us-ascii?Q?qnQIa/H0G/wh1HjWAPaNkAdojg1Be86P1S7ErwC/W8r3AAI/yjmwLEzh5tE0?=
 =?us-ascii?Q?UOsoH+Ghzcm110aK/VOsLTpZsXy5DrvPLAeFhiDNtp4xcw0Uwuo6j9rwfCba?=
 =?us-ascii?Q?3SD/QScPW+I9a5qw9IyofTQW9Mym5KA6OF4a2/zfqpdaNE4nf6Alvifldvae?=
 =?us-ascii?Q?jLpExiSp3wN6X6C1cExf79kt4i1x63vYsRKEni3hFAPJuOhqPg+VOURngIgN?=
 =?us-ascii?Q?lKMBMWfSXlbXoFUii7gFTEQ/YF3Lyjg9V7LZ2XbsWeN9uQDM/7RpE4hGqhk/?=
 =?us-ascii?Q?kAvIyS3oDl8LliHr4eM5vFdaJuw9zob8DGSiS3s4fE8eQJntFQcCza6GveEL?=
 =?us-ascii?Q?z3ZjpHymHaCd0Dnrq0i/G6jFQLsEb96PWYi416MFbS03VwXMXK85sXE+ndfW?=
 =?us-ascii?Q?J5AE5aWQP1I7+OZkOiQjTV6v?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040e118f-9efe-4186-96da-08d8c97cfecb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 02:23:16.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOl9VOzN/vr9+CqWzTRXNljnNrjs+XCAF5vzJbt2b0+wPvav8Rs9vZV8GDuRuzcLwnr84A5DODYi6C8XJdrha+uPGCZ+YIANzl6Z4SzDHk0v1fwLi4jClyCPX+CaXHG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6324
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The original arm_event trace code only traces out ARM processor
error information data. According to UEFI_2_8_A_Feb14 specification
chapter N2.4.4, the ARM processor error section includes several
ARM processor error information, several ARM processor
context information and several vendor specific error
information structures.

Add code to trace out all ARM processor context information and
vendor specific error information with raw hex format.

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

