Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31C05D4C9
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jul 2019 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfGBQwF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jul 2019 12:52:05 -0400
Received: from mail-eopbgr720137.outbound.protection.outlook.com ([40.107.72.137]:14363
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfGBQwF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jul 2019 12:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Pv3hk0AXEsQIwDpcRtb9dTuPNgkL3Ijw/xoePVDNI=;
 b=j13ju2rocLDoEVxMMxLL0zCvqgiyw9X+WSrMRWr3V5RIkcmPnL81QLvSjR4BIv+LGMWIjy5dTfVhi+Bos+T/zT01vcsjWMXqOwHUBY1ZK9B/1xCxOTV5zdsioVRvsfkuC4NjFZ3TSNsUB/8PrVq/fTds1N6UIFDvVqXZPMlwTxI=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3400.prod.exchangelabs.com (52.132.129.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 16:52:01 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:52:01 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     Open Source Submission <patches@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "Andrew.Murray@arm.com" <Andrew.Murray@arm.com>
CC:     Tyler Baicar OS <baicar@os.amperecomputing.com>
Subject: [PATCH RFC 4/4] trace, ras: add ARM RAS extension trace event
Thread-Topic: [PATCH RFC 4/4] trace, ras: add ARM RAS extension trace event
Thread-Index: AQHVMPZ4sF6dKk/9qkCTbQGWCWIwpg==
Date:   Tue, 2 Jul 2019 16:52:01 +0000
Message-ID: <1562086280-5351-5-git-send-email-baicar@os.amperecomputing.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
In-Reply-To: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:910:60::27) To DM5PR0102MB3383.prod.exchangelabs.com
 (2603:10b6:4:9f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c5812d0-d77c-49f7-eeeb-08d6ff0d9a6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3400;
x-ms-traffictypediagnostic: DM5PR0102MB3400:
x-microsoft-antispam-prvs: <DM5PR0102MB34000F8B833F693BAF30ACFDE3F80@DM5PR0102MB3400.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(376002)(346002)(396003)(39840400004)(136003)(199004)(189003)(386003)(66066001)(26005)(486006)(186003)(5660300002)(476003)(4720700003)(446003)(99286004)(6506007)(2201001)(102836004)(2616005)(76176011)(14454004)(256004)(52116002)(53936002)(478600001)(14444005)(11346002)(66476007)(107886003)(66556008)(25786009)(66946007)(66446008)(64756008)(73956011)(6436002)(8676002)(8936002)(4326008)(6512007)(6486002)(50226002)(81166006)(6116002)(81156014)(305945005)(3846002)(7736002)(7416002)(2906002)(2501003)(68736007)(71190400001)(71200400001)(316002)(86362001)(110136005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3400;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gJqqSNDPMaFF9q3Thw42y1FUSCDcahmu/L4Da1s0CvDnRX0T7Z2k/1wvWz97kKINRncoAYEo4ho33jdwb+8r4940IgyrD8dDbwbfXKuCjRRl9+T7WGLb3NMkk4tOlT5s7ROV3oW5jp0p3zcUBnXsVAN0qZxRAmf2zjH4EKPifQV6wp/7skI4dCjaBo3dRO5z1NHUMkJ063Jmu/ccoPHkpFFpfYZtVI4rgQZpl/uEwVAawICvwl4nOjHTArt97MkQJ4Exkq8J0HEMDIPLz6x9eJpMS7qvAwI2cVfuhHSa8VbisQqEA7Jqf3bAjVi9HcA3hnecbs+/5u/k+unnTcmK0IzqbDWlmNo/RtXZL8VBXzOIfp8zNbkWkEy5CJj1hNIGxssriOHbPG03aV/VjtcGwjIqdoteudoLk39/CyhKTuI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5812d0-d77c-49f7-eeeb-08d6ff0d9a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:52:01.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3400
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a trace event for hardware errors reported by the ARMv8.2
RAS extension registers.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 arch/arm64/kernel/ras.c   |  3 +++
 drivers/acpi/arm64/aest.c |  4 ++++
 include/ras/ras_event.h   | 46 +++++++++++++++++++++++++++++++++++++++++++=
+++
 3 files changed, 53 insertions(+)

diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
index ca47efa..4e34d63 100644
--- a/arch/arm64/kernel/ras.c
+++ b/arch/arm64/kernel/ras.c
@@ -5,6 +5,7 @@
 #include <linux/smp.h>
=20
 #include <asm/ras.h>
+#include <ras/ras_event.h>
=20
 void arch_arm_ras_report_error(void)
 {
@@ -50,6 +51,8 @@ void arch_arm_ras_report_error(void)
 			       regs.err_misc1);
 		}
=20
+		trace_arm_ras_ext_event(0, cpu_num, &regs);
+
 		/*
 		 * In the future, we will treat UER conditions as potentially
 		 * recoverable.
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index fd4f3b5..21ec583 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -13,6 +13,7 @@
 #include <linux/ratelimit.h>
=20
 #include <asm/ras.h>
+#include <ras/ras_event.h>
=20
 #undef pr_fmt
 #define pr_fmt(fmt) "ACPI AEST: " fmt
@@ -102,6 +103,9 @@ static void aest_proc(struct aest_node_data *data)
=20
 		aest_print(data, regs, i);
=20
+		trace_arm_ras_ext_event(data->node_type, data->data.proc.id,
+					&regs);
+
 		if (regs.err_status & ERR_STATUS_UE)
 			fatal =3D true;
=20
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e..8b76cb1 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -339,6 +339,52 @@
 );
=20
 /*
+ * ARM RAS Extension Events Report
+ *
+ * This event is generated when an error reported by the ARM RAS extension
+ * hardware is detected.
+ */
+
+#ifdef CONFIG_ARM64
+#include <asm/ras.h>
+TRACE_EVENT(arm_ras_ext_event,
+
+	TP_PROTO(u8 type, u32 id, struct ras_ext_regs *regs),
+
+	TP_ARGS(type, id, regs),
+
+	TP_STRUCT__entry(
+		__field(u8,  type)
+		__field(u32, id)
+		__field(u64, err_fr)
+		__field(u64, err_ctlr)
+		__field(u64, err_status)
+		__field(u64, err_addr)
+		__field(u64, err_misc0)
+		__field(u64, err_misc1)
+	),
+
+	TP_fast_assign(
+		__entry->type =3D type;
+		__entry->id =3D id;
+		__entry->err_fr =3D regs->err_fr;
+		__entry->err_ctlr =3D regs->err_ctlr;
+		__entry->err_status =3D regs->err_status;
+		__entry->err_addr =3D regs->err_addr;
+		__entry->err_misc0 =3D regs->err_misc0;
+		__entry->err_misc1 =3D regs->err_misc1;
+	),
+
+	TP_printk("type: %d; id: %d; ERR_FR: %llx; ERR_CTLR: %llx; "
+		  "ERR_STATUS: %llx; ERR_ADDR: %llx; ERR_MISC0: %llx; "
+		  "ERR_MISC1: %llx",
+		  __entry->type, __entry->id, __entry->err_fr,
+		  __entry->err_ctlr, __entry->err_status, __entry->err_addr,
+		  __entry->err_misc0, __entry->err_misc1)
+);
+#endif
+
+/*
  * memory-failure recovery action result event
  *
  * unsigned long pfn -	Page Frame Number of the corrupted page
--=20
1.8.3.1

