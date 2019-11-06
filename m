Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83AF1251
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfKFJd6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:58 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15288 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731781AbfKFJd6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UNGQ002538;
        Wed, 6 Nov 2019 01:33:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5QeX3Rdt6ruhgoEmEwVn/yWzxBrV5AGE2eQJUWIO6xQ=;
 b=a940HRsaITUZZXTgEg+PBVUsnWBtMKFa22sLBIhPkBhsZSITeKR7dR06wBXOEOe28n5U
 AIiy0K6pGau+/+h17/Rvt7hmhbAxJ0Em3Yz7A0STxP/oedRMLkGbaJIucl/fbDKCEuun
 P+at6J60MNGcL1NuWbD5g2hi9smcTG95VlLdJjirOSAiwbGbDCsAWaqh4zgdTifueYsq
 s59viAx6ZfvQe2V4PqWoeqf409/Zkz+PFRoNfBJREUgsJJvhZExcakxwXZfLf0f1gHIe
 FrDK/1xz1m7CSR0zLS50dip8q5CV3yHOoE907iZ6bOKlj42C/h7IX+AzWtCjyvXT8IPs FQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:47 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:46 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idlUvfqliinElw++C2/0NZm/jDJtVnIo+rcNwBVstQn/Ne6Habm7pEon+nr52SnN9vhD09Z1ILLkwkJZd3SQWfgMwkPrlrY7awFHUwRrgNJTMOckLXAvGfnBMPfoH5U/0RUE2XtCZy6Zqi+ofNVlqHZoO9b/aDTo3Brd/dYSZUpFbZFtUeugNYoiRyMbvWtZwWbJGh6vaqAznuU5Bt8nAQeNkskDZtrckE0fAlDp5IEkThWQRGaKGsZVgIjkp43p7m+mV458KfTdLV6jBy30Z9A/DxOw8gttaz/ilU/fsJtZQXkofZg4XzHaICMWGtgia+EHjrB/3r7aEe22R0GM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QeX3Rdt6ruhgoEmEwVn/yWzxBrV5AGE2eQJUWIO6xQ=;
 b=SCTtuUhC+w7kc8tpTZDJysHQVaP5DW2ED64O4CsQE6BLvSmjYwIO9Vp4nEJq1Z/q+wlyrbnvJtJ211pZ+YfNRC78hQRcJF+Bmb/oNWtsdZb0/59fGHa9v5UlxC2dTCbfhN7Mrg3rXuy/XVzYOBwCqRGba7rRTHk2B675yw+3soMKzvT6FR+mzlxhBmv4rkzEWbWRJztIgGX7jl11EinA9hqEHAvBMAb9frPo3BycktQBlFcGb1HrOXVRVo0z7tXwP87nrhDx8F6nnx8VafkmkI9qMhCq2NMeFBwnEON3w56Hq74F6+wA5BAiTncN6oPsyeM+PYHBnFugBpZGkMgUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QeX3Rdt6ruhgoEmEwVn/yWzxBrV5AGE2eQJUWIO6xQ=;
 b=aaCY9Uj0LO6Ni4AzhovcKwHQG0t0RNJrOhOnN7Zos02PxU+bz42MpHVLlTkV2ys8wEtQCWmnB1Hzr7lrXxU0X25FtH8suM5fbBS6xAM6yQlN5mvLMHGN5U2L1QrXH9+cOagAjTH4uwbt39Xf6e1yf2aAS7rtZfNFm82QI2QbnG0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:44 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:44 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 19/20] EDAC, mc: Determine mci pointer from the error
 descriptor
Thread-Topic: [PATCH v2 19/20] EDAC, mc: Determine mci pointer from the error
 descriptor
Thread-Index: AQHVlIVIaSdKYalyGUal0TUjscbV+w==
Date:   Wed, 6 Nov 2019 09:33:44 +0000
Message-ID: <20191106093239.25517-20-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb5b72cb-acbc-4e6c-e9e5-08d7629c6aa6
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31651E6445E0C6B8A920A072D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u48+29DWKIireniFFVw49LG7kn4AMBYjjlcOK9OjKGhK28D8KCPexVI2g5I6mrT1fn++WxRpHaLYSFQma4RPrAiRvTNBIkflyb9dSVVtD8hSKiedgJeCc3LIXAh7upRJdSDE4x1EnpCosdxSe3YUXtJBtpWUR9Aap5xnU4TANBnoc8//yzE8CPMTd6/XjpIpPeg+705VAtg0iDZluN/yGvbacNDLmj/+m4nH8vXV85UgxEgZXgOxjVuTxsr+AE3j7rsRfTMv0cUFsDdq+CztmLjbKO5A1DGCImFXLsRXY/hVjC7OR5NmSZyL50LPUcToS/DGGkKRGiY8vxbMm21xi+2dYHCPkZlLQLFw0gOJ5ebd3gNTCt4xwzM7zpcqfV28sxrQhYn6rcxnhYBpTBR+Yz7MybqFvvtIs4HxAIwNV7wOQ2BQ6zN0pWRWLlie8OY4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b72cb-acbc-4e6c-e9e5-08d7629c6aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:44.2367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTeS3RzU1oyWBjgEYq3Kwgtz/wGyhHhXMFlKd80PqHLrxF8FhexmBGd7czf13NaLoNFo9I5vJpRL9ejJ1Irf4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Each struct mci has its own error descriptor. Create a function
error_desc_to_mci() to determine the corresponding mci from an error
descriptor. This eases the parameter list of edac_raw_mc_handle_
error() as the mci pointer do not need to be passed any longer.

While at it, reorder parameters of edac_raw_mc_handle_error().

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c   | 13 +++++++++----
 drivers/edac/edac_mc.h   |  8 +++-----
 drivers/edac/ghes_edac.c |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7b4f5e98dfe8..93eac968678e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1040,10 +1040,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct dimm_info *dimm,
-			      struct edac_raw_error_desc *e)
+static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *=
e)
+{
+	return container_of(e, struct mem_ctl_info, error_desc);
+}
+
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
+			      struct dimm_info *dimm)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
 	u8 grain_bits;
=20
@@ -1242,6 +1247,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
=20
-	edac_raw_mc_handle_error(mci, dimm, e);
+	edac_raw_mc_handle_error(e, dimm);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index a8f1b5b5e873..3b01d5d9d7bc 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -212,17 +212,15 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_=
info *mci,
  * edac_raw_mc_handle_error() - Reports a memory event to userspace withou=
t
  *	doing anything to discover the error location.
  *
- * @mci:		a struct mem_ctl_info pointer
- * @dimm:		a struct dimm_info pointer
  * @e:			error description
+ * @dimm:		a struct dimm_info pointer
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
-			      struct dimm_info *dimm,
-			      struct edac_raw_error_desc *e);
+void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
+			      struct dimm_info *dimm);
=20
 /**
  * edac_mc_handle_error() - Reports a memory event to userspace.
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7d325d70d6d3..c1bcfdbd6f82 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -441,7 +441,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
-	edac_raw_mc_handle_error(mci, dimm, e);
+	edac_raw_mc_handle_error(e, dimm);
=20
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
--=20
2.20.1

