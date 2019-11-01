Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA6EC4FB
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKAOsY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 10:48:24 -0400
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:63947
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfKAOsY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 1 Nov 2019 10:48:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDGE30oy9/RySSoQPFJ6hDobDeYS05KWHbVD6W6XZZG8UpA3PpoiZtx2s2qD4yBKii+/ffRSw+cKi6XqbekwC0RZe8w0amhbTlCo/ogHTQ4BpwLNgl4vcT4qzqqmkFcd3l2yyyF0FMr2nTUCpooaWpk2PcOLEetFrmixaG4Ujn/IzvEe1lSsu0iFqb2QGYcjJs9YI2KrDUBoO4JCusChqdtaF6Yp1LS+LjHqnrp9TSXXSRGsL8knD0pgUVthmLRC+3HFTzyenyvyh2dhSj4WAIG36rofaOYvj9BFcSG4swSv0iWInKsa6WW5X26VtBX0q24gugODcEtDH7rB7UnsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIxWa+uKf2VySCdzPeyAqeNKm8ahQFeH9kGupsgoYsM=;
 b=eN1kXicWJjSOKTKO4lb1Av00lPNiK7VMxV7TonAHH+IcE7xk7priz/6SXnM9WE/YRwDN/V1758+fovpQyWnSwPoUzjjMPlJmtH0ZCuSMtsG3ZZDRZzWsgbl1cstVN3KBvzljb7ZQ9JUaLkzVXwUcXB2yI9erbp2sUHayWUpJ7nTWN6WOBnbdaCiircu9JkqTX8M0Yspv9+u1zzWyb/Pf9wP3Vw5o7eYmcf7SLUyGK32yrIYn8yC2G3Xn7kZBsxlViiuOFXHc7PbeO7D2nBLfFd2nUg+kiml3zosVYwWvkyc1OVQ1tQud/RJonuTAlBXrJVL2AgfkewFmGGkyFiwc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIxWa+uKf2VySCdzPeyAqeNKm8ahQFeH9kGupsgoYsM=;
 b=AEDtutbTjtHmcfXQjKiXppMQ/Q9bUQ7xjROVEjqmW2mR4x2pN7+8alELbBGLIuY6KVN+K6Yk9yJvozdAOsSnVGwiBUPwuZ0WHw67iQP3W2t0403ZeZEgCrKn6joiCjpgOcXYJ/YqZmuo74PUBdBuyAt2extzZ89kX+0aki9VeHU=
Received: from BYAPR12MB2630.namprd12.prod.outlook.com (20.177.124.91) by
 BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 14:48:14 +0000
Received: from BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528]) by BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 14:48:14 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "Namburu, Chandu-babu" <chandu@amd.com>
Subject: [PATCH 2/2] rasdaemon: add support for new AMD SMCA bank types
Thread-Topic: [PATCH 2/2] rasdaemon: add support for new AMD SMCA bank types
Thread-Index: AQHVkMNjf8c1dAPp/U+5x7jp5D/4Lw==
Date:   Fri, 1 Nov 2019 14:48:14 +0000
Message-ID: <20191101144800.20803-3-Yazen.Ghannam@amd.com>
References: <20191101144800.20803-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191101144800.20803-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0017.prod.exchangelabs.com (2603:10b6:805:1::30)
 To BYAPR12MB2630.namprd12.prod.outlook.com (2603:10b6:a03:67::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21206d39-5673-4cad-f1b0-08d75eda863f
x-ms-traffictypediagnostic: BYAPR12MB3525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35254D24D58A14A0EA678D75F8620@BYAPR12MB3525.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(14454004)(4326008)(486006)(2906002)(76176011)(25786009)(26005)(305945005)(66946007)(64756008)(476003)(6512007)(446003)(186003)(15650500001)(11346002)(7736002)(2501003)(66556008)(66446008)(2616005)(66066001)(6116002)(66476007)(8676002)(8936002)(36756003)(1076003)(3846002)(478600001)(71190400001)(316002)(6436002)(5660300002)(81156014)(99286004)(6916009)(6486002)(2351001)(256004)(102836004)(50226002)(54906003)(5640700003)(6506007)(14444005)(52116002)(86362001)(386003)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3525;H:BYAPR12MB2630.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s4I4D+EtQjxYeF/8QL55vKO7I7ZUn/CCuBxlcu0UPw+2Y5aQFkAl9CJCcxH0CpfzqxxTCcyRsCGov2NzM0o1HoRe/6hgzh1KMrdKbzj/4CIhHNpjQynr48lAHVIvSxJUbTd5jd7fg5vfP0/e870loAejRylgX4lGDeVSbQm8Ch0fZg7P5At+LZ3hglYJZT8jbdeRO1O3npwuxl3798jXSRKcFT+4FrgVz6d5e/OQcnMcSOlGcDlN36M4IrvVeidTQdQ0zEypHwmjl+m1Q7gRsDh4xDS9mBcqsV8mMm4leJaCbKWUcEiOu6Ufi2oZZbzxwFzQSOnP5yHJIkwEqdUk4qBdJx3vgjSCJwu8eFrLOr97bJjKojjcxu5TcQCcu95Xnw9rFJKtxKomSdZAFfmJ2N1JCwMfBcIBqNDNQ5LK0RUp29Pxnc6xJU/SeRxaMmUv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21206d39-5673-4cad-f1b0-08d75eda863f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 14:48:14.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7oMt2sY4DL9Lybb82MlHGJhSgJlhBnQjnF8Yu7NpqKqxK49q/UY5QLKGDrOhCgmLALNsowNRO6i3Cim0dq0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Brian Woods <brian.woods@amd.com>

Going forward, the Scalable Machine Check Architecture (SMCA) has some
updated and additional bank types which show up in Zen2.  The differing
bank types include: CS_V2, PSP_V2, SMU_V2, MP5, NBIO, and PCIE.  The V2
bank types replace the original bank types but have unique HWID/MCAtype
IDs from the originals so there's no conflicts between different
versions or other bank types.  All of the differing bank types have new
MCE descriptions which have been added as well.

Signed-off-by: Brian Woods <brian.woods@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Chandu-babu Namburu <chandu@amd.com>
---
 mce-amd-smca.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 6c3e8a5..114e786 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -49,11 +49,17 @@ enum smca_bank_types {
 	SMCA_FP,        /* Floating Point */
 	SMCA_L3_CACHE,  /* L3 Cache */
 	SMCA_CS,        /* Coherent Slave */
+	SMCA_CS_V2,     /* Coherent Slave V2 */
 	SMCA_PIE,       /* Power, Interrupts, etc. */
 	SMCA_UMC,       /* Unified Memory Controller */
 	SMCA_PB,        /* Parameter Block */
 	SMCA_PSP,       /* Platform Security Processor */
+	SMCA_PSP_V2,    /* Platform Security Processor V2 */
 	SMCA_SMU,       /* System Management Unit */
+	SMCA_SMU_V2,    /* System Management Unit V2 */
+	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_NBIO,	/* Northbridge IO Unit */
+	SMCA_PCIE,	/* PCI Express Unit */
 	N_SMCA_BANK_TYPES
 };
=20
@@ -165,6 +171,23 @@ static const char * const smca_cs_mce_desc[] =3D {
 	"Atomic request parity",
 	"ECC error on probe filter access",
 };
+/* Coherent Slave Unit V2 */
+static const char * const smca_cs2_mce_desc[] =3D {
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"SDP read response had no match in the CS queue",
+	"Probe Filter Protocol Error",
+	"Probe Filter ECC Error",
+	"SDP read response had an unexpected RETRY error",
+	"Counter overflow error",
+	"Counter underflow error",
+};
 /* Power, Interrupt, etc.. */
 static const char * const smca_pie_mce_desc[] =3D {
 	"HW assert",
@@ -189,10 +212,75 @@ static const char * const smca_pb_mce_desc[] =3D {
 static const char * const smca_psp_mce_desc[] =3D {
 	"PSP RAM ECC or parity error",
 };
+/* Platform Security Processor V2 */
+static const char * const smca_psp2_mce_desc[] =3D {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Instruction Cache Bank 0 ECC or parity error",
+	"Instruction Cache Bank 1 ECC or parity error",
+	"Instruction Tag Ram 0 parity error",
+	"Instruction Tag Ram 1 parity error",
+	"Data Cache Bank 0 ECC or parity error",
+	"Data Cache Bank 1 ECC or parity error",
+	"Data Cache Bank 2 ECC or parity error",
+	"Data Cache Bank 3 ECC or parity error",
+	"Data Tag Bank 0 parity error",
+	"Data Tag Bank 1 parity error",
+	"Data Tag Bank 2 parity error",
+	"Data Tag Bank 3 parity error",
+	"Dirty Data Ram parity error",
+	"TLB Bank 0 parity error",
+	"TLB Bank 1 parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
 /* System Management Unit */
 static const char * const smca_smu_mce_desc[] =3D {
 	"SMU RAM ECC or parity error",
 };
+/* System Management Unit V2 */
+static const char * const smca_smu2_mce_desc[] =3D {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
+/* Microprocessor 5 Unit */
+static const char * const smca_mp5_mce_desc[] =3D {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+};
+/* Northbridge IO Unit */
+static const char * const smca_nbio_mce_desc[] =3D {
+	"ECC or Parity error",
+	"PCIE error",
+	"SDP ErrEvent error",
+	"SDP Egress Poison Error",
+	"IOHC Internal Poison Error",
+};
+/* PCI Express Unit */
+static const char * const smca_pcie_mce_desc[] =3D {
+	"CCIX PER Message logging",
+	"CCIX Read Response with Status: Non-Data Error",
+	"CCIX Write Response with Status: Non-Data Error",
+	"CCIX Read Response with Status: Data Error",
+	"CCIX Non-okay write response with data error",
+};
+
=20
 struct smca_mce_desc {
 	const char * const *descs;
@@ -208,11 +296,17 @@ static struct smca_mce_desc smca_mce_descs[] =3D {
 	[SMCA_FP]       =3D { smca_fp_mce_desc,   ARRAY_SIZE(smca_fp_mce_desc)  }=
,
 	[SMCA_L3_CACHE] =3D { smca_l3_mce_desc,   ARRAY_SIZE(smca_l3_mce_desc)  }=
,
 	[SMCA_CS]       =3D { smca_cs_mce_desc,   ARRAY_SIZE(smca_cs_mce_desc)  }=
,
+	[SMCA_CS_V2]    =3D { smca_cs2_mce_desc,  ARRAY_SIZE(smca_cs2_mce_desc) }=
,
 	[SMCA_PIE]      =3D { smca_pie_mce_desc,  ARRAY_SIZE(smca_pie_mce_desc) }=
,
 	[SMCA_UMC]      =3D { smca_umc_mce_desc,  ARRAY_SIZE(smca_umc_mce_desc) }=
,
 	[SMCA_PB]       =3D { smca_pb_mce_desc,   ARRAY_SIZE(smca_pb_mce_desc)  }=
,
 	[SMCA_PSP]      =3D { smca_psp_mce_desc,  ARRAY_SIZE(smca_psp_mce_desc) }=
,
+	[SMCA_PSP_V2]   =3D { smca_psp2_mce_desc, ARRAY_SIZE(smca_psp2_mce_desc)}=
,
 	[SMCA_SMU]      =3D { smca_smu_mce_desc,  ARRAY_SIZE(smca_smu_mce_desc) }=
,
+	[SMCA_SMU_V2]   =3D { smca_smu2_mce_desc, ARRAY_SIZE(smca_smu2_mce_desc)}=
,
+	[SMCA_MP5]      =3D { smca_mp5_mce_desc,  ARRAY_SIZE(smca_mp5_mce_desc) }=
,
+	[SMCA_NBIO]     =3D { smca_nbio_mce_desc, ARRAY_SIZE(smca_nbio_mce_desc)}=
,
+	[SMCA_PCIE]     =3D { smca_pcie_mce_desc, ARRAY_SIZE(smca_pcie_mce_desc)}=
,
 };
=20
 struct smca_hwid {
@@ -235,6 +329,7 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
=20
 	/* Data Fabric MCA types */
 	{ SMCA_CS,       0x0000002E },
+	{ SMCA_CS_V2,    0x0002002E },
 	{ SMCA_PIE,      0x0001002E },
=20
 	/* Unified Memory Controller MCA type */
@@ -245,9 +340,20 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
=20
 	/* Platform Security Processor MCA type */
 	{ SMCA_PSP,      0x000000FF },
+	{ SMCA_PSP_V2,   0x000100FF },
=20
 	/* System Management Unit MCA type */
 	{ SMCA_SMU,      0x00000001 },
+	{ SMCA_SMU_V2,   0x00010001 },
+
+	/* Microprocessor 5 Unit MCA type */
+	{ SMCA_MP5,      0x00020001 },
+
+	/* Northbridge IO Unit MCA type */
+	{ SMCA_NBIO,     0x00000018 },
+
+	/* PCI Express Unit MCA type */
+	{ SMCA_PCIE,     0x00000046 },
 };
=20
 struct smca_bank_name {
@@ -264,11 +370,17 @@ static struct smca_bank_name smca_names[] =3D {
 	[SMCA_FP]       =3D { "Floating Point Unit" },
 	[SMCA_L3_CACHE] =3D { "L3 Cache" },
 	[SMCA_CS]       =3D { "Coherent Slave" },
+	[SMCA_CS_V2]    =3D { "Coherent Slave" },
 	[SMCA_PIE]      =3D { "Power, Interrupts, etc." },
 	[SMCA_UMC]      =3D { "Unified Memory Controller" },
 	[SMCA_PB]       =3D { "Parameter Block" },
 	[SMCA_PSP]      =3D { "Platform Security Processor" },
+	[SMCA_PSP_V2]   =3D { "Platform Security Processor" },
 	[SMCA_SMU]      =3D { "System Management Unit" },
+	[SMCA_SMU_V2]   =3D { "System Management Unit" },
+	[SMCA_MP5]	=3D { "Microprocessor 5 Unit" },
+	[SMCA_NBIO]     =3D { "Northbridge IO Unit" },
+	[SMCA_PCIE]     =3D { "PCI Express Unit" },
 };
=20
 static void amd_decode_errcode(struct mce_event *e)
--=20
2.17.1

