Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14754E0D51
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfJVUfT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:19 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:26304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388799AbfJVUfS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLLTZ0+CH/Ek7YlKWXhWl31aO5ox/RUqYzmwrgTMic03dK1VgwxSQMXaBYFKl0gjg5aT09nC+eVFZrbLz9j6slls2vPwnR0n3FIZy7pDbXDYq8lFci8KaTtF9r3XdOv9ziLP+aX7t6/PjV/9XYywmske8se5LFY33AHqDnzxwtSB7bx/Kv62zcJkJjKbEn/YuJhEuE7uleaz3Qd9eo7dM5I1F0LKnGGQ8npPkVCTNh2qwjpLuiTNivf2Euv/WhgQwOMZ3Mu1Sv5tneMkc4Gde7QenHVjA0q9Ik2155MmaGzhxO1TttM/siciZxQ+pg1046KZtcB/Uc+bDyf/CaaB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhvSniPJqHhCkbX/6S4WV/74EbWc5MQVRBlQayYM7eo=;
 b=Yf0CfId+baBs5Ibd+QETDzktrIlB2o5mgHXn+pSagOEzOiyMinRf+Z2pJl4YC4bFm2bDOWlq1oMS7YM02qoGl+BBB0FHM2kYKvtgTmUFyKTsnpJe5MnkjJuoMRjyhJBrPKV0ekDGPgFFqpv6VCl36G4fWm+LJtxbqjE/pA38AjJgpYHGLNcrN8q8D6u357ldGvSTyMMva9Y7FtJ9YpuPmEroDBTH6aJzVd1PGAblFZS8y8FKIawUlCbthXWi8bdw9PGCpJj85kYBfhWlRMARFSIMjt1ZdjdBMHf8Q5/4G0EmQxk0VMG1xIJ79eSaNQc+vXxARudYIXoHGmvAitvAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhvSniPJqHhCkbX/6S4WV/74EbWc5MQVRBlQayYM7eo=;
 b=vnu0RBzw3mozl+/0fVlgO9KRsEa8wTq/UqcnuILmCPl0IzsGrLH1xbjBRn2xjK2GZY4VpQzjq8l954l9Z6IMAa/iGXbgnoAzSOjnp3sNL17HhJclp8q6lpTIpMJpkJtYL0F/JV//DHFumEvGhvrzJNjao6kDlEoHpJNMMa48G8o=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:35:14 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:14 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 6/6] EDAC/amd64: Set grain per DIMM
Thread-Topic: [PATCH v2 6/6] EDAC/amd64: Set grain per DIMM
Thread-Index: AQHViRg118VjawBx7USLkrvdKMSY1w==
Date:   Tue, 22 Oct 2019 20:35:14 +0000
Message-ID: <20191022203448.13962-7-Yazen.Ghannam@amd.com>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) To BN7PR12MB2628.namprd12.prod.outlook.com
 (2603:10b6:408:30::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45b51806-4e25-4131-49ec-08d7572f576a
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2724ADF0D12A774D82C9FB19F8680@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(36756003)(54906003)(316002)(2906002)(14444005)(256004)(66066001)(6916009)(52116002)(71200400001)(71190400001)(76176011)(2351001)(2501003)(6116002)(26005)(99286004)(186003)(6512007)(4326008)(6436002)(966005)(1076003)(102836004)(305945005)(5640700003)(7736002)(6486002)(386003)(6506007)(6306002)(14454004)(3846002)(478600001)(2616005)(486006)(476003)(8936002)(66446008)(11346002)(446003)(50226002)(66476007)(81166006)(66556008)(64756008)(8676002)(81156014)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2724;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9swULN8TSv3ssNx4y4InDi9/ysK3jSsCj0c3oJV0GygVHMRfKuvz3dClvKP5BY8ORnZhAFntlKhFl5C/Bh3euOkM0a7xX0S3rN4HxJfUs3X6xt1A0ibthX8Nu5f7n74Q90WTvUFXCKa8a6nax6Ex+yO5tIUUITP78kf/WHASje3E7R+uMupa54uYXPJbIomTkXr/EYGKUqfj5XOwmfvaCvbFx2cV7LRFBmaX29E0bCnzqmIRF1Etgzchq6Qk/opzcWMy/BoDRficmZWWTu5kT30sSGS+PSE1fZF3Dh5ayTaGtBDEzK7DaugO01FXZyBl732pk9ihdaz4pdTXLbvcdMkJdMJzGWHB7XRjbnoBhTBC5DFGSoatH+LAYCJmlNabTBD1/hvpCZfrrLkdPgYYg2iUJWv47vpGhJEHClngtLPqrfFkrEfJ8jKISYyA2A9C5V0qLTKaRQeRG50O1Gw0b9AJ/KWNgGgK8+k159e3WuI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b51806-4e25-4131-49ec-08d7572f576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:14.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xl2GYBZEpunrLh/nujQtmjSxtXhVk6FzBUOMYDXCcTegSf6pXIZHqcPdBN7iG/ckpGcoqwVKbsKE3gN5d9LjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The following commit introduced a warning on error reports without a
non-zero grain value.

  3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")

The amd64_edac_mod module does not provide a value, so the warning will
be given on the first reported memory error.

Set the grain per DIMM to cacheline size (64 bytes). This is the current
recommendation.

Fixes: 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191018153114.39378-7-Yazen.Ghannam@amd.com

v1 -> v2:
* No change.

rfc -> v1:
* New patch.

 drivers/edac/amd64_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 114e7395daab..4ab7bcdede51 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2944,6 +2944,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			dimm->mtype =3D pvt->dram_type;
 			dimm->edac_mode =3D edac_mode;
 			dimm->dtype =3D dev_type;
+			dimm->grain =3D 64;
 		}
 	}
=20
@@ -3020,6 +3021,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 			dimm =3D csrow->channels[j]->dimm;
 			dimm->mtype =3D pvt->dram_type;
 			dimm->edac_mode =3D edac_mode;
+			dimm->grain =3D 64;
 		}
 	}
=20
--=20
2.17.1

