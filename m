Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE555D4C3
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jul 2019 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGBQvu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jul 2019 12:51:50 -0400
Received: from mail-eopbgr760109.outbound.protection.outlook.com ([40.107.76.109]:20740
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbfGBQvt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jul 2019 12:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtEYUOtGSv8f55cEudsoytvYsi3P9/+3yLDVgwYgZcs=;
 b=kQajZsCCu627at//1Vl0nNGCdpAVH8s8NDK9RctwWSCihhj85+2J3wlvFPQiDY0mthGtt1rK/JOQQzRuRwnHE2kf92qGlogvwygwv/N6U4FDQEoWVlOvxZjhSCQD5hQQMGyYYW9JmWREOH5S9WqPZNG8OXB7RBXU+H9up8KeuT8=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3512.prod.exchangelabs.com (52.132.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 16:51:46 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:51:46 +0000
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
Subject: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register check to
 SEA handling
Thread-Topic: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register
 check to SEA handling
Thread-Index: AQHVMPZvV84yhcAYOk+DNBn1Cdw2Cw==
Date:   Tue, 2 Jul 2019 16:51:46 +0000
Message-ID: <1562086280-5351-3-git-send-email-baicar@os.amperecomputing.com>
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
x-ms-office365-filtering-correlation-id: 5997e82f-6f75-43cc-f515-08d6ff0d90bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3512;
x-ms-traffictypediagnostic: DM5PR0102MB3512:
x-microsoft-antispam-prvs: <DM5PR0102MB3512CA876431E1BFF3389F3EE3F80@DM5PR0102MB3512.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(66066001)(7736002)(4326008)(305945005)(5660300002)(4720700003)(50226002)(2501003)(68736007)(8936002)(71200400001)(316002)(478600001)(110136005)(71190400001)(25786009)(8676002)(81156014)(81166006)(52116002)(446003)(76176011)(476003)(2616005)(7416002)(102836004)(2906002)(6506007)(386003)(11346002)(6116002)(26005)(66556008)(64756008)(14454004)(66476007)(73956011)(99286004)(66946007)(4744005)(86362001)(186003)(256004)(3846002)(66446008)(6512007)(107886003)(6486002)(53936002)(2201001)(486006)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3512;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jraWrkV5mUw3bMoAHsqlIUmw1SmGq4rtEse1ISYiFMtBMB7vpMZ3JUxCztDEhSytq7Qxkfg+Rj+3OCqehRAEQ2dcDU3l52M+Bt8XKB/+LJbeqSC3yH/GgaWBMGqdXJhI7P2yQ8yjr5LooZdAW9Tghv2e1NOemBLmMyCQyVuqIW0UA51dQDR7sdYUVFdqB/koQD08aFM8ADTIrh0umliVH1Xf7rFiVS2+CaFa6uqBfVsPGyjSlICdGbyTha0kaoycFAc6lQTkWQPKxT2cXyndZ8DsFkJqgpaldWX49lnv039JEnJHERXdkDGrO8ioH9oaHLRa5GEgOO2jHrCOJHy6EIwCVBxSEvUHu8STuNDpNjkHj8zUeKVW1Sg7eMnHoFE7cmc3pyur0kVZ//A3TjcNqi5hyb2G5rM0apEfMq+KOfo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5997e82f-6f75-43cc-f515-08d6ff0d90bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:51:46.4130
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

On systems that support the ARM RAS extension, synchronous external
abort syndrome information could be captured in the core's RAS extension
system registers. So, when handling SEAs check the RAS system registers
for error syndrome information.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2d11501..76b42ca 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,6 +37,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
+#include <asm/ras.h>
=20
 struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr,
@@ -632,6 +633,8 @@ static int do_sea(unsigned long addr, unsigned int esr,=
 struct pt_regs *regs)
=20
 	inf =3D esr_to_fault_info(esr);
=20
+	arch_arm_ras_report_error();
+
 	/*
 	 * Return value ignored as we rely on signal merging.
 	 * Future patches will make this more robust.
--=20
1.8.3.1

