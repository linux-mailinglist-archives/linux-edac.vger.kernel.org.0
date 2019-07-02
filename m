Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4F5D4C6
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jul 2019 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfGBQvz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jul 2019 12:51:55 -0400
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:49121
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbfGBQvy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jul 2019 12:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF3BDo9/3CtRiAthY8Y0UycadqCCEQ2SNONIBEqHtZM=;
 b=dsHYseL0bGWiHUnP1uXoitVeWwvu0Uf9g5H1VlZxBhuo7rApOgD6dyMqrPtZrTPXSauJQxOtAbj2X0Qd5Cp8hfiRqbw6Zr7ASE0HJHH28bCf6f102Be6WzM5piWUU15W8zG0BRqqCONvMhWZIC7KxH9GFcHwGzLkmsoydG1j2CI=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3512.prod.exchangelabs.com (52.132.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 16:51:52 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:51:52 +0000
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
Subject: [PATCH RFC 3/4] arm64: traps: Add RAS extension system register check
 to serror handling
Thread-Topic: [PATCH RFC 3/4] arm64: traps: Add RAS extension system register
 check to serror handling
Thread-Index: AQHVMPZy1UDTiwq0z0aOZ9tm5apxwg==
Date:   Tue, 2 Jul 2019 16:51:52 +0000
Message-ID: <1562086280-5351-4-git-send-email-baicar@os.amperecomputing.com>
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
x-ms-office365-filtering-correlation-id: 4fa0088b-3f99-480b-56d9-08d6ff0d9509
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3512;
x-ms-traffictypediagnostic: DM5PR0102MB3512:
x-microsoft-antispam-prvs: <DM5PR0102MB3512F57D4CE6D516E63772B9E3F80@DM5PR0102MB3512.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(66066001)(7736002)(4326008)(305945005)(5660300002)(4720700003)(50226002)(2501003)(68736007)(8936002)(71200400001)(316002)(478600001)(110136005)(71190400001)(25786009)(8676002)(81156014)(81166006)(52116002)(446003)(76176011)(476003)(2616005)(7416002)(102836004)(2906002)(6506007)(386003)(11346002)(6116002)(26005)(66556008)(64756008)(14454004)(66476007)(73956011)(99286004)(66946007)(4744005)(86362001)(186003)(256004)(3846002)(66446008)(6512007)(107886003)(6486002)(53936002)(2201001)(486006)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3512;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oiB6G9sLC0WOo8cTb4+RQI17+RT7LZ7DiZpu4cufNN17UkQE5sY7I+KPzDrDK+VS3shvLbq2g6gxWQt6BKe+ZkS/kZW8PdJ8OHMqQAZdTi1CFI5Gj3u6W9aMaSvuPuJb5j1dVpE57Kefpy/G3zn3nPkUn799RU5PUdU5y+/c1Yexiy824zDYsHjb+CMKLjyPWSb1opY8ny+EF62F9dHwTs71Ob0aBZPgFpBLdOeccztsfw1M/Es3iMLMnL1YXH6tCSo1Hgk+SI5DCFmOSCDbFWS9RKX+9fEWKwDmvzlczDsRVNiXDEpg5xj4PZsP+5pDIXeJMzKHCH7TtMqsoZCobyb0iGGzwOExzb3/uKAGYDzp21/e0Pf1bYWQx/j3mvqAGcWuPMR2PYTIZkGF7Ytpx/5j3eBuvvdG82Zl8oGIQd0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0088b-3f99-480b-56d9-08d6ff0d9509
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:51:52.2777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3512
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On systems that support the ARM RAS extension, serror interrupt syndrome
information could be captured in the core's RAS extension system
registers. When handling serrors, check the RAS system registers for
error syndrome information.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 arch/arm64/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 985721a..aacfa51 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -40,6 +40,7 @@
 #include <asm/exception.h>
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
+#include <asm/ras.h>
=20
 static const char *handler[]=3D {
 	"Synchronous Abort",
@@ -897,6 +898,8 @@ asmlinkage void do_serror(struct pt_regs *regs, unsigne=
d int esr)
 	if (!was_in_nmi)
 		nmi_enter();
=20
+	arch_arm_ras_report_error();
+
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
--=20
1.8.3.1

