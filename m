Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7FDC881
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410520AbfJRPb3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:29 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:48496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408745AbfJRPb3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcWebCUi/WXOIN5DeFqpcimtprjFZyxxhZiVcb6A+FgwGx6UCVVQ3FKSXwIdkRG14Cze+nmJZNjaHFCPWoNdpNd1+5NDtWYGPLQ/tKSzic1PK6hYbmtIki+WdhFW4H5QzCQp5QAoiKYfkeg4Tuy4mxEl8210PWB/Wo2yuDmiKKEEEEmm0qHZS6hozwmMgjdnqp6jGocBuxlQn3NLgYvmvSyU1m6c0xVNpGg63arjvahU3xvUWjqb089Ylq1Q1igcpdK6ov4NtYgZ+jjulEPP4FIv+ayboZSdvMAEVpFxTQ+gX25zXazfyYuQPN88e2Ds7TkASZWjK8y8EkIwhPsKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lCcAUaPzb54VPC0T5iazEqMwS2rgCfSl8XvicBiD7Y=;
 b=N7DCE/sRAu70GNeB+nJWcPzV1i3iUo3J3sQpF0BUshcmw0mG1euDF15w/5GLz2JKSsf0RcaV9Mq9nV1vtcTjccCOugMJCCIXcn3YM2FL6kRNZukW+yCwvuR5dBZuKmP/HSLyKsH5fRX53M+uUcA35EOsg/3FHeO7Tr9Q51jDkUq6MHDknCevq2j0UUrWT4UtGr6tTstKiWZtvH5tGsh4cj+x1qtKijIYvxIu7w2SDeO79fm99WUg/7DmYUo7k6ixvPAaSn0mFfX3Qalpvw2u9hly1E9DIyCbl7jxVAtZOjir/SlIk5pUv1N54v0SYWrJRRo0PyLfn/vW27QW5ABMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lCcAUaPzb54VPC0T5iazEqMwS2rgCfSl8XvicBiD7Y=;
 b=hQepJu7QynBxiclv4XaNa9qVAgaD1915F+eMvU4ZN8zLyyI40PIecD0z/CmJg35e0L1gdmYthcvem/iiivwX2Iah/5VAXzZuVsWrfyawWVGUbXN0ylIAzFpfSuekPPepglCOPwiffboB6mezfWSv1JWIPI3/TanPRu2Bp1g5jBE=
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
Subject: [PATCH 1/6] EDAC/amd64: Make struct amd64_family_type global
Thread-Topic: [PATCH 1/6] EDAC/amd64: Make struct amd64_family_type global
Thread-Index: AQHVhckaqc6P0belS027Gy5HBkDl1Q==
Date:   Fri, 18 Oct 2019 15:31:25 +0000
Message-ID: <20191018153114.39378-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: d1aa95c9-cf74-4fd1-6302-08d753e03ce7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2608:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2608A0954265A411C57318F4F86C0@SN6PR12MB2608.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6506007)(386003)(186003)(2906002)(6512007)(6436002)(6486002)(2351001)(6306002)(3846002)(478600001)(6116002)(5640700003)(7736002)(305945005)(26005)(102836004)(966005)(446003)(76176011)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(11346002)(476003)(256004)(2616005)(52116002)(50226002)(86362001)(6916009)(99286004)(8936002)(81156014)(25786009)(81166006)(486006)(8676002)(2501003)(36756003)(1076003)(5660300002)(4326008)(14454004)(316002)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AQa5hCciifKDo7Al/Q3YxBgRKmaFwj5u4rJ0qBs3Fz29KDx1ZUDr1sYeFwoTBAOUtYtR+qKHy5aVLgISOG1tZvniuXU68yYytzzedKf8JViDO4pVSNuD3/8+jenKvs9449Ns1Ttjvrx1LUwQTFpqI7pbLJZXC43o4fBPi0iradyRhaOHyuAQWehAJyge2ATYOX4auP0HyavEM6HxTAMnABIfPf9xyFOi0cLunEdOFBEikzCdmgF5yB2mIRlGYAHI26AMLroE2H4IsjXGAN3biKkc7FWazslHbgCgk8VtgayjY1Jmz4KKzt4o6V9GNk04olRBkka+PwwZNicp6PHhCj92O6uPefbRzRu5Zr0mPbC+DdJO+vMu+uFyBL7viDwEVFCQiBC20c7QBh5gHhfDRmx9+Tv0TNMqGgtMyBJr+6+1NarwoikX9nStZZ5bTiCkEi7m2evwaQ4HWnlbNNPqg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aa95c9-cf74-4fd1-6302-08d753e03ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:25.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh1TOAAqKL3zwPR0SuGRhnPRGM+0wNzTec9WSCHp2xhDbDscCN0I2reHJvXeDDmrgcyM0TvQVSBAZ6+1qcAd/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The struct amd64_family_type doesn't change between multiple nodes and
instances of the modules, so make it global.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com

rfc -> v1:
* New patch based on suggestion from Boris.

 drivers/edac/amd64_edac.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c1d4536ae466..b9a712819c68 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -16,6 +16,8 @@ module_param(ecc_enable_override, int, 0644);
=20
 static struct msr __percpu *msrs;
=20
+static struct amd64_family_type *fam_type;
+
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
=20
@@ -3278,8 +3280,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 	}
 }
=20
-static void setup_mci_misc_attrs(struct mem_ctl_info *mci,
-				 struct amd64_family_type *fam)
+static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt =3D mci->pvt_info;
=20
@@ -3298,7 +3299,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info =
*mci,
=20
 	mci->edac_cap		=3D determine_edac_cap(pvt);
 	mci->mod_name		=3D EDAC_MOD_STR;
-	mci->ctl_name		=3D fam->ctl_name;
+	mci->ctl_name		=3D fam_type->ctl_name;
 	mci->dev_name		=3D pci_name(pvt->F3);
 	mci->ctl_page_to_phys	=3D NULL;
=20
@@ -3312,8 +3313,6 @@ static void setup_mci_misc_attrs(struct mem_ctl_info =
*mci,
  */
 static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 {
-	struct amd64_family_type *fam_type =3D NULL;
-
 	pvt->ext_model  =3D boot_cpu_data.x86_model >> 4;
 	pvt->stepping	=3D boot_cpu_data.x86_stepping;
 	pvt->model	=3D boot_cpu_data.x86_model;
@@ -3420,7 +3419,6 @@ static void compute_num_umcs(void)
 static int init_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct amd64_family_type *fam_type =3D NULL;
 	struct mem_ctl_info *mci =3D NULL;
 	struct edac_mc_layer layers[2];
 	struct amd64_pvt *pvt =3D NULL;
@@ -3497,7 +3495,7 @@ static int init_one_instance(unsigned int nid)
 	mci->pvt_info =3D pvt;
 	mci->pdev =3D &pvt->F3->dev;
=20
-	setup_mci_misc_attrs(mci, fam_type);
+	setup_mci_misc_attrs(mci);
=20
 	if (init_csrows(mci))
 		mci->edac_cap =3D EDAC_FLAG_NONE;
--=20
2.17.1

