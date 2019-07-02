Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C284F5D4CF
	for <lists+linux-edac@lfdr.de>; Tue,  2 Jul 2019 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGBQwT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Jul 2019 12:52:19 -0400
Received: from mail-eopbgr770114.outbound.protection.outlook.com ([40.107.77.114]:16353
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbfGBQwS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Jul 2019 12:52:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Lq6DQOJ1X34liMPc/J7LKHl+VhFbP0QIJXF1C09biBUEQ79XJwZ8yIoRu1lMvQUKsFK8OeGlqT8x0b+Pmmf4an0N9JgJZ+RPiii40NsQygBB+93N9vux//efz3gV+z1UYLRuefB27HUdfpg/XyNfyLmlkd/Uca2tPNOkVEtT7t8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjcnB1NmeWvXESms3IZxiu5T7o6Vs49AzKWKSSKsgfI=;
 b=i1JsPIZyIz9btdl4T3VzSqZ/uaTTdXeUpYGhs+fI29sN76FY5jQ/xJJIGSocbP8ZFK57wpKW3KD23ruz36uDDhcnDAJeNMVeEsRxKXx47KEL0+oQI4zJqZzbyxR0L2T4E4irgks7WYBTDjUq9tAY3umBrevXg6KP+Kvdbyx2wC8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjcnB1NmeWvXESms3IZxiu5T7o6Vs49AzKWKSSKsgfI=;
 b=bfnF9p0AnJ2dYJJn8iDTDYS2l4lW5sZ3pjHlJZbzhgXOgXVQTPh+c7KeOOCUI/N1XiH62vADegxxaem079/Sbyo4gw/BzlStsSKg8i3P4Qaqd+7lMfWwy2vvph0adbGtfVkmMAUG7IzuQzb/rJGPLHKkIou72B6dV7Zx/M4d69Y=
Received: from DM5PR0102MB3383.prod.exchangelabs.com (52.132.128.150) by
 DM5PR0102MB3413.prod.exchangelabs.com (52.132.129.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 2 Jul 2019 16:51:33 +0000
Received: from DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce]) by DM5PR0102MB3383.prod.exchangelabs.com
 ([fe80::2560:7ba6:c491:dcce%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:51:33 +0000
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
Subject: [PATCH RFC 0/4] ARM Error Source Table Support
Thread-Topic: [PATCH RFC 0/4] ARM Error Source Table Support
Thread-Index: AQHVMPZnLm2MGmSII0qkVo2bsW5EMA==
Date:   Tue, 2 Jul 2019 16:51:32 +0000
Message-ID: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
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
x-ms-office365-filtering-correlation-id: c28408ce-32ce-476a-094f-08d6ff0d8973
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0102MB3413;
x-ms-traffictypediagnostic: DM5PR0102MB3413:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR0102MB3413EECB5A773E6164CE503EE3F80@DM5PR0102MB3413.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(199004)(189003)(25786009)(2906002)(14454004)(6512007)(6306002)(4720700003)(81156014)(81166006)(6436002)(478600001)(6486002)(386003)(6506007)(8936002)(2201001)(7416002)(8676002)(186003)(102836004)(107886003)(52116002)(86362001)(966005)(26005)(7736002)(99286004)(53936002)(305945005)(3846002)(6116002)(66446008)(73956011)(66946007)(66476007)(66556008)(64756008)(50226002)(14444005)(256004)(2501003)(110136005)(316002)(486006)(476003)(2616005)(66066001)(71200400001)(71190400001)(4326008)(68736007)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3413;H:DM5PR0102MB3383.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:3;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMLO3t5GAP6lnw0dVcyzVjI7HmYQgpUWrFMp15/1FoXm0kcPQ5YvT2nfpRnXWyWYfDixvqhk4MlLrrlqhTumYl+vW0oye/g/za1prvJiM2EpEwe3n2Q8B6H+EGQSc8dNEbySGajaH074ZpnfeYxMJ/JkkQ/+FaAgh+e8cB5uygwvn0VtNmqI7LEA/Ft2F5RQnJlmR1YlJdyloMgZyMe4i0ZlPfTMVZvNIhTewfyqyLR8I4ecKpWTCYEIKX0AwX8xXyuLmORs66lXGzXgQ6NsnvR3B64lWoF2rccUeQ7AatfxR6qzE0WTXIaWpbw+KQWFAkAj6mXHh6ilUkFRCrkKz/n3YJHTycSGcaiY+TEx/TwJxbtsNzHpvk/uLDg28lUKIUlHg2mvTuFfvYv5Izdg4aGf5CbODZNpXPFE3ZOk4q4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28408ce-32ce-476a-094f-08d6ff0d8973
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:51:32.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3413
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series adds support for the ARM Error Source Table (AEST) based on
the latest version of the AEST from ARM [0].

The AEST driver supports both memory mapped and system register interfaces.
This series assumes system register interfaces are only registered with
private peripheral interrupts (PPIs); otherwise there is no guarantee the
core handling the error is the core which took the error and has the
syndrome info in it's system registers.

SEAs and SEIs could also have syndrome information present in the RAS
extension system registers. That handling is tied into the system register
handling code.

This is meant to be initial support for AEST to address the current gaps
with systems that support ARMv8.2 RAS extensions but don't have
firmware-first support. This series simply logs all the errors it finds
and triggers a kernel panic if there is an UE present.

Future work:
- UER handling to avoid panic
- Looping through all external abort capable (ERR<n>FR.UE !=3D 0) error
   nodes in SEA/SEI handling
- ARMv8.4 extension support

[0] https://static.docs.arm.com/den0085/a/DEN0085_RAS_ACPI_1.0_BETA_1.pdf

Tyler Baicar (4):
  ACPI/AEST: Initial AEST driver
  arm64: mm: Add RAS extension system register check to SEA handling
  arm64: traps: Add RAS extension system register check to serror
    handling
  trace, ras: add ARM RAS extension trace event

 arch/arm64/include/asm/ras.h |  41 +++++
 arch/arm64/kernel/Makefile   |   2 +-
 arch/arm64/kernel/ras.c      |  70 +++++++++
 arch/arm64/kernel/traps.c    |   3 +
 arch/arm64/mm/fault.c        |   3 +
 drivers/acpi/arm64/Kconfig   |   3 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 366 +++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/acpi_aest.h    |  94 +++++++++++
 include/ras/ras_event.h      |  46 ++++++
 10 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

--=20
1.8.3.1

