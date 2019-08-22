Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34C9883F
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfHVAA0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:26 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731489AbfHVAAZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfO7Bi/lKCgYIwwtxPabSzNMoGMK+VQ2PCRg6d6iMpQLaXKACaqVfRFh5MI9Y0T3ySteGvCCjWVW568FDdAJHSYaboT/OdJaP1oNRuS9Uzrt8nFckkDafeTuYyZupiFN8mjdQRXvYNDNsbESvNSOhz7iC4TKL7WUm713MblepCfHl9tf4fZkBG1x2jzBu1tX9ABfGD3qlCVCVImm8f4U0pV+M3d3SmU1X6u3yJqE/9hParlvM++4isXFOzkXUOwhsP4oGqi0jsVJXQcnrLUJXDanz9cnuYarPOjfpC8Vc51IBbMgtWukVctrFCrqYpthYDwmAFuCJY4ZaFNSepotgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqNNeQfdpsO/FN60vpp9MZmO8QA8LMQ/3gkMKQFJvY=;
 b=h3Nx/4aamkCbH/lwom38VaVDg2odvmNX3x3OyC+1ig5Anh9EzlC0GEVUwjZGpg0x2irdGM1ART3qjxEc/h2FI/X2z6A8wkVvN0yAr5ri0VZ4AP7HNq3gm+4junsoN27at8CdOaMdU2X1xjF/mmRDSU5j6V9hPUTigTTUw9qG/Rf3JNJ4IwzzaI+52oqZROca7KvIbb3WGtKBg/2vmC0mhPPGffB1rviv3KJXf3gn+SVjm7kRO5swejthkGxRfrHRbxIQeq9U3RCGJnc5jBMponYfFbI1vPf4n0obleuwqgmGjvyU+8t1DXXtJfizWJQTEjQtCQTku2w+iw3U2owY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqNNeQfdpsO/FN60vpp9MZmO8QA8LMQ/3gkMKQFJvY=;
 b=yGDQtqa2xwTXSQOx22Z4nxS4VPjjwsiQHuRXWj2dqrgS9bhCqMngmfSH8AQPGZOnh31Vc6xxCc/oQNKs8CcqWGDi1KZyVlKDMNB0pO8yimqcZ2x8FqkFvLzXo7JUFDo9/udDmtrkV3H4RcaFlgu8YkRDErQ2YPdE+032Mh6Pc6Q=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:03 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:03 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information early
Thread-Topic: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Thread-Index: AQHVWHyM0yWTJ6Qnuku4Pj6P3bApxQ==
Date:   Thu, 22 Aug 2019 00:00:02 +0000
Message-ID: <20190821235938.118710-9-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: be4857ea-8693-4af3-236a-08d72693ae7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28154418448547AA89734B50F8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(2616005)(486006)(102836004)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gd8zWZMYMMWysop0sMrhRKW/SBc6mFF8VTpkK+WXscv/rOZs4t6V/6YYQBQttzun8jqZ8dQFwBQOoic8ZI9gN0eXGma1JaknJiUXWPaiDJsbTdY2DsBiAlIF+v3ivBYAWSGgt8+Q6SpTb7P7JmkxXtbev9o+Po+hvlj/sEiQdkUZuuVp0uMTtNCOW0+Aqrg25J2UAqmE3rnnoLBNe+vXLQZ58yof0GLyB1tnSY236DuIteY89o8fdC3gStjEuWOPaCbkjIRCIrhWNFkd/v1ydNXba6qu3vkurHmj0/tA1J8G8XHlmbKVyzCqXyXq38/T7M2D7M3VlJLQPLfojm6INQdtMBtx1Lj0SqNPAeYi64p++7h2SUL6WhQVr8hizosckrPiaoWxkDqDu4qE1hZUmIYm34fZ70GgPk38I6K+8zI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4857ea-8693-4af3-236a-08d72693ae7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:02.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eFmQ0ovIxE+MMcaS4FTj/LT2HxUcOzBEBScVhi39IWJ37VkycI+mcj9D+ZW8DY9UePemeJGBC4v8qXS45Q1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Split out gathering hardware information from init_one_instance() into a
separate function get_hardware_info().

This is necessary so that the information can be cached earlier and used
to check if memory is populated and if ECC is enabled on a node.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 76 +++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4d1e6daa7ec4..84832771dec0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3405,34 +3405,17 @@ static void compute_num_umcs(void)
 	edac_dbg(1, "Number of UMCs: %x", num_umcs);
 }
=20
-static int init_one_instance(unsigned int nid)
+static int get_hardware_info(struct amd64_pvt *pvt,
+			     struct amd64_family_type *fam_type)
 {
-	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct amd64_family_type *fam_type =3D NULL;
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
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
-			goto err_free;
+			goto err_ret;
 		}
=20
 		pci_id1 =3D fam_type->f0_id;
@@ -3442,18 +3425,34 @@ static int init_one_instance(unsigned int nid)
 		pci_id2 =3D fam_type->f2_id;
 	}
=20
-	err =3D reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (err)
+	ret =3D reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
+	if (ret)
 		goto err_post_init;
=20
 	read_mc_regs(pvt);
=20
+	return 0;
+
+err_post_init:
+	if (pvt->fam >=3D 0x17)
+		kfree(pvt->umc);
+
+err_ret:
+	return ret;
+}
+
+static int init_one_instance(struct amd64_pvt *pvt,
+			     struct amd64_family_type *fam_type)
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
 		goto err_siblings;
@@ -3478,7 +3477,7 @@ static int init_one_instance(unsigned int nid)
 		layers[1].size =3D 2;
 	layers[1].is_virt_csrow =3D false;
=20
-	mci =3D edac_mc_alloc(nid, ARRAY_SIZE(layers), layers, 0);
+	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
 		goto err_siblings;
=20
@@ -3504,20 +3503,17 @@ static int init_one_instance(unsigned int nid)
 err_siblings:
 	free_mc_sibling_devs(pvt);
=20
-err_post_init:
 	if (pvt->fam >=3D 0x17)
 		kfree(pvt->umc);
=20
-err_free:
-	kfree(pvt);
-
-err_ret:
 	return ret;
 }
=20
 static int probe_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
+	struct amd64_family_type *fam_type =3D NULL;
+	struct amd64_pvt *pvt =3D NULL;
 	struct ecc_settings *s;
 	int ret;
=20
@@ -3528,6 +3524,21 @@ static int probe_one_instance(unsigned int nid)
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
+	ret =3D get_hardware_info(pvt, fam_type);
+	if (ret < 0)
+		goto err_enable;
+
 	if (!ecc_enabled(F3, nid)) {
 		ret =3D 0;
=20
@@ -3544,7 +3555,7 @@ static int probe_one_instance(unsigned int nid)
 			goto err_enable;
 	}
=20
-	ret =3D init_one_instance(nid);
+	ret =3D init_one_instance(pvt, fam_type);
 	if (ret < 0) {
 		amd64_err("Error probing instance: %d\n", nid);
=20
@@ -3557,6 +3568,9 @@ static int probe_one_instance(unsigned int nid)
 	return ret;
=20
 err_enable:
+	kfree(pvt);
+
+err_settings:
 	kfree(s);
 	ecc_stngs[nid] =3D NULL;
=20
--=20
2.17.1

