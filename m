Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D86113E43
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfLEJie (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:34 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33878 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729334AbfLEJi1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:27 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59avmE023516;
        Thu, 5 Dec 2019 01:38:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3tdpFpv3ZBKv1Ksv8LHJfN2lvKqPAq4IheciwUcOxEM=;
 b=xvCl0HrSASP+Lzt5qxmQIze+KJQTVSBDVCL6HiXlYeYBfz2XmNbJC+o57Dtz8jvofSKv
 2IvEy80N+17jhBBeee/S3ZR0Lo3KcCO1LjKVQvjYShQEiUzMvPM9CiLsZkis5xYewDWz
 XoR8cCIF5lE/EnvYvhfr8aH20wGmno2JRAoZ2qRRcdrAXRDqbu8mlC7+gwdLr2HzHO+B
 REd2Jr0rNN2fFS+lEYxP0XJqbGpZL8S1MrpRvT/Sc70QDYiB1xYUP5FylLlcIWYr42Sp
 xYYsoUVyQmz37UbQW3LEi9PR60fnSzlsrmCqRTo+z3JMRZTAq0WDuo0bWMyMIHQ0xIKm tA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:20 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:19 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9F0kCgQm/SbrGgtWieeFkQLt0/CRlZDE3dF7o0Q0i8yP6G5YXiXCnqoXDRvneKkCZ4LgBjNh0MeGXfU7hepjspZp9Gt8kePVzEk8iLko7xulw1oLsTkckgasxBP3XipKwr6fER8nlEwF5IxWKDWPhzFlUCMpTtkt8UoyBFrxgjBDVatHzU2DTJF6auRZef9sUxoaf1v6h2afsPY5n/31vHDBojhz9iIxmf76HMpMl9A/6c42W2ZgnX9S7fu8dq+COhT46Cp0t7fTkLQoycB5eapFXW5pU5ojebHR1BHjBldUtsHFfcpO0KAMBuj8BoxHqQuU8oEWAgLl4PCApa6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tdpFpv3ZBKv1Ksv8LHJfN2lvKqPAq4IheciwUcOxEM=;
 b=V8/M1mOlpPJ5MLdq7FO3ZTC9XJmHvkGtSrpyNydLIH3griGNQxMoXKaR/fs6CIrH8a7M0mNVq/9/drJetldEru0VWlBvk/Lgho+en8JD4SRfdC7TTw4z5wIzYy74R12Onm/6KwAAXG5Lc4KwkxPx4ebdeoTdhLJU+88hCwyE46G2gQjh9Y2mNARpNvDN1iyhclQlLyNmhuxMcqF3lX8IwPMmUTS7SVeXATuA/S+sq9q+maP66xxaEBy8voG19/0n2uSpmB+qEZMHvTrEcJ2RsywvDMepsC+4z0Rpx6v9lZEHkoGSknlFH1+icpnVkjJGEEaXGjAOFj5cBqPoR59+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tdpFpv3ZBKv1Ksv8LHJfN2lvKqPAq4IheciwUcOxEM=;
 b=i5DYS75/PxVnQCNgy5bcLaDrRDfmI+9SnLgfnryfpKnM8vwgnvDqK5BBbEE6gBdxlpZZz6dsuxu+PG6eoIQ0XpgeFYO/wA9P3ILBmgu7V5mqB67FTdwtaOSYilBH4W+fk2RTDGuwW8NhdWdFJ9vU1+ZSaK/EJiSdrEXCsfrwUx0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:16 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] EDAC/mc: Remove per layer counters
Thread-Topic: [PATCH v2 10/10] EDAC/mc: Remove per layer counters
Thread-Index: AQHVq0+4oLwVZKl/g0Gb4piwHzHE7g==
Date:   Thu, 5 Dec 2019 09:38:16 +0000
Message-ID: <20191205093739.4040-11-rrichter@marvell.com>
References: <20191205093739.4040-1-rrichter@marvell.com>
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc51215d-78e3-476b-a927-08d77966daee
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB23672517B057276B57892205D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRdDI2yEgogOfsyjJIEIoeYaCu7AVY+Z0nV+aPT3vF7jQsyVBeGTFA2PEG3WzMSnS2pa1qtnyhk33d6xYtge5LGPMKIdHp+pLALLtqp3A8DxC7gmx/l8KLr7tOdzrlO8epYB/cnq5OBVhU7UiLkX9oMzLf9Yqxl4TjNPYCOoGdKicE3sLz8b9FK56Nd3iBUIxw/TENo1Mh5vI4IDnBmSW0EfRMckF11N5bVuKkv0ordPwcpobJUQKiMzLW8SX/PWmR90OEYXhgB8S0bMs/yjwWyIr5vUF7dG1XdjtqeEyRBAYGQ9I0BzLX4QbuEcNiRL56GhcWPXvl9/qRHBc1bGPc32PT2v9fSE8srsbvKuIlVMK+Thu7trHLkPpm3W72pQOuUp7V/a7NxZOHWqNwEP5bVXzwlIoPIjmXlwQzrFNfepODyDZDKJmE8V57SsYuuS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51215d-78e3-476b-a927-08d77966daee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:16.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40+6m1feOgKrPRMSYcKU9KHbm93lI3mUHmFXxuZL1EkPC0V/hie3XDNsiAxcW28rTnMAWV0L/6oSi8Wk4OnVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
turns out that only the leaves in the memory hierarchy are consumed
(in sysfs), but not the intermediate layers, e.g.:

 count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];

These unused counters only add complexity, remove them. The error
counter values are directly stored in struct dimm_info now.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 65 +++++++++---------------------------
 drivers/edac/edac_mc_sysfs.c | 20 +++++------
 include/linux/edac.h         |  4 ++-
 3 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 5ea834fceb50..3d43b9fe8171 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -445,11 +445,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
-	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
-	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
+	unsigned int idx, size, tot_dimms =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
 	void *pvt, *ptr =3D NULL;
-	int i;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -476,19 +474,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	 * stringent as what the compiler would provide if we could simply
 	 * hardcode everything into a single struct.
 	 */
-	mci =3D edac_align_ptr(&ptr, sizeof(*mci), 1);
-	layer =3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
-	for (i =3D 0; i < n_layers; i++) {
-		count *=3D layers[i].size;
-		edac_dbg(4, "errcount layer %d size %d\n", i, count);
-		ce_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		ue_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		tot_errcount +=3D 2 * count;
-	}
-
-	edac_dbg(4, "allocating %d error counters\n", tot_errcount);
-	pvt =3D edac_align_ptr(&ptr, sz_pvt, 1);
-	size =3D ((unsigned long)pvt) + sz_pvt;
+	mci	=3D edac_align_ptr(&ptr, sizeof(*mci), 1);
+	layer	=3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
+	pvt	=3D edac_align_ptr(&ptr, sz_pvt, 1);
+	size	=3D ((unsigned long)pvt) + sz_pvt;
=20
 	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)=
\n",
 		 size,
@@ -504,10 +493,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 	 * rather than an imaginary chunk of memory located at address 0.
 	 */
 	layer =3D (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer)=
);
-	for (i =3D 0; i < n_layers; i++) {
-		mci->ce_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ce_per_la=
yer[i]));
-		mci->ue_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ue_per_la=
yer[i]));
-	}
 	pvt =3D sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
=20
 	/* setup index and various internal pointers */
@@ -949,48 +934,28 @@ static void edac_inc_ce_error(struct edac_raw_error_d=
esc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ce_mc +=3D e->error_count;
=20
-	if (pos[0] < 0) {
+	if (dimm)
+		dimm->ce_count +=3D e->error_count;
+	else
 		mci->ce_noinfo_count +=3D e->error_count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ce_per_layer[i][index] +=3D e->error_count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_inc_ue_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ue_mc +=3D e->error_count;
=20
-	if (pos[0] < 0) {
+	if (dimm)
+		dimm->ue_count +=3D e->error_count;
+	else
 		mci->ue_noinfo_count +=3D e->error_count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ue_per_layer[i][index] +=3D e->error_count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_ce_error(struct edac_raw_error_desc *e)
@@ -1137,7 +1102,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/*
 	 * Check if the event report is consistent and if the memory
 	 * location is known. If it is known, the DIMM(s) label info
-	 * will be filled and the per-layer error counters will be
+	 * will be filled and the DIMM's error counters will be
 	 * incremented.
 	 */
 	for (i =3D 0; i < mci->n_layers; i++) {
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..8682df2f7f4f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -556,10 +556,8 @@ static ssize_t dimmdev_ce_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ce_count);
 }
=20
 static ssize_t dimmdev_ue_count_show(struct device *dev,
@@ -567,10 +565,8 @@ static ssize_t dimmdev_ue_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ue_count);
 }
=20
 /* dimm/rank attribute files */
@@ -666,7 +662,9 @@ static ssize_t mci_reset_counters_store(struct device *=
dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci =3D to_mci(dev);
-	int cnt, row, chan, i;
+	struct dimm_info *dimm;
+	int row, chan;
+
 	mci->ue_mc =3D 0;
 	mci->ce_mc =3D 0;
 	mci->ue_noinfo_count =3D 0;
@@ -682,11 +680,9 @@ static ssize_t mci_reset_counters_store(struct device =
*dev,
 			ri->channels[chan]->ce_count =3D 0;
 	}
=20
-	cnt =3D 1;
-	for (i =3D 0; i < mci->n_layers; i++) {
-		cnt *=3D mci->layers[i].size;
-		memset(mci->ce_per_layer[i], 0, cnt * sizeof(u32));
-		memset(mci->ue_per_layer[i], 0, cnt * sizeof(u32));
+	mci_for_each_dimm(mci, dimm) {
+		dimm->ue_count =3D 0;
+		dimm->ce_count =3D 0;
 	}
=20
 	mci->start_time =3D jiffies;
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 815f246e0abd..0f20b986b0ab 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -383,6 +383,9 @@ struct dimm_info {
 	unsigned int csrow, cschannel;	/* Points to the old API data */
=20
 	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
+
+	u32 ce_count;
+	u32 ue_count;
 };
=20
 /**
@@ -559,7 +562,6 @@ struct mem_ctl_info {
 	 */
 	u32 ce_noinfo_count, ue_noinfo_count;
 	u32 ue_mc, ce_mc;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
=20
 	struct completion complete;
=20
--=20
2.20.1

