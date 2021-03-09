Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5E331F39
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 07:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIGXa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Mar 2021 01:23:30 -0500
Received: from mail-eopbgr750119.outbound.protection.outlook.com ([40.107.75.119]:37504
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230202AbhCIGXJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Mar 2021 01:23:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh7xJlIblddx688H2LNbQ/bijNq1ZGIOHjLGtQo8v20TK5r5ARh3RmbX8EghSuwwmmwNWo2gD81LOr4eazRutmRaCttVlWwwlo6CqPcefX0tqxBLgGSPRO0zvseu+QHf0iathTqiICU+D5gpckdMd328ZMniH7W1ELA1HoIaDLZSLy3Xg7GLOtBV2iMCE4khULCJ8z6t4MzW2EQKJ1OLXp3LHyzFxUdDXBXJeLp6CRTBzAvnJlQrMUvqPhSqyo0DxilSc36NhuD2Xmv/BPDGKQp0jQOw0kPm14JrvcZBTruSxCeGPtenyexTh7eu9onqltsqjn32XCJwwWOi4Czb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX5LYiHuxbZYyzFK1eHAHMgNscaBSwu/AzzmlAsedAQ=;
 b=GN6bFyLbCc5uQ0PA5PDv+bNrFPxkCziwKSh7kmWVxqkh1xrTFtcvztE1yfVh8mZQPltmQjNlZq1YGJlxSFYgXZ0Zz8xA0GbP/vlIBJFFjm+LR5eKXg+ZbF5a70EY8Uz3dsBEcq16FSqaiAR2W1hbcHar7NiGYhNPxJW8KxWoVpR04SyqxI7wIHpqjfCIk3s43RPrIiKuOUq+vBiTpEz7KNVHtNZBqSX2TeY/vWqDb6vxAWZHKxBwWUNcKNoZQR3Oa1LliEkpbizPVW3Gm866TSk4Ed0ecUL5PU3WgSL3+FOjYsSO3lmb9V6XYbzcI1/KosJlbi//r9vnCG1D623dEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX5LYiHuxbZYyzFK1eHAHMgNscaBSwu/AzzmlAsedAQ=;
 b=ji85u2Xs4aQRsMKgSd+q19PLxmlINkw6YL9BimXi6LvdLq6gmKKvccGabBO7+EvSQPWZwRGhTzFAdvo3GoFk+JICvVnO8La6gWhazaczuY8H1cTj8dQYQjFlF4r1FoIW7UQnP8tT9I6zZVJGJzFIBrh27qH6N1Lp88uP5kAVp/Y=
Received: from MWHPR01MB2493.prod.exchangelabs.com (2603:10b6:300:3e::11) by
 MW2PR0102MB3513.prod.exchangelabs.com (2603:10b6:302:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Tue, 9 Mar 2021 06:23:03 +0000
Received: from MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::61d6:7904:e7bb:6d15]) by MWHPR01MB2493.prod.exchangelabs.com
 ([fe80::61d6:7904:e7bb:6d15%6]) with mapi id 15.20.3890.039; Tue, 9 Mar 2021
 06:23:03 +0000
From:   Jason Tian OS <jason@os.amperecomputing.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHW+2Xc1/u9iv8FrUCGangWCJ9cKqpnsmUAgBOv8oA=
Date:   Tue, 9 Mar 2021 06:23:03 +0000
Message-ID: <MWHPR01MB24939A15F6556C690CD0891F80929@MWHPR01MB2493.prod.exchangelabs.com>
References: <20210205022229.313030-1-jason@os.amperecomputing.com>
 <fa62e22307374cc1a269750ffc1862f5@huawei.com>
In-Reply-To: <fa62e22307374cc1a269750ffc1862f5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
x-originating-ip: [180.167.209.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d1bab64-14b6-4875-92f7-08d8e2c3cb9a
x-ms-traffictypediagnostic: MW2PR0102MB3513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR0102MB35135B5E5FC063D6FF96A9EB80929@MW2PR0102MB3513.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qGN9UNNYlzIfrhVXZuPA1cIbK7YxBqXGZ8+q80lhklWO8ZqaKx/12csFVMnEWogOv7DNHPH5rDWsMUwQxj+S0IhWzUyEFBC+ypb6ND48YmBkTxkOQKkqWAuBoacxG6y1TutgdpFbFqEJPwuhXmhxiQqUVvzV+5jfO6S9tHVR6Ddx5Kf66h93CndPlXyrFA1DmROdN/NUoPq41Vsr1WPZhBwKuv4iKtNsMuhkwJ2xh/Ir8NZst0FH/QSzwef3aSkUXV2BCQlPz727r7NeKaelqZygYLvQV9/cVfExdKRcJz1dawmLiQWMLkdMcU7o+Wm+52kRFiSCvOs9jf0zPPSfQHUnzgCxrU3mnrW+P4j0r256vlslk1md73xKmptvAt+h2/KCYUXHzyHGnVTuClZ+hGwNb4WEea8RwAQ85ho7TR++cjY0mhBwUpAwA3jpbfaj9j133dMk0fvWObAja+4YZKM61Vz+h3zwobP0DzDJcu7CobnCxcTd69ytCFZ+jSwrBNX1+UU0+3BYWAWRn+2/KxDQwSOUfcE0RCgd0XkCwTySb9AfMOrrB8wqvXyVS17rnD2TPpJhu77U+BxockW3Eb3W57Vr8RMSn15ZvB7ZRKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2493.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(9686003)(76116006)(7696005)(26005)(6506007)(55016002)(110136005)(2906002)(186003)(53546011)(33656002)(8936002)(478600001)(5660300002)(83380400001)(107886003)(6636002)(316002)(15650500001)(66556008)(66946007)(66446008)(8676002)(52536014)(64756008)(66476007)(71200400001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fIQqV86pBhFveV7uf9ZJbt961boAo0eGlcpkUsgQyFXgoU/B8L6enhXHYgSc?=
 =?us-ascii?Q?8kEbUPwmi+Dl9/dYknkjisBi2wqTKQkYSz2psQ2ESJo+dWnqSm7G/Z2Fiw2o?=
 =?us-ascii?Q?aO3CK82ybC5wmv1W83mxluchIB1t19dWFIsaZz8cJeb09eMJxv4xCXT9uTZN?=
 =?us-ascii?Q?9edukQkYS6GaaHgkcQjLUm8i0RYjzl6/DVJ6aoboL60/SP0vl5i8md3wntn1?=
 =?us-ascii?Q?uBArbtjBjDjILOx7uoWXTb7pp6pjycEXWphJLMgTTUQcBucQhjEi8ylzVfDZ?=
 =?us-ascii?Q?NOgPrIIFr9eVu4quZ6Vo5PpCQ7r3GlNSgZHzloTTZegeLfTTxNp41bG73yx5?=
 =?us-ascii?Q?L4wZSfBgp47FuQDxl4I8SADl3vEH/6uG1F4LSRB8dWPLzTwgZDNm9NZzbrKj?=
 =?us-ascii?Q?XtpdLBPUCrQe+uHNC9oJvQxdJoh2UUaVwCzH+wmiI2abeXjumGu05yI3bAFk?=
 =?us-ascii?Q?EU8rezVL92U3VJDEkwEBS/UIbJP4seUZGvccc1QSZCK5dugrwX6+dqzd/wVD?=
 =?us-ascii?Q?yX8oR0n7SuJ3IPaEJ9hQlGhSlKkJGYeucNjv3T1dtC01LG0/hSSMdqiDJUDz?=
 =?us-ascii?Q?G0cLWNprITjGbJW3FfHyc+FXSK4KgQbIeWDPsBm4bkSZ/gbjEr2qqvdwYEm6?=
 =?us-ascii?Q?4EEHBXbT7V3NVetG6RvUWHtOcUjLw3MmWj/ksYcDwnCGI7EJ1D2wPDoA1iYL?=
 =?us-ascii?Q?ZnMp5l5UDfBmy0X8dxwDWxmacuc8gQkr5sr8/zWxBHzElGOAA+kn4uTTA1D1?=
 =?us-ascii?Q?zPDjyAquGgTZxdUFbHUNt3zqGy2nE8txLAF2ot98kcFzWZiR0JH2FZSr02ij?=
 =?us-ascii?Q?UcVT8EpMPfRoJXdSy1m7V/id748SeEgtt0v4X0fcjAtGScDivkQWZpiKshVn?=
 =?us-ascii?Q?l3iQFtlhFiuz4YS7S9rOy+/291BND8u4RPLsU/TU/s+JBzjx1IMG0cwyUBrO?=
 =?us-ascii?Q?8wzSsIvD+f0QMAHyLd/0X4WWLqdvikw8kyQuG7GDHHEaPzrZBcuSL4PtMayO?=
 =?us-ascii?Q?KIch1NvjkGFuGNMxm8Pa/HbFsilU3I+AS1Rx+D2yF/4N/+eaonATJWwQlhY4?=
 =?us-ascii?Q?qMLyTsUZBeYDWC5VzQmgiMw0Ua2yW52zmZQGpdwMP9MX8vUq2nma1SRdEnuo?=
 =?us-ascii?Q?iK6C6jwz4rDDQ2XQGmPzj/vxvu7ZuCpf2ETaMA4XSzy5ruhhQHjk3fEnPGnQ?=
 =?us-ascii?Q?y8irU7aBWQUqdHEwDcqAWNvtR/9kCxtGDyYwuDkTYtC9f+S0azRolYeWIVel?=
 =?us-ascii?Q?GqnYcBkrRAR4qGSh6kdxTtTpNbbFO7eLr0mpjRvQpbsgDZ3iKhva9DdqoQI0?=
 =?us-ascii?Q?1P0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2493.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1bab64-14b6-4875-92f7-08d8e2c3cb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 06:23:03.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcSUjqbqGmXnK/RE3EYn35sLcNw0ZbOqjBCsd2GsswsGa7rf6BqzCxSaHlp8o7hPsvxHACXh+RZLFmSZ1pyDtVBJZ5xW2zpbuX6rXAXnScBTVAWY5nrlX/CxgR9PcABm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3513
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,
May I know whether this patch can be merged or not?


Thanks.
Jason

-----Original Message-----
From: Shiju Jose <shiju.jose@huawei.com>=20
Sent: Thursday, February 25, 2021 1:44 AM
To: Jason Tian OS <jason@os.amperecomputing.com>; linux-kernel@vger.kernel.=
org; linux-edac@vger.kernel.org; linux-arm-kernel@lists.infradead.org; jame=
s.morse@arm.com; Tyler Baicar OS <baicar@os.amperecomputing.com>
Cc: Frank Wang <zwang@amperecomputing.com>
Subject: RE: [PATCH v2] arm64/ras: Update code to trace out more data for A=
RM processor

>-----Original Message-----
>From: linux-arm-kernel=20
>[mailto:linux-arm-kernel-bounces@lists.infradead.org]
>On Behalf Of Jason Tian
>Sent: 05 February 2021 02:22
>To: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;=20
>linux-arm- kernel@lists.infradead.org; james.morse@arm.com;=20
>baicar@os.amperecomputing.com
>Cc: zwang@amperecomputing.com; jason@os.amperecomputing.com
>Subject: [PATCH v2] arm64/ras: Update code to trace out more data for=20
>ARM processor
>
>The original arm_event trace code only traces out ARM processor error=20
>information data. According to UEFI_2_8_A_Feb14 specification chapter=20
>N2.4.4, the ARM processor error section includes several ARM processor=20
>error information, several ARM processor context information and=20
>several vendor specific error information structures.
>
>Add code to trace out all ARM processor context information and vendor=20
>specific error information with raw hex format.
>
>Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
>---
> drivers/ras/ras.c       | 22 +++++++++++++++++++++-
> include/ras/ras_event.h | 41 +++++++++++++++++++++++++++++++++++---
>---
> 2 files changed, 56 insertions(+), 7 deletions(-)
>

Tested-by: Shiju Jose <shiju.jose@huawei.com>

>diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c index
>95540ea8dd9d..6f3269da9476 100644
>--- a/drivers/ras/ras.c
>+++ b/drivers/ras/ras.c
>@@ -23,7 +23,27 @@ void log_non_standard_event(const guid_t *sec_type,=20
>const guid_t *fru_id,
>
> void log_arm_hw_error(struct cper_sec_proc_arm *err)  {
>-	trace_arm_event(err);
>+	u32 pei_len;
>+	u32 ctx_len;
>+	u32 vsei_len;
>+	u8 *pei_err;
>+	u8 *ctx_err;
>+	u8 *ven_err_data;
>+
>+	pei_len =3D sizeof(struct cper_arm_err_info) * err->err_info_num;
>+	pei_err =3D (u8 *) err + sizeof(struct cper_sec_proc_arm);
>+
>+	ctx_len =3D sizeof(struct cper_arm_ctx_info) * err->context_info_num;
>+	ctx_err =3D pei_err + sizeof(struct cper_arm_err_info) *
>+		err->err_info_num;
>+
>+	vsei_len =3D err->section_length - (sizeof(struct cper_sec_proc_arm) +
>+					  pei_len + ctx_len);
>+	ven_err_data =3D ctx_err + sizeof(struct cper_arm_ctx_info) *
>+					  err->context_info_num;
>+
>+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
>+			ven_err_data, vsei_len);
> }
>
> static int __init ras_init(void)
>diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h index
>0bdbc0d17d2f..fd9201214be8 100644
>--- a/include/ras/ras_event.h
>+++ b/include/ras/ras_event.h
>@@ -168,11 +168,22 @@ TRACE_EVENT(mc_event,
>  * This event is generated when hardware detects an ARM processor=20
>error
>  * has occurred. UEFI 2.6 spec section N.2.4.4.
>  */
>+ #define APEIL "ARM Processor Err Info data len"
>+ #define APEID "ARM Processor Err Info raw data"
>+ #define APECIL "ARM Processor Err Context Info data len"
>+ #define APECID "ARM Processor Err Context Info raw data"
>+ #define VSEIL "Vendor Specific Err Info data len"
>+ #define VSEID "Vendor Specific Err Info raw data"
> TRACE_EVENT(arm_event,
>
>-	TP_PROTO(const struct cper_sec_proc_arm *proc),
>+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
>+		const u32 pei_len,
>+		const u8 *ctx_err,
>+		const u32 ctx_len,
>+		const u8 *oem,
>+		const u32 oem_len),
>
>-	TP_ARGS(proc),
>+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len),
>
> 	TP_STRUCT__entry(
> 		__field(u64, mpidr)
>@@ -180,6 +191,12 @@ TRACE_EVENT(arm_event,
> 		__field(u32, running_state)
> 		__field(u32, psci_state)
> 		__field(u8, affinity)
>+		__field(u32, pei_len)
>+		__dynamic_array(u8, buf, pei_len)
>+		__field(u32, ctx_len)
>+		__dynamic_array(u8, buf1, ctx_len)
>+		__field(u32, oem_len)
>+		__dynamic_array(u8, buf2, oem_len)
> 	),
>
> 	TP_fast_assign(
>@@ -199,12 +216,24 @@ TRACE_EVENT(arm_event,
> 			__entry->running_state =3D ~0;
> 			__entry->psci_state =3D ~0;
> 		}
>+		__entry->pei_len =3D pei_len;
>+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
>+		__entry->ctx_len =3D ctx_len;
>+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
>+		__entry->oem_len =3D oem_len;
>+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
> 	),
>
>-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
>-		  "running state: %d; PSCI state: %d",
>-		  __entry->affinity, __entry->mpidr, __entry->midr,
>-		  __entry->running_state, __entry->psci_state)
>+	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx;
>running state: %d; "
>+		"PSCI state: %d; %s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s:
>%s",
>+		__entry->affinity, __entry->mpidr, __entry->midr,
>+		__entry->running_state, __entry->psci_state,
>+		APEIL, __entry->pei_len, APEID,
>+		__print_hex(__get_dynamic_array(buf), __entry->pei_len),
>+		APECIL, __entry->ctx_len, APECID,
>+		__print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
>+		VSEIL, __entry->oem_len, VSEID,
>+		__print_hex(__get_dynamic_array(buf2), __entry-
>>oem_len))
> );
>
> /*
>--
>2.25.1
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Shiju
