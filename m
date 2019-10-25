Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AABE55AE
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfJYVNo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Oct 2019 17:13:44 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47952 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbfJYVNm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Oct 2019 17:13:42 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PL4wJP002441;
        Fri, 25 Oct 2019 14:13:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=alv8lMLezuhf5zRTdooIWkFvYtE1isVHVh5DpsYsdEU=;
 b=SDYIpoR03uNx7t5VHTXCAK/a4nDCwVXwHmfuhPDx0nGR+6o4vjWgAFu8+EBIbI7y/C70
 zqJcWjRu9PiUZgYoCApacfwXMaBMU50w3Z25IuMYKcVcIgxP01yy/0zfDEqceFM+0/Fq
 rzsAPGfeR+YX3MMkkFIq+HgPrzMeb9+4GMeJkxoraXZJjYpcoDdwlbbnkZFHKM5Gj5pm
 nw7nqDZ6MvRx+DWyEZYp7QdG/0ba7mNR4+5Ap0ISPzyjmtdBiEXrnkO4708nkMU/J2J+
 +nIECzU5LU1DmgWARv0F4pRKsB6j7MuH5k82DAwkE3Pk7gpgc+Dt4DUivZKEqHzpjam2 FQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vt9u5x0c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 14:13:18 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 25 Oct
 2019 14:13:16 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 25 Oct 2019 14:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfZnF8EAIE/LN2ighPKBx1U2vEk70XfnA1bNJU1NUTOi4dwKBvuKFl18U4TsfiJ+hMq+V7PiSip9Fzsc0lbV7F5YnBHG7qEHbUg6OS9rvmSgSpi8a6wpd4hiV/6qwMiv/9efFgMvcw0+s3+PfPTreAOMRaagLQtL+y4U/OVjvLixdNZAwENpPab8UXLV6edPcvqkfEfMxRmkEnDiPUwcl6lpK+RRvPOfvazwfDpTaJpusJ6d+WEnXsALP1X0oYwgQAdFPxIdnpg/VcmPPmuBj/RNpZk8QOVTnW6LNjW7If20+JA/I7BEX01V4FMgiSyyj48miu0iLYS13AQnUHnF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alv8lMLezuhf5zRTdooIWkFvYtE1isVHVh5DpsYsdEU=;
 b=XGX0ozQCYG+P0yOFLuzvdOBX0+ukbTSqgTv6wCWzWflLUyjkxGKnrIYPGR99GNKZXGYXItAE2Fj7Tt5Ta8rIS0MDN+C3yNLNkGHV4QdtKzl0Vf1f3zYqgjBkOLxBF8KPSIIIw0w4Unyi9dpgeWtAduLRy8lLc33xtVDng329VVN6NECrartQK5ixvNCGRMqM1UkvwdxAqvsAJqPk/UeWTOGqu5bo8USfWlLztA6jIHlxaNqiFvEMzluuD9P9q858TycuLGchoJw/Uec6D5I4DxAS4lVcgOPaR7HFY15UPxqG/Nv2IUisbzcOUWb01l1FMhtHd57FSj7PzHwYY5g6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alv8lMLezuhf5zRTdooIWkFvYtE1isVHVh5DpsYsdEU=;
 b=CZGOiLYDFfWzecn44q05c91k+MLApkwT2SpV7Z0MNo5bkxiPwfV4pMt0g2AMf1uk84n7wJ35PPih8K/kOR+W+LEKQ+eHASMCEx4jp8QmP9acq5V1NrqN7clJzflpT6pSzKVlI+1rh2566miCkwwZNzjjLtuZoLcE02pcEAQnrl0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3184.namprd18.prod.outlook.com (10.255.86.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 21:13:14 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2387.025; Fri, 25 Oct 2019
 21:13:14 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Thread-Topic: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Thread-Index: AQHVi3kDo5NTSb0rUkKKo7bz8+V/lg==
Date:   Fri, 25 Oct 2019 21:13:14 +0000
Message-ID: <20191025211226.2444-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0286.eurprd05.prod.outlook.com
 (2603:10a6:7:93::17) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f47637-214c-4ec3-5dc0-08d7599025fb
x-ms-traffictypediagnostic: MN2PR18MB3184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3184FCFAB55C37AA45F01083D9650@MN2PR18MB3184.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(6436002)(26005)(5660300002)(14454004)(305945005)(7736002)(186003)(25786009)(52116002)(8676002)(110136005)(71200400001)(81156014)(66066001)(54906003)(102836004)(86362001)(81166006)(476003)(66946007)(6486002)(50226002)(66556008)(316002)(66446008)(64756008)(66476007)(1076003)(486006)(71190400001)(4326008)(2616005)(6506007)(386003)(14444005)(3846002)(6116002)(478600001)(2906002)(8936002)(36756003)(99286004)(6512007)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3184;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dH58D6I10FQMKBXBlPWYgmtUNr3GIEjtEh0COiSgel1bWjqb/DXGraUE6erkAFESBwEjodbxqb+10yDHljs7Yc3X8xMMZxEYnX+kJfp5cLmox2Z+cBWC7tiLkVvKObTKqU9LKS509id06wLAecjC19rOkllh9H5FemihPd2djlFlq2VQYd56YbWgUuPjlWafH+sZQO4FODn9ZJmYksREmtr6vqE+EVYdEca/+fuZVKqYwaSPMcyUVKGmvIzVYfIcgRQJVjvO7N1rvHqnIVL9kuKQXkX94Zmbs1pjlX3yospPYztZ4X6Richln7gMGQuuOtIgmaZAXfkEEIJgAWCpICWtipM4MYI3oxWU4Rn8xc0+mEhhVe4yiDPDo5j9BeFy+mjAv4RfY8MBNRTjXziDLFf1iJ5H0dbXH9yO9IWzITT2exQZTGvGWPX8yeAruQxW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f47637-214c-4ec3-5dc0-08d7599025fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 21:13:14.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bT3CM/IcPcVN4CHN9iK896lU9MLI/bHLsBIpTQyjj5UvDjeF6oPaRX19XJegwkKK5A5y5p89oP3nODSLV81V3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3184
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_10:2019-10-25,2019-10-25 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ghes registration and refcount is broken in several ways:

 * ghes_edac_register() returns with success for a 2nd instance even
   if a first instance is still running. This is not correct as the
   first instance may fail later. A subsequent registration may not
   finish before the first. Parallel registrations must be avoided.

 * The refcount was increased even if a registration failed. This
   leads to stale counters preventing the device from being released.

 * The ghes refcount may not be decremented properly on
   unregistration. Always decrement the refcount once
   ghes_edac_unregister() is called to keep the refcount sane.

 * The ghes_pvt pointer is handed to the irq handler before
   registration finished.

 * The mci structure could be freed while the irq handler is running.

Fix this by adding a mutex to ghes_edac_register(). This mutex
serializes instances to register and unregister. The refcount is only
increased if the registration succeeded. This makes sure the refcount
is in a consistent state after registering or unregistering a device.
Note: A spinlock cannot be used here as the code section may sleep.

The ghes_pvt is protected by ghes_lock now. This ensures the pointer
is not updated before registration was finished or while the irq
handler is running. It is unset before unregistering the device
including necessary (implicit) memory barriers making the changes
visible to other cpus. Thus, the device can not be used anymore by an
interrupt.

A refcount is needed. There can be multiple GHES structures being
defined (see ACPI 6.3 specification, 18.3.2.7 Generic Hardware Error
Source, "Some platforms may describe multiple Generic Hardware Error
Source structures with different notification types, ...").

Another approach to use the mci's device refcount (get_device()) and
have a release function does not work here. A release function will be
called only for device_release() with the last put_device() call. The
device must be deleted *before* that with device_del(). This is only
possible by maintaining an own refcount.

Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller=
")
Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove pat=
h")
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 78 ++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0bb62857ffb2..622e4dde51c3 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -29,6 +29,9 @@ struct ghes_edac_pvt {
 static atomic_t ghes_init =3D ATOMIC_INIT(0);
 static struct ghes_edac_pvt *ghes_pvt;
=20
+/* GHES registration mutex */
+static DEFINE_MUTEX(ghes_reg_mutex);
+
 /*
  * Sync with other, potentially concurrent callers of
  * ghes_edac_report_mem_error(). We don't know what the
@@ -79,9 +82,8 @@ static void ghes_edac_count_dimms(const struct dmi_header=
 *dh, void *arg)
 		(*num_dimm)++;
 }
=20
-static int get_dimm_smbios_index(u16 handle)
+static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
 {
-	struct mem_ctl_info *mci =3D ghes_pvt->mci;
 	int i;
=20
 	for (i =3D 0; i < mci->tot_dimms; i++) {
@@ -198,14 +200,11 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt =3D ghes_pvt;
+	struct ghes_edac_pvt *pvt;
 	unsigned long flags;
 	char *p;
 	u8 grain_bits;
=20
-	if (!pvt)
-		return;
-
 	/*
 	 * We can do the locking below because GHES defers error processing
 	 * from NMI to IRQ context. Whenever that changes, we'd at least
@@ -216,6 +215,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
=20
 	spin_lock_irqsave(&ghes_lock, flags);
=20
+	pvt =3D ghes_pvt;
+	if (!pvt)
+		goto unlock;
+
 	mci =3D pvt->mci;
 	e =3D &mci->error_desc;
=20
@@ -348,7 +351,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 			p +=3D sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
=20
-		index =3D get_dimm_smbios_index(mem_err->mem_dev_handle);
+		index =3D get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
 		if (index >=3D 0) {
 			e->top_layer =3D index;
 			e->enable_per_layer_report =3D true;
@@ -443,6 +446,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 		       grain_bits, e->syndrome, pvt->detail_location);
=20
 	edac_raw_mc_handle_error(type, mci, e);
+unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
=20
@@ -457,10 +461,12 @@ static struct acpi_platform_list plat_list[] =3D {
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
 {
 	bool fake =3D false;
-	int rc, num_dimm =3D 0;
+	int rc =3D 0, num_dimm =3D 0;
 	struct mem_ctl_info *mci;
+	struct ghes_edac_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
+	unsigned long flags;
 	int idx =3D -1;
=20
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -472,11 +478,14 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
ce *dev)
 		idx =3D 0;
 	}
=20
+	/* finish another registration/unregistration instance first */
+	mutex_lock(&ghes_reg_mutex);
+
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
 	 */
-	if (atomic_inc_return(&ghes_init) > 1)
-		return 0;
+	if (atomic_inc_not_zero(&ghes_init))
+		goto unlock;
=20
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
@@ -494,12 +503,13 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
ce *dev)
 	mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_e=
dac_pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
-		return -ENOMEM;
+		rc =3D -ENOMEM;
+		goto unlock;
 	}
=20
-	ghes_pvt	=3D mci->pvt_info;
-	ghes_pvt->ghes	=3D ghes;
-	ghes_pvt->mci	=3D mci;
+	pvt		=3D mci->pvt_info;
+	pvt->ghes	=3D ghes;
+	pvt->mci	=3D mci;
=20
 	mci->pdev =3D dev;
 	mci->mtype_cap =3D MEM_FLAG_EMPTY;
@@ -541,23 +551,47 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
ce *dev)
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
 		edac_mc_free(mci);
-		return -ENODEV;
+		rc =3D -ENODEV;
 	}
-	return 0;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt =3D pvt;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	/* only increment on success */
+	atomic_inc(&ghes_init);
+
+unlock:
+	mutex_unlock(&ghes_reg_mutex);
+
+	return rc;
 }
=20
 void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
+	unsigned long flags;
=20
-	if (!ghes_pvt)
-		return;
+	mutex_lock(&ghes_reg_mutex);
=20
 	if (atomic_dec_return(&ghes_init))
-		return;
+		goto unlock;
=20
-	mci =3D ghes_pvt->mci;
+	/*
+	 * Wait for the irq handler being finished.
+	 */
+	spin_lock_irqsave(&ghes_lock, flags);
+	mci =3D ghes_pvt ? ghes_pvt->mci : NULL;
 	ghes_pvt =3D NULL;
-	edac_mc_del_mc(mci->pdev);
-	edac_mc_free(mci);
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	if (!mci)
+		goto unlock;
+
+	mci =3D edac_mc_del_mc(mci->pdev);
+	if (mci)
+		edac_mc_free(mci);
+
+unlock:
+	mutex_unlock(&ghes_reg_mutex);
 }
--=20
2.20.1

