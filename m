Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2EA561E
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfIBMd6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:33:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60692 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729999AbfIBMd5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:33:57 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CVK3X025478;
        Mon, 2 Sep 2019 05:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tRVRI0/pFRdhX0JXwAZAaofoYmWAvzqvKh/DaExNszc=;
 b=scS0ZnFGwuSJMP4lgDYlBOrcVrbdOCcHHp6pEOIuPW5g81t9lsbgSpTgk1ceH6jf3eEE
 d0r6dzoBcfAZVM7s8qNqoBs3h9j33MWSNLz4Hdx4m3DEuuEn5651qyO4RjQbAVYl25Qp
 d9+seRKDjSGAFvBuUGUfk9TVkj7sj5cFxXeyxc+oJosjT9y/pVKHe+sYaKoLzwIk1ML3
 6zgrTxyOPcoz1x5ukqobF6UKPnrcR38NX1+cGGeZ+F37LYvGVhUkCknc5gCLzOdELQbz
 zqE++gjqEjUcs/5b0mhJMYe72uTDpH43ShG5aqRruCuknQRoLlxiRAsAdlTr8MEVvmSd Ww== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p6jh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPcsxi0Thq9iGxL9L+B+tDFY9aHYSm2JLZU0ooPxmFN4MoH7anDRB6Jv/QVu/dfue3pugaHpNa4lgeZ3Wk7fMjDPHr9DpcFh1ZYQQCvNsICAFHfZW1z91eoZmU8J+BUyUMZON/nHhvYVBKxPCh71MeG2oWUEE98OqJngPCxxwcJIai95LgTDZxSOZ7JMiIoxkRQUezo/kfI4bbv8jUoXafC3EEadM8vyfzjHG53RvASkYewG+6uWo83iVaVJ7zeOfHgHVMpVIwi25Y+GvexySPL0nI/7pxFVqnzl5WMDcCLtuUoEubI7utHUaohGb+JX+vPzFAH610SZwp6yRTGODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRVRI0/pFRdhX0JXwAZAaofoYmWAvzqvKh/DaExNszc=;
 b=a/beXXcFKhE7f8fPcT08hA05BfU3pq2Orxu/9VNMG6MU2Wbsnr+AFuFnV1WgJmxoWs7DnWSI6yZgUSlN1oJR9N4tpgt6D9yca8OSXpyNSW6BNtbEHMswjwCvCuaKj4/dwX+6d0sh4q1c57av4WoSH7Q9ky3zPHOn0pkTg78JKL5bJMyYJcJzjYuttMQN7XCKbsDNfbdANRZAWAiOXfU7xQttzHqP986hvAf4bJSqfpn7AemSRdJranE2ru9bp5/L8/OOIxuk7i3f5ILIZSiPDg919nY9RPqhWORKCQdOSU7qrwePFSWpeDaRDBufQ4YjJ8EiqGvajOuxL6jMfUzmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRVRI0/pFRdhX0JXwAZAaofoYmWAvzqvKh/DaExNszc=;
 b=jRKbkhBFsUD7bzm3pAR9rI2S+1DNz2CDCbIqZwifLtv+DlwldlxMOTvv1OFHUthXz0W0G7GXo1GTFFS+0Ss8AY6tejaZwdozjwMYW6XB0d5JF+/YJkKLNXajRFRPaPFXIbguU+XNs8549+DaSFxO3vUEcMnnZnwZMHOQZg2x6Ss=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:41 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:41 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] EDAC: Prefer 'unsigned int' to bare use of 'unsigned'
Thread-Topic: [PATCH 1/5] EDAC: Prefer 'unsigned int' to bare use of
 'unsigned'
Thread-Index: AQHVYYqm1RQO00AiRUWPRAcGKd4KJA==
Date:   Mon, 2 Sep 2019 12:33:41 +0000
Message-ID: <20190902123216.9809-2-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 2934de7e-0404-45de-7b5e-08d72fa1c93b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2480A22CCC7CC3E24FAD693DD9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(26005)(6512007)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(14444005)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(11346002)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(446003)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WoyrlOI1nIdh/0ZbKZJwnEstJ9INJ0t1TpxO/RxLGg3zhx7++2XqsRhhrWVTR7LT9nMWHo22cbRJlBBRg80LDtJbQJecanpXmy2JqwcsVeyJNQDyIAdVsnGCcDcVRLhIAgGGD5vpetN2v9/D1ghWWVudBdJeikWLUJG+Gi0QToV/5wUwjhl/7UY8DfqdxRfGMfeK47yosQeQDKfECwsbzWy1ObefjtxLP4UBqkzFQ0u31Y3MXYxnUUNpqgJYn6vl6zi0CCKx+qUiEinN13A6YMm/oWaXTrHtejEneQizEZFRMjjXMOjHKQnWpoMZmXxK1h6G0kfzOfOYbOmZEWS3xbk2kJLDr11E1cC2Ca1tOdB8f5bGe7hLq6E9dFppaM5d4epw3+H8H+7LZ7sgWP0EOp0lClWnOXvFDR+/HRwnVJU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2934de7e-0404-45de-7b5e-08d72fa1c93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:41.2541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNKwfGS5tDrlhq3I9Z+FyuLU9QfecY78FVYietclZ/03tgP5ZEoOSJvPqG9OFG6yhLX1B1aifXgDxvBnvO8FpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use of 'unsigned int' instead of bare use of 'unsigned'. Fix this for
edac_mc*, ghes and the i5100 driver.

Depending on the compiler's warning level it can throw messages like
this:

 WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
 #235: FILE: drivers/edac/i5100_edac.c:854:
 +               const unsigned chan =3D i5100_csrow_to_chan(mci, dimm->idx=
);

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 20 ++++++++++----------
 drivers/edac/edac_mc.h       |  6 +++---
 drivers/edac/edac_mc_sysfs.c |  6 +++---
 drivers/edac/ghes_edac.c     |  2 +-
 drivers/edac/i5100_edac.c    | 16 +++++++++-------
 include/linux/edac.h         | 10 +++++-----
 6 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c68f62ab54b0..2f1e3ec8e1cc 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -114,8 +114,8 @@ static const struct kernel_param_ops edac_report_ops =
=3D {
=20
 module_param_cb(edac_report, &edac_report_ops, &edac_report, 0644);
=20
-unsigned edac_dimm_info_location(struct dimm_info *dimm, char *buf,
-			         unsigned len)
+unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
+				unsigned int len)
 {
 	struct mem_ctl_info *mci =3D dimm->mci;
 	int i, n, count =3D 0;
@@ -236,9 +236,9 @@ EXPORT_SYMBOL_GPL(edac_mem_types);
  * At return, the pointer 'p' will be incremented to be used on a next cal=
l
  * to this function.
  */
-void *edac_align_ptr(void **p, unsigned size, int n_elems)
+void *edac_align_ptr(void **p, unsigned int size, int n_elems)
 {
-	unsigned align, r;
+	unsigned int align, r;
 	void *ptr =3D *p;
=20
 	*p +=3D size * n_elems;
@@ -302,10 +302,10 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
 	kfree(mci);
 }
=20
-struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
-				   unsigned n_layers,
+struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
+				   unsigned int n_layers,
 				   struct edac_mc_layer *layers,
-				   unsigned sz_pvt)
+				   unsigned int sz_pvt)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
@@ -313,9 +313,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
 	struct rank_info *chan;
 	struct dimm_info *dimm;
 	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
-	unsigned pos[EDAC_MAX_LAYERS];
-	unsigned size, tot_dimms =3D 1, count =3D 1;
-	unsigned tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
+	unsigned int pos[EDAC_MAX_LAYERS];
+	unsigned int size, tot_dimms =3D 1, count =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
 	void *pvt, *p, *ptr =3D NULL;
 	int i, j, row, chn, n, len, off;
 	bool per_rank =3D false;
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 4165e15995ad..02aac5c61d00 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -122,10 +122,10 @@ do {									\
  *	On success, return a pointer to struct mem_ctl_info pointer;
  *	%NULL otherwise
  */
-struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
-				   unsigned n_layers,
+struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
+				   unsigned int n_layers,
 				   struct edac_mc_layer *layers,
-				   unsigned sz_pvt);
+				   unsigned int sz_pvt);
=20
 /**
  * edac_get_owner - Return the owner's mod_name of EDAC MC
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4386ea4b9b5a..640b9419623e 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -200,7 +200,7 @@ static ssize_t channel_dimm_label_show(struct device *d=
ev,
 				       char *data)
 {
 	struct csrow_info *csrow =3D to_csrow(dev);
-	unsigned chan =3D to_channel(mattr);
+	unsigned int chan =3D to_channel(mattr);
 	struct rank_info *rank =3D csrow->channels[chan];
=20
 	/* if field has not been initialized, there is nothing to send */
@@ -216,7 +216,7 @@ static ssize_t channel_dimm_label_store(struct device *=
dev,
 					const char *data, size_t count)
 {
 	struct csrow_info *csrow =3D to_csrow(dev);
-	unsigned chan =3D to_channel(mattr);
+	unsigned int chan =3D to_channel(mattr);
 	struct rank_info *rank =3D csrow->channels[chan];
 	size_t copy_count =3D count;
=20
@@ -240,7 +240,7 @@ static ssize_t channel_ce_count_show(struct device *dev=
,
 				     struct device_attribute *mattr, char *data)
 {
 	struct csrow_info *csrow =3D to_csrow(dev);
-	unsigned chan =3D to_channel(mattr);
+	unsigned int chan =3D to_channel(mattr);
 	struct rank_info *rank =3D csrow->channels[chan];
=20
 	return sprintf(data, "%u\n", rank->ce_count);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7f19f1c672c3..d413a0bdc9ad 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -68,7 +68,7 @@ struct memdev_dmi_entry {
=20
 struct ghes_edac_dimm_fill {
 	struct mem_ctl_info *mci;
-	unsigned count;
+	unsigned int count;
 };
=20
 static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index b506eef6b146..251f2b692785 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -417,7 +417,8 @@ static const char *i5100_err_msg(unsigned err)
 }
=20
 /* convert csrow index into a rank (per channel -- 0..5) */
-static int i5100_csrow_to_rank(const struct mem_ctl_info *mci, int csrow)
+static unsigned int i5100_csrow_to_rank(const struct mem_ctl_info *mci,
+					unsigned int csrow)
 {
 	const struct i5100_priv *priv =3D mci->pvt_info;
=20
@@ -425,7 +426,8 @@ static int i5100_csrow_to_rank(const struct mem_ctl_inf=
o *mci, int csrow)
 }
=20
 /* convert csrow index into a channel (0..1) */
-static int i5100_csrow_to_chan(const struct mem_ctl_info *mci, int csrow)
+static unsigned int i5100_csrow_to_chan(const struct mem_ctl_info *mci,
+					unsigned int csrow)
 {
 	const struct i5100_priv *priv =3D mci->pvt_info;
=20
@@ -653,11 +655,11 @@ static struct pci_dev *pci_get_device_func(unsigned v=
endor,
 	return ret;
 }
=20
-static unsigned long i5100_npages(struct mem_ctl_info *mci, int csrow)
+static unsigned long i5100_npages(struct mem_ctl_info *mci, unsigned int c=
srow)
 {
 	struct i5100_priv *priv =3D mci->pvt_info;
-	const unsigned chan_rank =3D i5100_csrow_to_rank(mci, csrow);
-	const unsigned chan =3D i5100_csrow_to_chan(mci, csrow);
+	const unsigned int chan_rank =3D i5100_csrow_to_rank(mci, csrow);
+	const unsigned int chan =3D i5100_csrow_to_chan(mci, csrow);
 	unsigned addr_lines;
=20
 	/* dimm present? */
@@ -852,8 +854,8 @@ static void i5100_init_csrows(struct mem_ctl_info *mci)
 	for (i =3D 0; i < mci->tot_dimms; i++) {
 		struct dimm_info *dimm;
 		const unsigned long npages =3D i5100_npages(mci, i);
-		const unsigned chan =3D i5100_csrow_to_chan(mci, i);
-		const unsigned rank =3D i5100_csrow_to_rank(mci, i);
+		const unsigned int chan =3D i5100_csrow_to_chan(mci, i);
+		const unsigned int rank =3D i5100_csrow_to_rank(mci, i);
=20
 		if (!npages)
 			continue;
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 342dabda9c7e..c19483b90079 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -440,7 +440,7 @@ struct dimm_info {
 	char label[EDAC_MC_LABEL_LEN + 1];	/* DIMM label on motherboard */
=20
 	/* Memory location data */
-	unsigned location[EDAC_MAX_LAYERS];
+	unsigned int location[EDAC_MAX_LAYERS];
=20
 	struct mem_ctl_info *mci;	/* the parent */
=20
@@ -451,7 +451,7 @@ struct dimm_info {
=20
 	u32 nr_pages;			/* number of pages on this dimm */
=20
-	unsigned csrow, cschannel;	/* Points to the old API data */
+	unsigned int csrow, cschannel;	/* Points to the old API data */
=20
 	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
 };
@@ -597,7 +597,7 @@ struct mem_ctl_info {
 					   unsigned long page);
 	int mc_idx;
 	struct csrow_info **csrows;
-	unsigned nr_csrows, num_cschannel;
+	unsigned int nr_csrows, num_cschannel;
=20
 	/*
 	 * Memory Controller hierarchy
@@ -608,14 +608,14 @@ struct mem_ctl_info {
 	 * of the recent drivers enumerate memories per DIMM, instead.
 	 * When the memory controller is per rank, csbased is true.
 	 */
-	unsigned n_layers;
+	unsigned int n_layers;
 	struct edac_mc_layer *layers;
 	bool csbased;
=20
 	/*
 	 * DIMM info. Will eventually remove the entire csrows_info some day
 	 */
-	unsigned tot_dimms;
+	unsigned int tot_dimms;
 	struct dimm_info **dimms;
=20
 	/*
--=20
2.20.1

