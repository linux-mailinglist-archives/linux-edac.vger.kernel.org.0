Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD398841
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfHVAAb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:31 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:22183
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731193AbfHVAAb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcGpLqZh7uyN1Pwq2KSNqVZGMAfW84UKa4XHORf7oJbvG0DaX4QGNwEOryrB9mPlhfStsHuLiiIvjUsmi0Qw4KqbYPjQIi8Ewh3p10D7b9flJhIIPbWEvMTAw6sjr+po7qbkphzWOjSqfIPujW/HSaThogle/yVeuKfM2qkZFX2Pg3lqMBX4sGY971OKONkrIHAm2snSCVeERmnGczwFGTW4kSr7efJpOJ12SFHZ5stEzNF6MS+jwFEeA+zZ727thMF3NEx0W05S84GOq1xLLRs+3Eca8EMFP2H8K7nAlaI/UivEqBpA7G58rfOyaEJZ68tFmOcK0pmL5jsLC5wZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPcQWgNrqVm+CBGqZ4VEVLmxWnXoryuDlAj8rZjUnrg=;
 b=Ktd0aIF/FYjA2FXn1/CKcdmIjUDMKUk82DElPYmFDrlgJnPxrfhUBX2qcoUybJBq8Lgp1qdB78y3hLX4wAlk3+H641QChEWuhYR0+8R2R2eKiA40jASQPMYuInbrvFgBU/CvDOgUPBQYMLKWUpHEfrYdoHEhQQUWW7aE4wNY6/4eTZne808Iatu+ClZIoDbkfSyykAffO04tyuBMw7ODA5IIWPEmwn/lQMAqDKRY8nBmfB2gXDPDe2k06YpnA73ypj9fTQ3AmY9D2UOPPcmva7Y47XWjHqvgTTXa3ZGe4XwUFNaTXnOkG5rypPq2KH1/GPaiomBad9RWqdICWV/hPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPcQWgNrqVm+CBGqZ4VEVLmxWnXoryuDlAj8rZjUnrg=;
 b=1JAlU4zEGR8Vk5JsZ/zDyWDSpBRBDm4UlfQZRIkdiek5AtHUbnRF2skl0tFiBv1u+FhqSzMGj56ff6cAsWp6iSjWu3aCwLjYq3PzlFeYQkOaOLP0eVdpTzJv4pt2Xv5XGo6+kLoBY8Mf9zSpG5Xq4XgvfVuvSpfn0T70qn7eRlI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:22 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:22 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [RFC PATCH v3 09/10] EDAC/amd64: Use cached data when checking for
 ECC
Thread-Topic: [RFC PATCH v3 09/10] EDAC/amd64: Use cached data when checking
 for ECC
Thread-Index: AQHVWHyMYJ1RA2mtCUao9GrQLp32lA==
Date:   Thu, 22 Aug 2019 00:00:03 +0000
Message-ID: <20190821235938.118710-10-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 0ba8ca10-bff7-4b87-9f32-08d72693aed8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815040D0C77F564ED65EA1BF8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(2616005)(486006)(102836004)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(71200400001)(6666004)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DGxEnggZoeJ+FtvroM3voimOuZ4xXWmOBQCnzMdIXIZuRu0lRKRNsbxdlG/gMNsnft1TdPLtM/snwkKaID9VAc7MVGI5MI9e5pBJiBglaoCOoGGrr6wk1vaojGXM2iFv1U51yd3E2zkWsxgmCukMU9wcuRqOUs3w7PvgT4jeAg0mA9nlsGFwa3qsxQRLeN7ZdJ2t9uj8vkle9Gk+aU8obo9TxIfDBnsPfLLADZVfR4ADXIDEeWiDzXtq6s14d44OafBPi1yxzYiyrc8iCoA4hUpFNhBuahXy9OMf2RHF88yfcXUdOAtN9T1VZq5F8VNEnDjqVCWkb/M5xk0YPnVQAZuEj9fomwFnKzkdrk8JIaelmTakpIZBFHgrGEuHmxV3UaJjh0pGn6mNxTx/aL64t/aEAplNCJU6iPnvGBHpt5I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba8ca10-bff7-4b87-9f32-08d72693aed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:03.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNBkgNLC77OaFS0xeDTUJQ0Gl/JmTYN55KSG64LCLheiIUUEysmNHFXvtHd1Wq/1jYB9zErhrY8GxQkoCDp7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...now that the data is available earlier.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 84832771dec0..c1cb0234f085 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3183,31 +3183,27 @@ static const char *ecc_msg =3D
 	"'ecc_enable_override'.\n"
 	" (Note that use of the override may cause unknown side effects.)\n";
=20
-static bool ecc_enabled(struct pci_dev *F3, u16 nid)
+static bool ecc_enabled(struct amd64_pvt *pvt)
 {
+	u16 nid =3D pvt->mc_node_id;
 	bool nb_mce_en =3D false;
 	u8 ecc_en =3D 0, i;
 	u32 value;
=20
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
+		struct amd64_umc *umc;
=20
 		for_each_umc(i) {
-			u32 base =3D get_umc_base(i);
+			umc =3D &pvt->umc[i];
=20
 			/* Only check enabled UMCs. */
-			if (amd_smn_read(nid, base + UMCCH_SDP_CTRL, &value))
-				continue;
-
-			if (!(value & UMC_SDP_INIT))
+			if (!(umc->sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
 			umc_en_mask |=3D BIT(i);
=20
-			if (amd_smn_read(nid, base + UMCCH_UMC_CAP_HI, &value))
-				continue;
-
-			if (value & UMC_ECC_ENABLED)
+			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
 				ecc_en_mask |=3D BIT(i);
 		}
=20
@@ -3220,7 +3216,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 		/* Assume UMC MCA banks are enabled. */
 		nb_mce_en =3D true;
 	} else {
-		amd64_read_pci_cfg(F3, NBCFG, &value);
+		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
=20
 		ecc_en =3D !!(value & NBCFG_ECC_ENABLE);
=20
@@ -3539,7 +3535,7 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
=20
-	if (!ecc_enabled(F3, nid)) {
+	if (!ecc_enabled(pvt)) {
 		ret =3D 0;
=20
 		if (!ecc_enable_override)
--=20
2.17.1

