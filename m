Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110CC320EBE
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 01:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBVAs5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 21 Feb 2021 19:48:57 -0500
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:61408
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230057AbhBVAs4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 21 Feb 2021 19:48:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awalTpUjpak2wibbRDvtrWaSDownch4JRFZ8J2Ft/N3fWQkAUSoszdse+UJ3Ja0rHuM+CHUnbdVQjAsjPk5T/Upjx9aPVJ8zBm/hBIdzi8q0GelserhzJcvwb9nbIIbu0uEKeBwdhInL5L85CzL030mx0pvhX6J7H8TQxkBnTwC06SmfjWnqkub29BzrpSvH/B9gHI2PsA8RntkxzAKnSSMUTfDtYMrxt7VmFUEYetw0vDnXYwGDz7uPcMZLw2Gr+cOcXE2G1Q4nNlaxZw4mR7bwVOGjrjDplTgYvdT228g7x+UtHxmK2FntL2w7sPkoe/BtYrQW7qOaOyeJT7dgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yluKYHQuyCZ/MAkgQ62rxdZqwQxDz4UjOG5CDeBg0Qg=;
 b=NdggZYSJObt/lEOwYggyBJv4t4JCyjGjfLKOYQWoqYqy93p2KFXFMudd++JA5m4V5hDA7ICMAyAi1weCIWpOWc5SMv56RclD4w4KfldnwWeNN9g+duT/fPUb68fAl5y8D1I2JMZPGns4KVbtEpik6L0OOoP0uP9AkH2Gv2T+62Nsz4VIon6UcJsE81BpdVacW8sDYgR3Z3bpyNc351e4LNZBI9D3kGViWCVHBmyZogG6bfwhWJnJiXncs0AhWbllNE6K4gjSYkfcd3gqKbvY50aA/RYbbkEBDPJrJ3WpaoDpENvOcypGPzAFB9ChXOKqxwbCGbXhgoHpySft5pUZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yluKYHQuyCZ/MAkgQ62rxdZqwQxDz4UjOG5CDeBg0Qg=;
 b=cPisq0cYkd3KT0xZ7udQtkrTsBktczIfYofE9KV+lbKIy8jPafdkTNMrmNxtr/w0F9xF/0ABT257mBvUr+PH6ULG9BBWPkKJCOql0h1/Jf6Pxg5j+ZYKgq/bY7sY0clFWSa9mLwlD6YN392aPnarqcbBOVNMhDRkqVUQQ+utQz4=
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 CO2PR01MB2118.prod.exchangelabs.com (2603:10b6:102:a::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 22 Feb 2021 00:48:01 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::65bd:45f4:7fc4:b742%5]) with mapi id 15.20.3846.045; Mon, 22 Feb 2021
 00:48:01 +0000
From:   Jason Tian OS <jason@os.amperecomputing.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Tyler Baicar OS <baicar@os.amperecomputing.com>
CC:     Frank Wang <zwang@amperecomputing.com>
Subject: RE: [PATCH v2] arm64/ras: Update code to trace out more data for ARM
 processor
Thread-Topic: [PATCH v2] arm64/ras: Update code to trace out more data for ARM
 processor
Thread-Index: AQHW+2Xc1/u9iv8FrUCGangWCJ9cKqpjcQNg
Date:   Mon, 22 Feb 2021 00:48:00 +0000
Message-ID: <MWHPR01MB2493F2EAC5828A94F109C4C180819@MWHPR01MB2493.prod.exchangelabs.com>
References: <20210205022229.313030-1-jason@os.amperecomputing.com>
In-Reply-To: <20210205022229.313030-1-jason@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
x-originating-ip: [84.17.34.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d5bb83d-d293-4860-e510-08d8d6cb8174
x-ms-traffictypediagnostic: CO2PR01MB2118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR01MB21180F6E95408C6E1368212780819@CO2PR01MB2118.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5WpQQ84YqJwbkyoZ1L4p3fSe1OmVfabKIAeF2oRtcAGao3VD+tG1qEa78kvQPNfi6zEWpZ/3yHujk/WANnV0vdnfxccNyZ6n1X1rqnqnJ2RuGC5KdfVwYPwOL8xNSgkcH2XVRcj5/9rQJkm19nIj7fEzERcPKmS8Q3K9i00J6xgJJornjHRwERxsHgBwxFGiE40iioKoiyNUcuk/5VXbspTEzk8KlXIlcr30aC3wt/LhSzD7DTiDQljly2y8Pz7agVkcdbrh1my426HbnVl1MntFhC9pQOty5ZV27rcTrTvQC8ojrhsQhBCPxWCAC95TidyfgzWFADQp950dKInjtPY34cxXgtLDuNCFqUjvt4IzoUP/hhagROi7YJ/2extcyLThEX9ymz6u02LBqdSr+KIXyaIe7yKMenFVdSJ7ALfNpjntvbC0ptEjYr8fGLssEk39GQK7gr2AxzDKO1PxpVJ4k7qMdm3qSeqVZyammKHreAHUKlr6AzupUp9OX9QlBtVm9FGO6tCqNSjhow2mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39840400004)(366004)(346002)(376002)(15650500001)(2906002)(6636002)(83380400001)(8936002)(4326008)(33656002)(8676002)(478600001)(107886003)(9686003)(26005)(55016002)(86362001)(110136005)(316002)(186003)(66446008)(5660300002)(52536014)(64756008)(76116006)(66556008)(66476007)(66946007)(71200400001)(53546011)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m9VUmOqr4dH/YVAAbywpcjG/Y7mKGX7BB5uPWgwxZosPpOsmEDPOyURvcVrq?=
 =?us-ascii?Q?O38E+4pVs7P2PCfJEttfHQloQWjuIidu5Vp050IfEzyrr1cuFWguP3FQNwB4?=
 =?us-ascii?Q?JBGJn2LWS844Ps0BosBO/+LZqhqUeAPT27VgJbubfBqAugzZBlSVNHw256xO?=
 =?us-ascii?Q?4h+xMxesAQwghVob8sq5bTNEroPZCI5X7YD5Gr2XAmV48nk2uU7ewYR/kqmI?=
 =?us-ascii?Q?EaNVqSsYvCshf6ErFzo+LL3xrld2f6eToD6bQT81E7ghzshqwUryKgJGWxRJ?=
 =?us-ascii?Q?iJC0tV0tF7tJYAD82qjSIDP8Wud6ljszzTZxrtnr4PijlvPZT256rie6fB5Z?=
 =?us-ascii?Q?tCUhwS5TwG4mrUhbxz9VSpt/WWnMCy0DzfPdNDnaVHXcOmVNBog/nfDMHrQ+?=
 =?us-ascii?Q?NH5KGf91dgSK13nsniex1melTSqySfmGHK350fRHMol+S1U3eflc/WKXLE/L?=
 =?us-ascii?Q?WBkH6nYXTZ//brVBSQFO1QPlsbrS9k5+u/zp0JNqIiYbBuXGcOwOOYfYdWMy?=
 =?us-ascii?Q?fyq5CbWVAvkcUgd5/YuSwEZxr2PxDDUzxaqOJLkyeZ74X7xVDOzV1JN3lS6t?=
 =?us-ascii?Q?5Gq/iZGHrleWIP+tdgQ65M11B3ZAwnp1ELafMnYqidiiH/zwUe4fxyC9Xndi?=
 =?us-ascii?Q?BIajaEm/sGZd2AEYqpc91h1+SVSiFAM8+tUP3gZBAF+2Y9xyp6ZVmrPXQOGI?=
 =?us-ascii?Q?kvSZDh2Feobi6IdfjZYdLtNxZ5zdrXUyf6XWObt6HkbUXcYslDmoz5TNrE+J?=
 =?us-ascii?Q?Mk8zO1rqYsaQfg/oa8jD0CGQ8tlPMNdExKO7hJIqnySBg5AqPaUhFyozfd12?=
 =?us-ascii?Q?Nr2bZQy0oT5Dl0nxZ3MD96C6rzHs/L5tCpj5E+8/xgZKC8JqcoPmJbQOT/O8?=
 =?us-ascii?Q?+3dg06VpxGJ/s2/ozo7aVcm2uNVdY4bIRqKAvZRD9OZRZxPRc42zDZbvKXCw?=
 =?us-ascii?Q?jxwtKTB74vO9k1jMy+Mxa8x+lye2kiS1awkeNo/uEHzKEVUlszXaGFZZoe8q?=
 =?us-ascii?Q?9KqktPlElZXV4UkmE3N6687VkIJ7adNxM0mOgWA/KL8Fh65J8jLdWGexEJAO?=
 =?us-ascii?Q?vkRHmoUZRYwt84nyF+CJfjBsFPOvDKmmFOaBvw3FuE4lRaUuoyd4PGxS7waU?=
 =?us-ascii?Q?7mcZQZQ/ViM+KypwkSvHR4jXq5kgHRcqITc37By6wtnyvbQZQqyLSskdrhC2?=
 =?us-ascii?Q?ZsjmiLULvL+SiQYZoqSgZWaDLWkHIobgK5Cu9HvzLtX/8gc78QGg4MQKBt7A?=
 =?us-ascii?Q?/z3Hho+E4seH3sKz1qD+H0GeI8t4d0/VUPGFbV6D3huTzJeCCtxkwxJPEABZ?=
 =?us-ascii?Q?4eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5bb83d-d293-4860-e510-08d8d6cb8174
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 00:48:00.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8d75q4u/nhURit2D+mXlkNqkuG7iUqpphe+wmb6B0pwrl+mqIDDz4R7UH6+60R/G9V9n24FjYrwP318mwvZSTu6td6M2hx1LQtigyfhSm8CPKV1SRv8MTyIeoS+VHlQb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2118
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,

Can I get some comments from you for my patch?

Thanks
Jason



-----Original Message-----
From: Jason Tian OS <jason@os.amperecomputing.com>=20
Sent: Friday, February 5, 2021 10:23 AM
To: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org; linux-arm-ker=
nel@lists.infradead.org; james.morse@arm.com; Tyler Baicar OS <baicar@os.am=
perecomputing.com>
Cc: Frank Wang <zwang@amperecomputing.com>; Jason Tian OS <jason@os.amperec=
omputing.com>
Subject: [PATCH v2] arm64/ras: Update code to trace out more data for ARM p=
rocessor

The original arm_event trace code only traces out ARM processor error infor=
mation data. According to UEFI_2_8_A_Feb14 specification chapter N2.4.4, th=
e ARM processor error section includes several ARM processor error informat=
ion, several ARM processor context information and several vendor specific =
error information structures.

Add code to trace out all ARM processor context information and vendor spec=
ific error information with raw hex format.

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
---
 drivers/ras/ras.c       | 22 +++++++++++++++++++++-
 include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c index 95540ea8dd9d..6f32=
69da9476 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -23,7 +23,27 @@ void log_non_standard_event(const guid_t *sec_type, cons=
t guid_t *fru_id,
=20
 void log_arm_hw_error(struct cper_sec_proc_arm *err)  {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len;
+	u32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+
+	pei_len =3D sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err =3D (u8 *) err + sizeof(struct cper_sec_proc_arm);
+
+	ctx_len =3D sizeof(struct cper_arm_ctx_info) * err->context_info_num;
+	ctx_err =3D pei_err + sizeof(struct cper_arm_err_info) *
+		err->err_info_num;
+
+	vsei_len =3D err->section_length - (sizeof(struct cper_sec_proc_arm) +
+					  pei_len + ctx_len);
+	ven_err_data =3D ctx_err + sizeof(struct cper_arm_ctx_info) *
+					  err->context_info_num;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, vsei_len);
 }
=20
 static int __init ras_init(void)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index 0bdbc0=
d17d2f..fd9201214be8 100644
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
=20
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+		const u32 pei_len,
+		const u8 *ctx_err,
+		const u32 ctx_len,
+		const u8 *oem,
+		const u32 oem_len),
=20
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
=20
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
=20
 	TP_fast_assign(
@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
 			__entry->running_state =3D ~0;
 			__entry->psci_state =3D ~0;
 		}
+		__entry->pei_len =3D pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len =3D ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len =3D oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
 	),
=20
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
-		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; running sta=
te: %d; "
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
=20
 /*
--
2.25.1

