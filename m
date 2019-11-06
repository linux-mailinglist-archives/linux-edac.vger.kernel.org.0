Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF5F0BA1
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfKFBZG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:06 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:36833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729614AbfKFBZF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzzbLaKTh/1tAFCEEXbaKBY1lInBHbpss/8Bvm4PA94m80KHZPerCV4lNQk7WL7wVb+n39rpf7sxv8hWYCjSDer8O/svz3V8O61vQBPjuieHDwT68sjY67H04A37gnpiFYPeCHFpp96vRMyTA6AUt5BDglfwc6+lLPL+niDcNAeW4BHJsjW7bVZymlas/tLNpidUOPTj+R9U/xcFHy01uZh4bQjRdYl0fPbetfOuamHdmzecCAihWrDrGoNC9NC00hS3a3T3+Zb0LSF8J0EnvcNvipaGpSjweiVJpHszCfq3J9bVpfBAeoV4CQIKcmV9V2jrNmxaQ7+FRZ62RjAnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTUIlgKvu96fUXRcN9kCejWE/AP4ehwwz3pi+3/k1gY=;
 b=gTXBBmjdTwzijwhNJk5356CyBkz7ZqW83Q1xL945u/hepaSAdAaqrPoVgbMAGlc/Zx/A+mBqHmzyfE1v0HXJCUqM++9/9wtEiP/ptYtmZWMddWyDXpzI+QYHIPQH50XhsBirM8y6J6fbhzofTQ0/bRQvVzqQn26rWnSBJABO0EDSSSwsBqOUBk+khQ6GRprF/ItzdZxt8FqONh6SpCrMrafCVBczbc4vTYkyxGUqannYlObwdxYMcDsaanLv813z8bN9PYTTONno1f07trN+c4/LOOGKMjg1IS+swzIZ8y78kO+Y4MrxbrQMBIKsjo0nl5sAE0qR6jOR3fvvK9tpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTUIlgKvu96fUXRcN9kCejWE/AP4ehwwz3pi+3/k1gY=;
 b=4RzGRfdmwlZ/bUoNqvjQj3sS02NW6sb6hBU00vqxmBH8m6zbFPZJsF5P2FzkGZjJcD9wmmcJ5HOsarF+ubzI7NuWnp3tok1cklmoAm7tFlx267ldbDlFB7AO8M8ryrfgaUncyQF1NBwFOH73bsi74Yo8EAcjkdbSFh2/DZReqvE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:25:00 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:25:00 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 2/5] EDAC/amd64: Gather hardware information early
Thread-Topic: [PATCH v3 2/5] EDAC/amd64: Gather hardware information early
Thread-Index: AQHVlEEBohvFV9eryESXXaIu8+8MoQ==
Date:   Wed, 6 Nov 2019 01:25:00 +0000
Message-ID: <20191106012448.243970-3-Yazen.Ghannam@amd.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86d8486e-fa01-45c0-a7ee-08d76258243c
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB278344665D936E16A11876BBF8790@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(186003)(5660300002)(86362001)(386003)(4326008)(102836004)(6506007)(1076003)(52116002)(966005)(6306002)(2906002)(5640700003)(99286004)(6116002)(36756003)(54906003)(14454004)(25786009)(486006)(66556008)(446003)(11346002)(81156014)(6916009)(76176011)(305945005)(7736002)(26005)(6512007)(2616005)(66066001)(2501003)(66946007)(316002)(64756008)(478600001)(50226002)(71190400001)(71200400001)(81166006)(8676002)(256004)(14444005)(2351001)(8936002)(6436002)(476003)(6486002)(66446008)(66476007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKHoQOueNrQmntmEvi1UPmp6fjWq1MkSXBD4xmducWHO+J5XuWgQXfC05i61/nQFZ9sgT8zn9s6TaZ4ZRlTDQqsjyVYcyhi+d+V7AW2OW/tt5Np2z7m+rpxHjI3R+8XKBlWb2c3Gnp5P5iYR726+C/fZbXcSSSIexHVSXvX6iBQ+nRcKdUtgVWXtYYYmMH8iZm0aLj3gulWEbpPHO1cGwZanK+SfcQ5+wuiX2IaPDvnQjQgECZZ50BGHeKBCIYe7hEJUGOodDHCoz0XI6XBVx0ZbHTVrfLcQj3iPpF6L3wNXlTGkzAsHqutTvbjUQOdOcDvsEq1wN22TR1PzOPFAu2CttnMOlKB0vudDwKHa0MDLzhWOA5gi/vLMANdAjtH0bxZDdNH9fcv74w5LSJDSqUdkNhhpnh2d2L4PgJDFjjsQtho9JVael+p0P5O9qdqe9kRmTghGdu1WaE52LLziGCR0BUHPUoY7gjMQfPNq6sQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d8486e-fa01-45c0-a7ee-08d76258243c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:25:00.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lNL+hzZkLXdixpvmhtdwDxDrBLSgUFofG9uSsQAD51zj+72dTCOgeFA0XfX4qX8w9+W7BillCUcY16AE9Ff9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
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
https://lkml.kernel.org/r/20191022203448.13962-3-Yazen.Ghannam@amd.com

v2 -> v3:
* No change.

v1 -> v2:
* Change get_hardware_info() to hw_info_get().
* Add hw_info_put() to backout changes from hw_info_get().

rfc -> v1:
* Fixup after making struct amd64_family_type fam_type global.

 drivers/edac/amd64_edac.c | 101 +++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 83c659e38084..6e1c739b7fad 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3418,34 +3418,15 @@ static void compute_num_umcs(void)
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
@@ -3454,21 +3435,37 @@ static int init_one_instance(unsigned int nid)
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
@@ -3490,9 +3487,9 @@ static int init_one_instance(unsigned int nid)
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
@@ -3505,31 +3502,17 @@ static int init_one_instance(unsigned int nid)
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
@@ -3540,6 +3523,21 @@ static int probe_one_instance(unsigned int nid)
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
@@ -3556,7 +3554,7 @@ static int probe_one_instance(unsigned int nid)
 			goto err_enable;
 	}
=20
-	ret =3D init_one_instance(nid);
+	ret =3D init_one_instance(pvt);
 	if (ret < 0) {
 		amd64_err("Error probing instance: %d\n", nid);
=20
@@ -3569,6 +3567,10 @@ static int probe_one_instance(unsigned int nid)
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
@@ -3595,14 +3597,13 @@ static void remove_one_instance(unsigned int nid)
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

