Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188DAF053B
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 19:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfKESjy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 13:39:54 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21618 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390423AbfKESjx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Nov 2019 13:39:53 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5IQEjB005050;
        Tue, 5 Nov 2019 10:39:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=E/MliGxLvUXjJ9u9n28yayaSmMfpC2ZVIAEZM+Dag/o=;
 b=QHJ4oo+pm+z4zQGf4rS2ULRd//2Dfte04pTbKkSgf4JtAxcY/NtVMqtDYwOwoFf35Iqq
 icJnxhrl8dvHkOCHLRebYUaq1ISSjF0Zd5wHoUuVtJwj657Xl2fKl4GViRG6z8F9gRr/
 2O0GeX3rONHwivMsN49lzUqX7hJt4cmwej2LdwesJHzk4vW2t1HKP2Ros2Y1NRJ27uiX
 2El1xDy97Qf0qcoGQohVuZ5wR4fvnM2Sp+VAUkb4xMNZM93/tCgY3SYNHArVG3+7epES
 X3w9QUt1+2AxgJTV7KmQcWE4Z1inx7OMrW5pNsERDpNIM6rkxFY8XySQPU+k48id2UhJ eQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w17n94de1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 10:39:36 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 10:39:34 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 10:39:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acNXQCM4/YqO8kRHzPp/0aKreGeiGpeDgoRGEJwRocdkRMKyc/9qDGOO2WvlQ0UZktnAsEcwwhjGS16H0wtIeKajCslItIvKoW4w6xyCqVusTtokkT+wiqjBYnlnMB2eyCBg7vtSot5l4YZo3OHdJnkh4nWrlD3uRUtlwJfbVyiU3khWgRbxlcyJH+KPjr4S3hdeL49mXsqGTjxF1+x9Wo+jkNBKpWiPEyeGWjV07izTw+xB2tW1TVax8wFzc4noohlNo9980Wt0fOhSsDIEFoFHjVtmPsuE6j2RVuC7ykoOAG2kCxlopTtyfcNdn3y8PX5FM04fCPlhbUdwMtSOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/MliGxLvUXjJ9u9n28yayaSmMfpC2ZVIAEZM+Dag/o=;
 b=FXfqIJhRHFGLYMQGBDXVMk+iUATDQEeDGDwpg3QaeUTnIfs+9M0iV4YDdOFdPpaqSY8p3u/qrxo6ezXSNi0p24UCSa5/MHmUHSWr3UXLAvqQrzbLmYwRowmt9wT6qz6nXOk6T2xVyWkoB84hBapaQuQG1dJFEEz755qznjKj0gYyatir5rNuFUYWVu5yNEjh+d2r8DgC4GdPQ6HfaYBwzTZNlF9SlUwXjBCqNvuAV5+yCmzDg2OUTwEIUgDGPSFre3/8oADhBZiaQM//LRC2IAOLW+0Zg8zCOLSJESFSanPrr2f5qRCsZ2w2Ip+pe7uo0YErJ8xCJVwH25HeRsT57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/MliGxLvUXjJ9u9n28yayaSmMfpC2ZVIAEZM+Dag/o=;
 b=oZgpDNoOvqGnWDCiN4NKfS7T1xw1sEWgnyv61c1WVPPfUTYLccv2ZSnbnbuxDYr8AaLdGA2mAQzEZg2wMkZWnKxWzGWz7fB/4jHVQbkzFxVIUGYtF6NYjhN7EuXn8XFikxgM1gI9uH2TvppVoTro3g3OtSEyRbfALFIQPcFkNzE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3389.namprd18.prod.outlook.com (10.255.239.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 18:39:31 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 18:39:31 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] EDAC, ghes: Fix locking and memory barrier issues
Thread-Topic: [PATCH v2] EDAC, ghes: Fix locking and memory barrier issues
Thread-Index: AQHVlAhce/hMrmg3H0iOfbbQAxy3FA==
Date:   Tue, 5 Nov 2019 18:39:31 +0000
Message-ID: <20191105183846.30327-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14733517-23d1-4727-9f23-08d7621f7f0f
x-ms-traffictypediagnostic: MN2PR18MB3389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB338980174D1D522A45A1A71DD97E0@MN2PR18MB3389.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(6506007)(186003)(1076003)(86362001)(25786009)(3846002)(7736002)(256004)(6512007)(5660300002)(66946007)(14444005)(305945005)(81156014)(486006)(66446008)(476003)(8936002)(66476007)(50226002)(64756008)(66556008)(4326008)(6116002)(99286004)(2616005)(36756003)(386003)(6436002)(52116002)(81166006)(2906002)(8676002)(26005)(6486002)(110136005)(14454004)(54906003)(71190400001)(71200400001)(102836004)(478600001)(66066001)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3389;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9sH11u8rTDOGWBsBhztA/ixMNhA7oQNO2iMnrTNyak//OnlE/SWIt6vXJ9kgvRuYtzxU8Tink2kZ2pwOW7kVxuCMVHwsZY0HfOKJiSC/1oWmdEZEw5lrhPYJDKm5zEz2mY13KnU5NkvwaMvOnhwhxt03wYVShOnN9hKDhhP3WdhXQH0hs33+dVdRQ4Eynwaw8MfrOMLc1rzTv0oWgquT7ZkwX7hVVWzbKNIeAZ0UhSmDqdCRjo3cmg7SYC/UYRizcZzBiI0ye7nQwFearTSWusmlGsTai+IMr5kBEyBO9e1Mu6P2y+X/Dn5Otc3J8f1gjkFzfIm52jdvynBO9LC1QqWBJb12/RDCdug+KQ2tbFIw/CZFb92qbEX5O6i9vlDXR2NHnF9ek3v6ic/fbmOzev9PulgNXfSmmK85sWDdTLBoxbbWaU3XTs6bOIK+KMZ2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14733517-23d1-4727-9f23-08d7621f7f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 18:39:31.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZDcAzcrdnzcqnxVHq624Qe9cgYSUkajoBmM+9Urt5fI5L5SzHh0wgu1yFo8bVz3j/c8srU4h90YgoIWw8sFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3389
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_07:2019-11-05,2019-11-05 signatures=0
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

Also, rename ghes_init to ghes_refcount for better readability and
switch to refcount API.

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
Co-developed-by: Borislav Petkov <bp@suse.de>
Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
V2:
 * fixed missing 'goto unlock' in error path
 * fixed SOB chain
 * added comment on how to protect ghes_pvt with ghes_lock
 * renamed ghes_init to ghes_refcount
 * switched to refcount API instead of atomic_*
---
 drivers/edac/ghes_edac.c | 89 +++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0bb62857ffb2..5da85ef7966d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -26,9 +26,18 @@ struct ghes_edac_pvt {
 	char msg[80];
 };
=20
-static atomic_t ghes_init =3D ATOMIC_INIT(0);
+static refcount_t ghes_refcount =3D REFCOUNT_INIT(0);
+
+/*
+ * Access to ghes_pvt must be protected by ghes_lock. The spinlock
+ * also provides the necessary (implicit) memory barrier for the SMP
+ * case to make the pointer visible on another cpu.
+ */
 static struct ghes_edac_pvt *ghes_pvt;
=20
+/* GHES registration mutex */
+static DEFINE_MUTEX(ghes_reg_mutex);
+
 /*
  * Sync with other, potentially concurrent callers of
  * ghes_edac_report_mem_error(). We don't know what the
@@ -79,9 +88,8 @@ static void ghes_edac_count_dimms(const struct dmi_header=
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
@@ -198,14 +206,11 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
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
@@ -216,6 +221,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
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
@@ -348,7 +357,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 			p +=3D sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
=20
-		index =3D get_dimm_smbios_index(mem_err->mem_dev_handle);
+		index =3D get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
 		if (index >=3D 0) {
 			e->top_layer =3D index;
 			e->enable_per_layer_report =3D true;
@@ -443,6 +452,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 		       grain_bits, e->syndrome, pvt->detail_location);
=20
 	edac_raw_mc_handle_error(type, mci, e);
+unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
=20
@@ -457,10 +467,12 @@ static struct acpi_platform_list plat_list[] =3D {
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
@@ -472,11 +484,14 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
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
+	if (refcount_inc_not_zero(&ghes_refcount))
+		goto unlock;
=20
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
@@ -494,12 +509,13 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
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
@@ -541,23 +557,48 @@ int ghes_edac_register(struct ghes *ghes, struct devi=
ce *dev)
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
 		edac_mc_free(mci);
-		return -ENODEV;
+		rc =3D -ENODEV;
+		goto unlock;
 	}
-	return 0;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt =3D pvt;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	/* only increment on success */
+	refcount_inc(&ghes_refcount);
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
-	if (atomic_dec_return(&ghes_init))
-		return;
+	if (!refcount_dec_and_test(&ghes_refcount))
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

