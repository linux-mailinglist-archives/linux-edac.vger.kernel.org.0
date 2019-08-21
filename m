Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25B9883B
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfHVAAS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:18 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730943AbfHVAAA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBdUYacoBWFRsXn+Venj1kVcZw+7azvjatI3bdfdyQJvrayR4fDDikpj6zPwkFMo2vaIpvbwKfwOM+3ZwRiACdAO5/GgsCr7XANDPYJ1vTvJZFY0gJQOUQK/4HttOZUPHUgvnm9wcv/cxb8Cn/E+sUwITV1VREeAI45D74PzUgLRApFIdHn08VsCmOkYiAQ70MGcu0tP7z1Ep4YyPGMuLjHG/S6SQvqe+cGMKH8rM2NIcdNnPxwBK/YmLLV2mfRpMIwsVsj+cqBCY7U+Wd+ECp6XlBsjyEjm+zrYrD9WmjDYNg8l2bwwOTd3enU51+0qNo3uVVfVu9Qj78Tw0OD5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqhXtiykNaXOAbhPBcFcpdDpboHhyOgcyvcqs5Y4MPg=;
 b=GpOY0apaQQKzMBQNzFL+JAyL9I7K+bk81E91GMfxdlbceXcBBKBHGVZAy1GUyBgps935RiUrs+Hybo0tCi8DsqAD97Dra8hlTtC49pACnEX78W2Dg2KMRCdPnxNy2acLKCeFaTlvwwSzRYXFcNP4OisHp41pd6Xx7eI9C5PdnDbqVIWcUvi+9d0cZe5H/+kmAcMRiTjhYPLH4i4j32TypjylBLXvBedkqHiwT+1qJ7G/MGEMrVlXKL+duZirSuWJCZL5gBIfh8Bj52A5i2v6t6OUWRGQJHneJeB4qWjJIHCZ7KMsKYO3EEpXVvN2WXjQ5oV4EDkSb2gWn7YT/E29PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqhXtiykNaXOAbhPBcFcpdDpboHhyOgcyvcqs5Y4MPg=;
 b=hyeR9E1ByeM7zD8vxssX9I/lDX6dFziAarP+dZ+jMQlYDWsJkd1lLh7XLaH6nEhlCeLOZ+4BpxOd0OhAOG6K+6mejKtXikrWeEULw24m5fQoUoTDgk92+xK1RzGV3mdEVxVmHcSbt4x5rXiQI7C9DxyoAYAPkzxv99ftfPwl7T0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 23:59:56 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 23:59:56 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 2/8] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Topic: [PATCH v3 2/8] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Index: AQHVWHyImxX6rEh2Ukm1sm9yHR4aIQ==
Date:   Wed, 21 Aug 2019 23:59:56 +0000
Message-ID: <20190821235938.118710-3-Yazen.Ghannam@amd.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c38fd9a3-15dc-46fe-6ec6-08d72693aaab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815E4A035F5204C358350ACF8AA0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QKpYI5EgiY+B2QKSAGHhBhvVpnr9OT8nC+TQozDe0pNGPCVaCgqSfdGXtsl7Q1guRe65l7EXDCT4c9JA37tXGnOdxDU61qx8ypDGN2OLX2QLNtgnhLz42U3YDup2bhAgfGDXlXCDTDEiuTyxek6Z1BbNs3bBn2zKQRwNbewY4teST+7AN+omYCGdkpXpexRvinmDyJ66KlID/w/tnhYquVEZGzWuw6YFBORU3BFlX8lxAIP6/H8hMeMMKtDt6YrHEtg4svGyHqD0RRC8mwsgz602v+iQUXd7fYSk3hKTRtPhKT/cH5nCBLewif+oPkO5Pdc4MBfgt3KBWjKIY7BPUImSG6JGpvDL6ix9rekjbAi3tYU33E+I7PbQQRuOe0/ngpVY/YxAnhJDXqmollNZy6slkVs+uNm+CHf5RX2+IQs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38fd9a3-15dc-46fe-6ec6-08d72693aaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:59:56.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bP3gIiIqCc8NZG+rk7tcXzbyETvXqcGZNYewsosSfuasTO5za6fbBxsqu+fWCypCI7QWGTyMXt9fT+ARpzlr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 17h systems support x4 and x16 DRAM devices. However, the
device type is not checked when setting EDAC_CTL_CAP.

Set the appropriate EDAC_CTL_CAP flag based on the device type.

Default to x8 DRAM device when neither the x4 or x16 bits are set.

Fixes: 2d09d8f301f5 ("EDAC, amd64: Determine EDAC MC capabilities on Fam17h=
")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190709215643.171078-3-Yazen.Ghannam@amd.com

v2->v3:
* Add case for x8 DRAM devices.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index dd60cf5a3d96..0e8b2137edbb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3150,12 +3150,15 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid=
)
 static inline void
 f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pv=
t)
 {
-	u8 i, ecc_en =3D 1, cpk_en =3D 1;
+	u8 i, ecc_en =3D 1, cpk_en =3D 1, dev_x4 =3D 1, dev_x16 =3D 1;
=20
 	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
+
+			dev_x4 &=3D !!(pvt->umc[i].dimm_cfg & BIT(6));
+			dev_x16 &=3D !!(pvt->umc[i].dimm_cfg & BIT(7));
 		}
 	}
=20
@@ -3163,8 +3166,14 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci=
, struct amd64_pvt *pvt)
 	if (ecc_en) {
 		mci->edac_ctl_cap |=3D EDAC_FLAG_SECDED;
=20
-		if (cpk_en)
-			mci->edac_ctl_cap |=3D EDAC_FLAG_S4ECD4ED;
+		if (cpk_en) {
+			if (dev_x4)
+				mci->edac_ctl_cap |=3D EDAC_FLAG_S4ECD4ED;
+			else if (dev_x16)
+				mci->edac_ctl_cap |=3D EDAC_FLAG_S16ECD16ED;
+			else
+				mci->edac_ctl_cap |=3D EDAC_FLAG_S8ECD8ED;
+		}
 	}
 }
=20
--=20
2.17.1

