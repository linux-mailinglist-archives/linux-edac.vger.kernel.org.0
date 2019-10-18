Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D124DC885
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410541AbfJRPbf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:35 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:48496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410521AbfJRPbf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJhUX9FkWaKsb3gRNO5a4M0+d9gbZGzlIL2CSgq8FOhTaLVhD0CSpvEYG/so5mp4iQbmLwUXIKdDfWTbMfWUkLCin8eiqhMWBIQ+H6kcgW6OQETdQVvMuH91yEqyczLuN/x2WUi3y27KOKNoCv3KYOM+To4TWu/AiOA/cO1Smgsm+FuyQC4s3/rDsvATAO8Q0q/pIXtvTRiFItRG2nK80HpcmFH6kw8p0MJuoPbiU86VPhxujJSiA02x75MDnTY5cPGTzX6BYWHKOXaYB98V/8Cz5oT5AmcempjTF7Efr5iAapco1FkC2ajTYBhBroJSSF1WjOZaZnrz8wL0nwiz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS6KTJ97QxtdsAKJ2WW/4o2Kd2V2uuT2ipfngT37fTw=;
 b=Qg7voFNI+ylfHsJZOnNDr37Kunl+953vDHC0XpJG39H/zxZ/qkOMmdmHwbqX1C4unihvTunhGIRQXqR7ddWD3ukDshBudvw2PZr6IcFsxKLkstgGzEV2xfS/96476QxWZkA2aSooJebkf7lTV4S3rBZDGwBQ+yW/8u2PH3jpPDlX4L6xdI/PEdkfD9flv+oK0tnAWWgBL2s6JoDlTXEtpTILg5RkjVfGzb9bEYd/Gfrvf5sKYauOtFwL9zN4uzgIrULDmm/dAyzOHwrxfPgjLJw8lwP4DyVUH6N7u2wikBnXDPbZp2bxWoSTQ99zGe1Sv1yLnTJKH/UD8mcFVhrtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS6KTJ97QxtdsAKJ2WW/4o2Kd2V2uuT2ipfngT37fTw=;
 b=M5TbhZSEta9Q70wdbblKQmaRm7iGtXXm3XCK8L7AW4JqbvKrDXhacYzEhmFqr3qPGCPFx/JZgxQmRP11q9jl7HeApO3fVDJqC3dTIsEE3n0dpW/dSZXy6rysr661pncVlgPNHtBn+64F2u//J8kopLGl5UlD7MZb7xXNGHKn/vQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.102.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 15:31:26 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:26 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 2/6] EDAC/amd64: Gather hardware information early
Thread-Topic: [PATCH 2/6] EDAC/amd64: Gather hardware information early
Thread-Index: AQHVhcka6ITY3m6nckKaJPEC+sNcVg==
Date:   Fri, 18 Oct 2019 15:31:26 +0000
Message-ID: <20191018153114.39378-3-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: a9f1ed8c-ad54-4665-2993-08d753e03d35
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26087DB0428BB26B7064F5A1F86C0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6506007)(386003)(186003)(2906002)(6512007)(6436002)(6486002)(2351001)(6306002)(3846002)(478600001)(6116002)(5640700003)(7736002)(305945005)(26005)(102836004)(966005)(446003)(76176011)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(11346002)(476003)(256004)(2616005)(52116002)(50226002)(86362001)(6916009)(99286004)(8936002)(81156014)(25786009)(81166006)(486006)(8676002)(2501003)(36756003)(1076003)(5660300002)(4326008)(14454004)(316002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dMvV8cKiLYPbbcHVYRxmcxPyjpe4CRIsLAxV/Dsaef894hfJNzF8UgValq3drriR4RqCauk4W1UlG9rLUK4rA+TnUTZnvo57bQsEkcovA5R7231VER4Ao9vswylMEKfbPF79niSQf1iwP9siNnC53EL/+3rqYFuQvIe8BF5HjeotJmYamvCGnWixou0O4SU+dpZgPfdZzod0jX5+WnHrQNDszRjfryEc4mU6tvCAIRSywD2LPBuZQvcel8sSrJeSuONf5EqcFCD+UEeoZR46e4Az30Q3Q9K1b6+BmyZUjD961QiygT35eARVMybzZnBb6XvuT6xta0dA/PeaKqMEukagSVo2eetFrZ8mpXK+SJYnxCfRMgNAl6wn5FwMA2fJYgTGyirEhUm5okFu1hNkHG7fhG0C4Exn90cgXMsDxX76CyZj16pGzjByLk955RlinxCv9hhKXYyvp9hIeccwkQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1ed8c-ad54-4665-2993-08d753e03d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:26.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDB6TbB49dKgGAxwy/9joxFEtuwdy7I56UvIOA/cIkXDqZfTX/V74VmyguCSKvippsA9TI0yx+p3WK/aDtOWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
Link:
https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com

rfc -> v1:
* Fixup after making struct amd64_family_type fam_type global.

 drivers/edac/amd64_edac.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b9a712819c68..4410da7c3a25 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3416,33 +3416,16 @@ static void compute_num_umcs(void)
 	edac_dbg(1, "Number of UMCs: %x", num_umcs);
 }
=20
-static int init_one_instance(unsigned int nid)
+static int get_hardware_info(struct amd64_pvt *pvt)
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
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
-			goto err_free;
+			goto err_ret;
 		}
=20
 		pci_id1 =3D fam_type->f0_id;
@@ -3452,18 +3435,33 @@ static int init_one_instance(unsigned int nid)
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
 		goto err_siblings;
@@ -3488,7 +3486,7 @@ static int init_one_instance(unsigned int nid)
 		layers[1].size =3D 2;
 	layers[1].is_virt_csrow =3D false;
=20
-	mci =3D edac_mc_alloc(nid, ARRAY_SIZE(layers), layers, 0);
+	mci =3D edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
 		goto err_siblings;
=20
@@ -3514,20 +3512,16 @@ static int init_one_instance(unsigned int nid)
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
+	struct amd64_pvt *pvt =3D NULL;
 	struct ecc_settings *s;
 	int ret;
=20
@@ -3538,6 +3532,21 @@ static int probe_one_instance(unsigned int nid)
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
+	ret =3D get_hardware_info(pvt);
+	if (ret < 0)
+		goto err_enable;
+
 	if (!ecc_enabled(F3, nid)) {
 		ret =3D 0;
=20
@@ -3554,7 +3563,7 @@ static int probe_one_instance(unsigned int nid)
 			goto err_enable;
 	}
=20
-	ret =3D init_one_instance(nid);
+	ret =3D init_one_instance(pvt);
 	if (ret < 0) {
 		amd64_err("Error probing instance: %d\n", nid);
=20
@@ -3567,6 +3576,9 @@ static int probe_one_instance(unsigned int nid)
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

