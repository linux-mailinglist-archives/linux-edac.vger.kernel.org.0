Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898CEA561F
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfIBMeI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:34:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47024 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731650AbfIBMd6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:33:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CUjqa029663;
        Mon, 2 Sep 2019 05:33:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=p8D0+yn2GU0s+KGko5wJ4F5JGoNvubsQ8oGhq8GWBbI=;
 b=Qm6ocUp0m3o4htXx7cZSsYWK/FD0Ct0y1HVRQ8Tcjs8LrO3R66OD/ykvaXmL9laf1aQ8
 nqp7dUvcuESI4md56CIHRH/YM2O7A0suaghwqLtYOfazcLUNni1zbuDYZJ3qYXya1r5H
 X92XtbBvVWYjss9/dEssZf8RvGxlZt72lLuKoWIMIlYotL2AcX4Or1nE1zstjZTadBLK
 EuCpkG9OZs4hOmxfc1kOZ6ym4EVzJ27TIZkg938HCk/VlWZXuVbVq4hY8oQ+IEmJJeZ0
 h95rrWQwPmLXLOm74VIah4WZv2D4ftuAnGmk0x/c0KFc+Kn1b81wqxA3CP5tWYVAXsfg Iw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm603h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:51 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:48 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMAzWu02y3apWDvqPsXANamSFvgEFkTxxUla9aQIJWqOsuYmKBDnz8Gxno+DpXFWfgrMp3IifZwIFtAESd4dSLofHdn/rGMTLAWnjz4500zVMn82e6HYPrGyT7srZWNLM6oU1FVBMK6b0UXL/EerMvkHlvqOa82B5wd+tP9olr6mB/p8BbU1uPb003u0TY+I0GXOfnT3E8VrQeffHqkUq0Fg5FTvmdOiVk83c4eVM0mFPi2KArGPzv9wADiBwd801SIw5FnuqfLX3RCGPE5KKwugjWXVGO7bhWZR+K6CD6vYSNFgwSsPMYD78CdbDtxSsr6FFKfFXsBZGHTmh9/OKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8D0+yn2GU0s+KGko5wJ4F5JGoNvubsQ8oGhq8GWBbI=;
 b=fOZ716BQZZssZy1aL8ftW2Hf1sz8/2Z7oiAMsTsQY6ghvvl6/keqFAHHSGaTiLprrEbTCWCvRfUSGd6+1+OugOW2nvjqem2zTfXhUpUPCS8hzbLG6weAHx+iVnJ9nJrw23mUIUsFJMLoEPBU/JtgTM/FAw/Wnb0/Zyb5sTdrSJmS9rn7ccLnCGh/DN1tRJ+crz7e5ifi3XJ6LY20PYhE+WGUlKN4SkATRkpzWyFSCTznkWXKWwuTYfcHoSlE2tqr10vfdwPdaEtiyoe0Wh7fEYNktirKx9eRWhKGWOpzxFjHV+m34eWqZQETFfRJZB/aktB2bMIQvj16V0xgujG+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8D0+yn2GU0s+KGko5wJ4F5JGoNvubsQ8oGhq8GWBbI=;
 b=S5mlK+HepaY1GfLpzsCTcgxTZWljGwqha5PhCck5OurrnpZt59iLnIWfDuoHGCeBe1myi/lU14ndzTu2DMCqeSAbIDnbSvRkCYo5HuzciZ5cy0PiUkSMIFJ4xPzwX+HfjCHzCGufkMQ72q8gtxMR527XLSAFoBN2oTfVV8ruY+o=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:47 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:47 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] EDAC, mc_sysfs: Make debug messages consistent
Thread-Topic: [PATCH 4/5] EDAC, mc_sysfs: Make debug messages consistent
Thread-Index: AQHVYYqq19hRVbKeJkGLaGszT0mThw==
Date:   Mon, 2 Sep 2019 12:33:47 +0000
Message-ID: <20190902123216.9809-5-rrichter@marvell.com>
References: <20190902123216.9809-1-rrichter@marvell.com>
In-Reply-To: <20190902123216.9809-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:7:66::13) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b7612c-2c7f-4d14-75f3-08d72fa1ccf4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24809D52AFE5B212727E8101D9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(26005)(6512007)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(14444005)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(11346002)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(446003)(66946007)(25786009)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: toAODxe6CyUXRsIE9/oMcAhDO/oyJHzUbKJDlbKYPzic5lyaBDBspCcNa0EZhFa5TbJwF3pocCvotSe3lClEnFUY1J533+BAmyqYmtkzitQ9EdzbXmTbwv4eb1wfgtOV3sapGohPdf3trgyDkAp3XDGWvnbUUSuHUGqfZuW42IdRA0T15C12fCqZFn/ulkSO/p1uU65P8wysF8C37vU+Jzd7qrfSug3N9uQU7ZLQ0sFtYm7Rpb1WHiV6NN64cLq47eA458qQUsfzcwpV/BHcCD8ohjv+y9SZQUKBPOrtkNMp52+1xqR8xx3PSzcskdESV9MBKrZL4JkHwGKq+lAMunDOGqAevhTun5valZB6U1yixmXi5cQDcUj4GmyMtSn64i3w2ubRW67dfEmPBboFIO39QBvdM0hk62k12wU9jic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b7612c-2c7f-4d14-75f3-08d72fa1ccf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:47.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IomEikX3ELtg3+Epm7uZoEiyAq0Q3o8X0WcYKWM2YCTw3oJVgqdEHJfotS+aDzAy5B8InFrM4deymDn7W/QFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Debug messages are inconsistently used in the error handlers. Some
lack an error message, some are called regardless the return status,
messages for the same error are at different locations in the code
depending on the error code. This happens esp. near put_device()
calls. Make those debug messages more consistent. Additionally, unify
the error messages to have the same terms for the same operations of
the device.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc_sysfs.c | 63 +++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 309fc24339b0..eaccde3fc1b8 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -278,7 +278,7 @@ static void csrow_attr_release(struct device *dev)
 {
 	struct csrow_info *csrow =3D container_of(dev, struct csrow_info, dev);
=20
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
+	edac_dbg(1, "device %s released\n", dev_name(dev));
 	kfree(csrow);
 }
=20
@@ -414,14 +414,16 @@ static int edac_create_csrow_object(struct mem_ctl_in=
fo *mci,
 	dev_set_name(&csrow->dev, "csrow%d", index);
 	dev_set_drvdata(&csrow->dev, csrow);
=20
-	edac_dbg(0, "creating (virtual) csrow node %s\n",
-		 dev_name(&csrow->dev));
-
 	err =3D device_add(&csrow->dev);
-	if (err)
+	if (err) {
+		edac_dbg(1, "failure: create device %s\n", dev_name(&csrow->dev));
 		put_device(&csrow->dev);
+		return err;
+	}
=20
-	return err;
+	edac_dbg(0, "device %s created\n", dev_name(&csrow->dev));
+
+	return 0;
 }
=20
 /* Create a CSROW object under specifed edac_mc_device */
@@ -435,12 +437,8 @@ static int edac_create_csrow_objects(struct mem_ctl_in=
fo *mci)
 		if (!nr_pages_per_csrow(csrow))
 			continue;
 		err =3D edac_create_csrow_object(mci, mci->csrows[i], i);
-		if (err < 0) {
-			edac_dbg(1,
-				 "failure: create csrow objects for csrow %d\n",
-				 i);
+		if (err < 0)
 			goto error;
-		}
 	}
 	return 0;
=20
@@ -624,7 +622,7 @@ static void dimm_attr_release(struct device *dev)
 {
 	struct dimm_info *dimm =3D container_of(dev, struct dimm_info, dev);
=20
-	edac_dbg(1, "Releasing dimm device %s\n", dev_name(dev));
+	edac_dbg(1, "device %s released\n", dev_name(dev));
 	kfree(dimm);
 }
=20
@@ -653,12 +651,20 @@ static int edac_create_dimm_object(struct mem_ctl_inf=
o *mci,
 	pm_runtime_forbid(&mci->dev);
=20
 	err =3D device_add(&dimm->dev);
-	if (err)
+	if (err) {
+		edac_dbg(1, "failure: create device %s\n", dev_name(&dimm->dev));
 		put_device(&dimm->dev);
+		return err;
+	}
=20
-	edac_dbg(0, "created rank/dimm device %s\n", dev_name(&dimm->dev));
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG)) {
+		char location[80];
+		edac_dimm_info_location(dimm, location, sizeof(location));
+		edac_dbg(0, "device %s created at location %s\n",
+			dev_name(&dimm->dev), location);
+	}
=20
-	return err;
+	return 0;
 }
=20
 /*
@@ -901,7 +907,7 @@ static void mci_attr_release(struct device *dev)
 {
 	struct mem_ctl_info *mci =3D container_of(dev, struct mem_ctl_info, dev);
=20
-	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
+	edac_dbg(1, "device %s released\n", dev_name(dev));
 	kfree(mci);
 }
=20
@@ -933,7 +939,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
 	dev_set_drvdata(&mci->dev, mci);
 	pm_runtime_forbid(&mci->dev);
=20
-	edac_dbg(0, "creating device %s\n", dev_name(&mci->dev));
 	err =3D device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
@@ -941,6 +946,8 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
 		return err;
 	}
=20
+	edac_dbg(0, "device %s created\n", dev_name(&mci->dev));
+
 	/*
 	 * Create the dimm/rank devices
 	 */
@@ -950,22 +957,9 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *=
mci,
 		if (!dimm->nr_pages)
 			continue;
=20
-#ifdef CONFIG_EDAC_DEBUG
-		edac_dbg(1, "creating dimm%d, located at ", i);
-		if (edac_debug_level >=3D 1) {
-			int lay;
-			for (lay =3D 0; lay < mci->n_layers; lay++)
-				printk(KERN_CONT "%s %d ",
-					edac_layer_name[mci->layers[lay].type],
-					dimm->location[lay]);
-			printk(KERN_CONT "\n");
-		}
-#endif
 		err =3D edac_create_dimm_object(mci, dimm, i);
-		if (err) {
-			edac_dbg(1, "failure: create dimm %d obj\n", i);
+		if (err)
 			goto fail_unregister_dimm;
-		}
 	}
=20
 #ifdef CONFIG_EDAC_LEGACY_SYSFS
@@ -1010,14 +1004,14 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_in=
fo *mci)
 		struct dimm_info *dimm =3D mci->dimms[i];
 		if (dimm->nr_pages =3D=3D 0)
 			continue;
-		edac_dbg(0, "removing device %s\n", dev_name(&dimm->dev));
+		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
 		device_unregister(&dimm->dev);
 	}
 }
=20
 void edac_unregister_sysfs(struct mem_ctl_info *mci)
 {
-	edac_dbg(1, "Unregistering device %s\n", dev_name(&mci->dev));
+	edac_dbg(1, "unregistering device %s\n", dev_name(&mci->dev));
 	device_unregister(&mci->dev);
 }
=20
@@ -1028,7 +1022,7 @@ static void mc_attr_release(struct device *dev)
 	 * parent device, used to create the /sys/devices/mc sysfs node.
 	 * So, there are no attributes on it.
 	 */
-	edac_dbg(1, "Releasing device %s\n", dev_name(dev));
+	edac_dbg(1, "device %s released\n", dev_name(dev));
 	kfree(dev);
 }
=20
@@ -1053,6 +1047,7 @@ int __init edac_mc_sysfs_init(void)
=20
 	err =3D device_add(mci_pdev);
 	if (err < 0) {
+		edac_dbg(1, "failure: create device %s\n", dev_name(mci_pdev));
 		put_device(mci_pdev);
 		return err;
 	}
--=20
2.20.1

