Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A689E0D4D
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfJVUfO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:14 -0400
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:62979
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729810AbfJVUfO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R08m2pNNv8J7oEFIVpTBd62bgz8ztAGCoSfktIyetGllnPy5IK1yBYq9akLESEJYbTiz8msUzvroysZnW2vzcEBCZT4HI2z7oirj/qkLr9Lv0l2uQJGZPFO1QUK1jP4H/i91UwAjx2JyIcub2BPfJbyA96BcYw5dme+aYf0ttXl3+U31kevxytWCq/AX/cMXWwViIOcpRicDwCOgqcvolteR3PVI+1gqvyR1esSBJos2VvQftwoTysCGZenYHXjuNz3kGGX9K0HJDkgGEJSsYVL4v25vkEW0qJiwZTLubKpGiKd68seB7F9lkjuBBCFdTsoWl9gqDNadb47MctCXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq82o3FgHVKRzVw1/5MctqnCCsJnOPGhbY5Y87iN/fc=;
 b=XKFcHooh+8bBfFcFJBPDurRPXXtzHSQSOoFZN3nAs/Y4xYOQWUL/DGUGNKIrBpnk7vedbTa5SV0j85sLDuSNCuDIpr8V3WwPmDTuTerKUAW8nkwabjjXQwo3/Pv6DGxFi/D7rkHtu3r3C9JvIquTjJOCQWjtWlHD+HwZI0ZNN7QzJ21p+XiinjH/Vt43sitXh7IMJrDvKMWTcspNbgOp/uJ4xxYxL9pDhsvLHxvLya7Y/tpM0qbCeyyFXcAAZzlijwfzGwstsjhCRSRKP2AKfGtNw+XAq7dKm0iUuZvwDj6Oxatf9o6mlCiQKicgiEgd3H6uekrvKCzpUwgAy30lXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq82o3FgHVKRzVw1/5MctqnCCsJnOPGhbY5Y87iN/fc=;
 b=RzPdn86fj5yvSui/Dn9sKEkawQaawDSN3nU1+ynltYNmOWxu7lD9iBkTycMwk3jxMTWPpyMzzJAISdSOEsl5A2NIu2ZIBcBf5WSN3yBEWMbzc75lZkBpGsmy+eJGsIzH2wViwkAwy+x+ZG3kEFlFTl62fVfKdkJwAAmjDGdMZEA=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 22 Oct 2019 20:35:10 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:10 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 1/6] EDAC/amd64: Make struct amd64_family_type global
Thread-Topic: [PATCH v2 1/6] EDAC/amd64: Make struct amd64_family_type global
Thread-Index: AQHViRgyvXbCdcnQ7Uid7ACBemIPaA==
Date:   Tue, 22 Oct 2019 20:35:09 +0000
Message-ID: <20191022203448.13962-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 8aa48e0a-28f7-424d-18a8-08d7572f54cf
x-ms-traffictypediagnostic: BN7PR12MB2723:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB272343BCFDCED527778ADD46F8680@BN7PR12MB2723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(6306002)(476003)(2616005)(26005)(102836004)(186003)(966005)(6436002)(81166006)(81156014)(52116002)(99286004)(50226002)(6512007)(11346002)(486006)(446003)(8936002)(36756003)(6486002)(305945005)(8676002)(7736002)(2501003)(14454004)(5660300002)(478600001)(4326008)(25786009)(2351001)(316002)(2906002)(54906003)(6116002)(86362001)(256004)(66066001)(1076003)(5640700003)(66946007)(6916009)(6506007)(66476007)(3846002)(66446008)(71190400001)(71200400001)(64756008)(66556008)(386003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2723;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAKOe4eDL9JpaUInupjmvnYs0T8OXW28DKsNDIE8leLn2XqhyFA7VI4QuiZEIYxqRTHROpP0fnE9Yr9IVviANlLj0vpQ39zL2f8pS04850zvi4CWcLrY0HG5WjKwsBYEG5VcTToqTffuh9LINjzhT0XequjfFRtC8s7GvJlUqa3By/7+Dx2z/eHx57SntNXjLGzm7hqBeZ4TFu06+oHnf0avVcgjlVwW+C49j3+FoxlwfFByDRKomNIiou9VRMCRDi2LgfQwTSAnj7UU97kOS2xGRPHLxNKENVKJH96BR43w/UbFKhl0zmFNOvQ9kfCCKuIBhThWhwRg7PmZCMCr/LnPw5p4mhRZU8aTn0CRJfRNEs0PgKlDbf8hxTVSI5CqQXbKYYg/7Nzetb57K1wUKMojAx8CRfcsj9ehqBIiee900KdjuzMmForklx6XxHAuejc3BAiqTvhce2HC1SnETKumz+WaVGFL50E1/VdgHfc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa48e0a-28f7-424d-18a8-08d7572f54cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:09.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFkoY54KAaFROg6KPvQLhdDDMKw9MF4IwLPfBOU+P50+oYOy5bgtnXeOniDmxe7AG3IcMKLEC8CVS/qc9TS9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2723
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
https://lkml.kernel.org/r/20191018153114.39378-2-Yazen.Ghannam@amd.com

v1 -> v2:
* No change.

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

