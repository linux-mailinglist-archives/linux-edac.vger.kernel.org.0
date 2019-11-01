Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31390EC4FA
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 15:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKAOsU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 10:48:20 -0400
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:63947
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfKAOsU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 1 Nov 2019 10:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4doFGIni7z3pjPP0N+Y1JTVwqjHX1T0JcoV7qHHlnZLl0O3zryxecKbZx4On2homIFum7/GP+2isnW9acAQQxtMXFyBku6bCM3Yw0dhyQyrzb2edrP9euicBtMCXrGfZX6VSfDQJFWXV+azBSkqn31ZNf7kv/OWAl1lTfd0BV0xCGXoC1WF5JIlFgiAhTvCkMt1edcNJutvu/B6LCRF8UWv1HSOCLLaW3bEQjczMlNVgqno0pRdC+ONt0I6Cua61UO/qGSBVg83yoNolS2m+M7oi+9CNmP7w0fRCNDwWwLorwjNjaPQcFprRb8vAz5JERWDaogWKkmW+3GFhes6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqHd+YOfZTp2r6XDt9BYLCe2BIW4J5yf0lPYPS+p/hQ=;
 b=e7C3rYs2Z8OzUas+XjpIEQYb/ILhG1CjiT43wHv8QBCxp0IAVjmFf6ykOOyqG2YF2rwTSteS6Qpf5blbsdqKavVsqUf7Xv49/5+LCZnGh79uZTlU/vx4npyVUf2+sHIG7fIRMfLZvI4UmgtvM5tikNRpeoHBCOFH8fsiqwBnZfYUJp6b2SC90V4+/L+vWQ/k6+ROGlhmKo/LFLQSOUmuzgY2QGFcIgn3a36r0EHId7x4i3gkuaUnIKySkO65JLize+pdhqcF7pbFI5fNBy6u6aEj/Ar1Y1qlR/hqMHbkHAtomUyQmf5amiSA6mff1ELi8G7bmskzFcSjX7b+HB+dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqHd+YOfZTp2r6XDt9BYLCe2BIW4J5yf0lPYPS+p/hQ=;
 b=CF8KT+6l4O2uWI2o0DBHArNh1OCFOzuuBHifg5YOG/CmiI1u/eM2zmfWX7EKWDNJtCb8a1nOxOS6op82r1fivcaMjCeDfoledtogu29dKVBpUk6jiyj8lvP18bIEw3W2mR63dqXQNyf4M6wFyqylhz+zVbbrp6i9RRZJhGCgtJw=
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
Subject: [PATCH 1/2] rasdaemon: rename CPU_NAPLES cputype
Thread-Topic: [PATCH 1/2] rasdaemon: rename CPU_NAPLES cputype
Thread-Index: AQHVkMNjBiL1UOYkaEiuuemWO+sISA==
Date:   Fri, 1 Nov 2019 14:48:13 +0000
Message-ID: <20191101144800.20803-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 4b80af6f-ca23-4514-f181-08d75eda85c5
x-ms-traffictypediagnostic: BYAPR12MB3525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35250DB82C9AD2491355CDD3F8620@BYAPR12MB3525.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(14454004)(4326008)(486006)(2906002)(76176011)(25786009)(26005)(305945005)(66946007)(64756008)(476003)(6512007)(446003)(186003)(11346002)(7736002)(2501003)(66556008)(66446008)(2616005)(66066001)(6116002)(66476007)(8676002)(8936002)(36756003)(1076003)(3846002)(478600001)(71190400001)(316002)(6436002)(5660300002)(81156014)(99286004)(6916009)(6486002)(2351001)(256004)(102836004)(50226002)(54906003)(5640700003)(6506007)(14444005)(52116002)(86362001)(386003)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3525;H:BYAPR12MB2630.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNh1SRP9VrBfzM0vFFAyJgWhFZfnsra/CSWvVZxscdalTtrgWTHechTb0J9kU8u7rDJAyNOQEMbs2dSLeOz2it0edR4IGS1iuIEI7+vNz1qWZugcR5YpF7OVIW9ytBFJcpKdoBZ6IbzE2HyAhoJ+E6kuhr2A/75umvaIIKW//jX6HyX3viLs7YSJycfLGqHBZpe78I25JAoUJJkuZnZUdqZI3FuCW+mzcX6tpkme9haclFowe4MokFLGcgQcWUf3Vm460MQSp397RUJUbj1xqJ6MPkx9QUdqe83q07oQBLKZxtGdIAy7/fjaAH3Wmx4Ioht2/IBp5OmOAaIK+A6VHth0luROpcsBKPIVHbPEQ4ubkSiU7I9CxT1VIZhIRYByxJjk2Jdp/jssTs/FASbvlLMXwbuzenL4FBtxibwPCPE+38AKR6yct4p53wh1r4ex
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80af6f-ca23-4514-f181-08d75eda85c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 14:48:13.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaX/RjWOFwGk9WsoOFnTcza5q3fF47k/RCTCGAOsd0myOe7Sw2jLjHmMErfQAtv7LkG4W+jvnujP3p2kJIeBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Brian Woods <brian.woods@amd.com>

Change CPU_NAPLES to CPU_AMD_SMCA to reflect that it isn't just NAPLES
that is supported, but AMD's Scalable Machine Check Architecture (SMCA).

  [ Yazen: change family check to feature check, and change CPU name. ]

Signed-off-by: Brian Woods <brian.woods@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Chandu-babu Namburu <chandu@amd.com>
---
 ras-mce-handler.c | 10 ++++++----
 ras-mce-handler.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/ras-mce-handler.c b/ras-mce-handler.c
index fd3ef3b..016acae 100644
--- a/ras-mce-handler.c
+++ b/ras-mce-handler.c
@@ -55,7 +55,7 @@ static char *cputype_name[] =3D {
 	[CPU_KNIGHTS_LANDING] =3D "Knights Landing",
 	[CPU_KNIGHTS_MILL] =3D "Knights Mill",
 	[CPU_SKYLAKE_XEON] =3D "Skylake server",
-	[CPU_NAPLES] =3D "AMD Family 17h Zen1",
+	[CPU_AMD_SMCA] =3D "AMD Scalable MCA",
 	[CPU_DHYANA] =3D "Hygon Family 18h Moksha"
 };
=20
@@ -192,8 +192,10 @@ static int detect_cpu(struct ras_events *ras)
 	if (!strcmp(mce->vendor, "AuthenticAMD")) {
 		if (mce->family =3D=3D 15)
 			mce->cputype =3D CPU_K8;
-		if (mce->family =3D=3D 23)
-			mce->cputype =3D CPU_NAPLES;
+		if (strstr(mce->processor_flags, "smca")) {
+			mce->cputype =3D CPU_AMD_SMCA;
+			goto ret;
+		}
 		if (mce->family > 23) {
 			log(ALL, LOG_INFO,
 			    "Can't parse MCE for this AMD CPU yet %d\n",
@@ -441,7 +443,7 @@ int ras_mce_event_handler(struct trace_seq *s,
 	case CPU_K8:
 		rc =3D parse_amd_k8_event(ras, &e);
 		break;
-	case CPU_NAPLES:
+	case CPU_AMD_SMCA:
 	case CPU_DHYANA:
 		rc =3D parse_amd_smca_event(ras, &e);
 		break;
diff --git a/ras-mce-handler.h b/ras-mce-handler.h
index 94395eb..1ef7ef2 100644
--- a/ras-mce-handler.h
+++ b/ras-mce-handler.h
@@ -50,7 +50,7 @@ enum cputype {
 	CPU_KNIGHTS_LANDING,
 	CPU_KNIGHTS_MILL,
 	CPU_SKYLAKE_XEON,
-	CPU_NAPLES,
+	CPU_AMD_SMCA,
 	CPU_DHYANA,
 };
=20
--=20
2.17.1

