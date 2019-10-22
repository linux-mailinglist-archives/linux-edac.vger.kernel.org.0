Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856BBE0D59
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbfJVUf1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:27 -0400
Received: from mail-eopbgr790088.outbound.protection.outlook.com ([40.107.79.88]:26304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733029AbfJVUf1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMtv/JrBhYcscQyq3Pcst7LN+zvpRVezcbATJtOv7WrztyY9ljRERr6rWEjVUbhrx+nQb9ZoTy4jK2VNB914zUVxROxQk0xIIAvbBDyl8f8oUttRcpwjQHALzoov4paBCCVeIBvNapLRQI3Hfy3/Ugu4hNa6aVpVQjAjoWLiqccMtl3CrqRrne7Ke1KzktUV/IB2fXxSECJ9t16vM3so7vyLyCHtPjEsNtnoWiChdPP5ZW+j+5EGthz/+2P1TzhwxtYWgVUeWJdGt3NVaVBo29yOTUmKvnyDr6GdbqFPYDwiS9BYSRsw9qFySK8fca6Id6YgRI2MM3CLq06Ek+WAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgCc5pf7X5sup0KHq2d+oCcHxJEr48xR8rNjCQtdH+8=;
 b=ZUvg6t6zR0dHcZkfvg57ecIf4rptGPt1T+kagyQhw+OuMZx+g8EAyiFYzKY8HgbA3chwHbyX/D8oUEeluWozz3eytNYmzMKjCbWsWxs06Eq858u4TR7yue/PTOelR8DJM2Dv0dr8yQMeEbavpnMK+lhtXdlAn0qQBY2Jycg+gJldSQxw5i8ItVU1tq1kAb7YD76PLs/qlEZ5hjNEvXx5fS/YVVS+zTFByh6J69tsbvy6VYYlUcxx6biwmmZnNDhDzYO4+dwNntICoNbeiFyEMeasnLTWvLO9IRnde+v3vqdIwDgISvL84MSFbLkDDXsxPN14D/gdfn/BLUAgw7ewhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgCc5pf7X5sup0KHq2d+oCcHxJEr48xR8rNjCQtdH+8=;
 b=JqCEsM3gb6S0Q0CaIbiwWloFfBMrB8t17q57OFCHOzMiRsKaddX53z5m3xu1EYfN3yHHMkh/+qQXtRKXl0AKfpLdeWhIiSMALP1iNZzdmNrfZggBL2QOSi9rgMjJQf7TBAXp+fZ2jahUdV63QzLhnSwgjGeseUZScavV3Yey4Ig=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:35:10 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:10 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 2/6] EDAC/amd64: Gather hardware information early
Thread-Topic: [PATCH v2 2/6] EDAC/amd64: Gather hardware information early
Thread-Index: AQHViRgyyNCGlOIlVkadvQJY7cn6Hg==
Date:   Tue, 22 Oct 2019 20:35:10 +0000
Message-ID: <20191022203448.13962-3-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: efb29278-b192-4660-c1df-08d7572f554c
x-ms-traffictypediagnostic: BN7PR12MB2724:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB27246A344832F99A08CA8B6CF8680@BN7PR12MB2724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(36756003)(54906003)(316002)(2906002)(14444005)(256004)(66066001)(6916009)(52116002)(71200400001)(71190400001)(76176011)(2351001)(2501003)(6116002)(26005)(99286004)(186003)(6512007)(4326008)(6436002)(966005)(1076003)(102836004)(305945005)(5640700003)(7736002)(6486002)(386003)(6506007)(6306002)(14454004)(3846002)(478600001)(2616005)(486006)(476003)(8936002)(66446008)(11346002)(446003)(50226002)(66476007)(81166006)(66556008)(64756008)(8676002)(81156014)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2724;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjMkhtqzigTi+l6swn4IuME8cz0+NDLscK5S6pVxsavgwHzt5v+9Atrvtv2wxPL1snQKjBbh7180sRSKx3ECposBK7acsZuz9uZ0w4OHyguO4yu/H2xrxhQCmRVRhpnwNY+kak3ZwfXBKpjhJEL3QKpjGDmgSlLXlyFFkaIATwdJcTZJy6QI/FjyS/yByH2n+Xy7ubpa14TDV9sMvyVdItMrOEsKtPvwqnECVkjagk2ZjxXQH060Y+86SR2Xh8RPPUOF8juHFfgER4+4lshFt94S9Z/Qc6QsaC/E9bccHkRlJKi4L6Z/sbYXclyg5xVbL5yM0dDUFeopf/zt/U1PM9UvH21uwhU9g6Ps5EdcYIaifyAKe5hwWBscKUK6UhYqZSdCW+do+DUrSu1dyNULjvofEWJ5KtEBjBxYJDnSNpFkLdsH9Gn5etTz/kRhudMdg/arawryK/cLcN89ICMbEI3TkECnvjaUqr3ur+jA9WA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb29278-b192-4660-c1df-08d7572f554c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:10.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaVaM5ejpgYkX08b6Pt2IncqNlCTSUcetya0+6tZPuM59L1dZIcGm/GzZsthEFtWcQ/Osvu3u7J5rxNWOm7aUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Split out gathering hardware information from init_one_instance() into a
separate function hw_info_get().

This is necessary so that the information can be cached earlier and used
to check if memory is populated and if ECC is enabled on a node.

Also, define a function hw_info_put() to back out changes made in
hw_info_get(). Currently, this includes two actions: freeing reserved
PCI device siblings and freeing the allocated struct amd64_umc.

Check for an allocated PCI device (Function 0 for Family 17h or Function
1 for pre-Family 17h) before freeing, since hw_info_put() may be called
before PCI siblings are reserved.

Drop the family check when freeing pvt->umc. This will be NULL on
pre-Family 17h systems. However, kfree() is safe and will check for a
NULL pointer before freeing.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20191018153114.39378-3-Yazen.Ghannam@amd.com

v1 -> v2:
* Change get_hardware_info() to hw_info_get().
* Add hw_info_put() to backout changes from hw_info_get().

rfc -> v1:
* Fixup after making struct amd64_family_type fam_type global.

 drivers/edac/amd64_edac.c | 101 +++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b9a712819c68..df7dd9604bb2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3416,34 +3416,15 @@ static void compute_num_umcs(void)
 	edac_dbg(1, "Number of UMCs: %x", num_umcs);
 }
=20
-static int init_one_instance(unsigned int nid)
+static int hw_info_get(struct amd64_pvt *pvt)
 {
-	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct mem_ctl_info *mci =3D NULL;
-	struct edac_mc_layer layers[2];
-	struct amd64_pvt *pvt =3D NULL;
 	u16 pci_id1, pci_id2;
-	int err =3D 0, ret;
-
-	ret =3D -ENOMEM;
-	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
-	if (!pvt)
-		goto err_ret;
-
-	pvt->mc_node_id	=3D nid;
-	pvt->F3 =3D F3;
-
-	ret =3D -EINVAL;
-	fam_type =3D per_family_init(pvt);
-	if (!fam_type)
-		goto err_free;
+	int ret =3D -EINVAL;
=20
 	if (pvt->fam >=3D 0x17) {
 		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
-		if (!pvt->umc) {
-			ret =3D -ENOMEM;
-			goto err_free;
-		}
+		if (!pvt->umc)
+			return -ENOMEM;
=20
 		pci_id1 =3D fam_type->f0_id;
 		pci_id2 =3D fam_type->f6_id;
@@ -3452,21 +3433,37 @@ static int init_one_instance(unsigned int nid)
 		pci_id2 =3D fam_type->f2_id;
 	}
=20
-	err =3D reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (err)
-		goto err_post_init;
+	ret =3D reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
+	if (ret)
+		return ret;
=20
 	read_mc_regs(pvt);
=20
+	return 0;
+}
+
+static void hw_info_put(struct amd64_pvt *pvt)
+{
+	if (pvt->F0 || pvt->F1)
+		free_mc_sibling_devs(pvt);
+
+	kfree(pvt->umc);
+}
+
+static int init_one_instance(struct amd64_pvt *pvt)
+{
+	struct mem_ctl_info *mci =3D NULL;
+	struct edac_mc_layer layers[2];
+	int ret =3D -EINVAL;
+
 	/*
 	 * We need to determine how many memory channels there are. Then use
 	 * that information for calculating the size of the dynamic instance
 	 * tables in the 'mci' structure.
 	 */
-	ret =3D -EINVAL;
 	pvt->channel_count =3D pvt->ops->early_channel_count(pvt);
 	if (pvt->channel_count < 0)
-		goto err_siblings;
+		return ret;
=20
 	ret =3D -ENOMEM;
 	layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
@@ -3488,9 +3485,9 @@ static int init_one_instance(unsigned int nid)
 		layers[1].size =3D 2;
 	layers[1].is_virt_csrow =3D false;
=20
-	mci =3D edac_mc_alloc(nid, ARRAY_SIZE(layers), layers, 0);
+	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
-		goto err_siblings;
+		return ret;
=20
 	mci->pvt_info =3D pvt;
 	mci->pdev =3D &pvt->F3->dev;
@@ -3503,31 +3500,17 @@ static int init_one_instance(unsigned int nid)
 	ret =3D -ENODEV;
 	if (edac_mc_add_mc_with_groups(mci, amd64_edac_attr_groups)) {
 		edac_dbg(1, "failed edac_mc_add_mc()\n");
-		goto err_add_mc;
+		edac_mc_free(mci);
+		return ret;
 	}
=20
 	return 0;
-
-err_add_mc:
-	edac_mc_free(mci);
-
-err_siblings:
-	free_mc_sibling_devs(pvt);
-
-err_post_init:
-	if (pvt->fam >=3D 0x17)
-		kfree(pvt->umc);
-
-err_free:
-	kfree(pvt);
-
-err_ret:
-	return ret;
 }
=20
 static int probe_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
+	struct amd64_pvt *pvt =3D NULL;
 	struct ecc_settings *s;
 	int ret;
=20
@@ -3538,6 +3521,21 @@ static int probe_one_instance(unsigned int nid)
=20
 	ecc_stngs[nid] =3D s;
=20
+	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
+	if (!pvt)
+		goto err_settings;
+
+	pvt->mc_node_id	=3D nid;
+	pvt->F3 =3D F3;
+
+	fam_type =3D per_family_init(pvt);
+	if (!fam_type)
+		goto err_enable;
+
+	ret =3D hw_info_get(pvt);
+	if (ret < 0)
+		goto err_enable;
+
 	if (!ecc_enabled(F3, nid)) {
 		ret =3D 0;
=20
@@ -3554,7 +3552,7 @@ static int probe_one_instance(unsigned int nid)
 			goto err_enable;
 	}
=20
-	ret =3D init_one_instance(nid);
+	ret =3D init_one_instance(pvt);
 	if (ret < 0) {
 		amd64_err("Error probing instance: %d\n", nid);
=20
@@ -3567,6 +3565,10 @@ static int probe_one_instance(unsigned int nid)
 	return ret;
=20
 err_enable:
+	hw_info_put(pvt);
+	kfree(pvt);
+
+err_settings:
 	kfree(s);
 	ecc_stngs[nid] =3D NULL;
=20
@@ -3593,14 +3595,13 @@ static void remove_one_instance(unsigned int nid)
=20
 	restore_ecc_error_reporting(s, nid, F3);
=20
-	free_mc_sibling_devs(pvt);
-
 	kfree(ecc_stngs[nid]);
 	ecc_stngs[nid] =3D NULL;
=20
 	/* Free the EDAC CORE resources */
 	mci->pvt_info =3D NULL;
=20
+	hw_info_put(pvt);
 	kfree(pvt);
 	edac_mc_free(mci);
 }
--=20
2.17.1

