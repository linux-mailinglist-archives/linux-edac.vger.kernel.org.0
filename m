Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37000DC887
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633014AbfJRPbh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:37 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:48496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408746AbfJRPbg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY+lypjij6sTpD6ukQ9hx9uSLp//5k+15k2OmAEtSGSkOGGcz37A0unUNULPcHd2CilWaB6nUN16y2+3uhM3gY3cMUKsE6d/i9iOosC+My5eMBH+GdK/ay81Uha79f+kOZMWtr30GNLRJjBxgj0ZW6dMq6z0lOSUPNVNvR8+g499hbk9KHCwMuSOpi7f3QcP8SEskQxPI3vECVcUJpgku1FjaTXBfClz6z9BfUnhpvtMFzxD1Np30HDm4NNfheebGrf7QVdGOoviW5bPFHkQiUNPM2jddx/atmFL1gTotqQXqKszQSDdUhdja+IoaGi+O9LGKtTiWXP0aGYafHeP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fol9OOZLxxNWJqKD/tmNGGKZ+qsRGzYVtZmhPLNlM2Q=;
 b=N5TmW16qffCItbCwzFOtSEgjIoddeIlZ9/LWn0HCI9hMAHAXau8H1ujJ5PU4PXZ1hi2u42KQ4L/rq8yzE4xoA5O7tz7Bi92EUxX5KKwpwNNOrmJHVuRuPUcuJytdq8xrBQfGnNB/ialDG0YHtF7PndrnXTXIHuZDYsEMvMckKjht5FeSVLpl2tsPYn8V93A91Rq0kC/va8wTiERsuZ/72TqRKOs0sr6juJL2H3zs2RFrqoWnF8j3bzFOtPmOkKZse+ykqOW695ta1zH44XycOueWfdLuzf0j7XdutEg1YYXHBfQq5uc0Wj0RGVSEyLAqKzUrwC3ESgx2DH1+Y2nW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fol9OOZLxxNWJqKD/tmNGGKZ+qsRGzYVtZmhPLNlM2Q=;
 b=T5ABbgbZDELaVTWJyjF2zaLVRvqpmgAZ2GIAdia0mSNEKGwsTr30N/CVuDuGQF5TTNGj3NNEQt3/uwsNNnuYHjZJzGwkHAPABI1UCUrTedA6xsVqXbg98GbozoDcsZMKw1YBIP1/ZtMLM/dNZaNkikBMfVy0lbGmefD/Vh5C8qE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 15:31:27 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:27 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 4/6] EDAC/amd64: Use cached data when checking for ECC
Thread-Topic: [PATCH 4/6] EDAC/amd64: Use cached data when checking for ECC
Thread-Index: AQHVhckbG/+gEL4Cd0umc2ocXEdT9Q==
Date:   Fri, 18 Oct 2019 15:31:27 +0000
Message-ID: <20191018153114.39378-5-Yazen.Ghannam@amd.com>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f92f19ca-8cba-4562-2bcf-08d753e03dd1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2608D91596E52B008B63FF45F86C0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6506007)(386003)(186003)(2906002)(6512007)(6436002)(6486002)(2351001)(6306002)(3846002)(478600001)(6116002)(5640700003)(7736002)(305945005)(26005)(102836004)(966005)(446003)(76176011)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(11346002)(476003)(256004)(2616005)(52116002)(50226002)(86362001)(6916009)(99286004)(8936002)(81156014)(25786009)(81166006)(486006)(8676002)(2501003)(36756003)(1076003)(5660300002)(4326008)(14454004)(316002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuP91kQbI0RKca1apmOrgRof9MVZ0Vy8BdL3ZxeiYr4XoJpc79GDTp/kks5fHMnhvI+PVl1gPzT5DUOBcNhcGgRwrlwzbXsB1oBiHCIhxs1rAwxhe3Jqguk+cUD6ZIOvxl9f2LlI4HRyhjfOVJVOgdE6FVxn6tJ67ENdiTtRv2pU+MsJ3Pmr3xQlwxPriXk28wsPpCZ2RCWzYsJCnuCuys20WQbYNat9hrFrXxWc/Mkm8qJrT74DLWl9AJuaJvD3AFFPw7YKu+GJ33HHIyU3XN1Po5YnnfGgYBNMhYS0yx6cpAIkTLhqCJEghxtEn/4yeMtRiW3qelaYNs+fTWjq77v3qLB+RmZ9FcZ7UX1jaMdUvSjG8+9IaBGOq/SICZhT9DPwsnnuGk7bEkdJEuK32GEMzE65+VNT5FpGdvWhEYVZnOn1LNpCh1B0XQTfd2FGGFbHVBuvvHem8SUB0MR2+w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92f19ca-8cba-4562-2bcf-08d753e03dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:27.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ay3xXFpZ9V1RzkD2LcrUOv5MpV6frgQfzHZm4MYSUtGiTvInKLIidTiQIr1RKM4tABcv7Oev0kBJgaSlIFCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...now that the data is available earlier.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190821235938.118710-10-Yazen.Ghannam@amd.com

rfc -> v1:
* No change.

 drivers/edac/amd64_edac.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0fde5ad2fdcd..feb68c0a3217 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3200,31 +3200,27 @@ static const char *ecc_msg =3D
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
@@ -3237,7 +3233,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 		/* Assume UMC MCA banks are enabled. */
 		nb_mce_en =3D true;
 	} else {
-		amd64_read_pci_cfg(F3, NBCFG, &value);
+		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
=20
 		ecc_en =3D !!(value & NBCFG_ECC_ENABLE);
=20
@@ -3534,7 +3530,7 @@ static int probe_one_instance(unsigned int nid)
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

