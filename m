Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35B4D31FE
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJJUZt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37240 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfJJUZs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMdO029873;
        Thu, 10 Oct 2019 13:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=r88CqJ4CRLirPG0YtAFyxOsUcnLoxZsotDSdCKrEUjA=;
 b=sXHG4WtSEr6EMQNtcHgUvd6KSBhZqPfUgrrZI+VyalYrzcFy0rAHTZKbBsJoKIhpWhzh
 hRvnmO8ckisqQ3lhhOHYP+Z0T4LFVqEks5PK9CX1EDD8x2ph9sKHeRruV6YvQRlICYV6
 rW64Av1GzYzsqypv0DLgOiWcuV4AneFysK02xYFXGVYHtuJcuxzlEesGWDboMdqlTKP5
 c18f3F+UqdNapS77+nTm14vVWWAajOvcLep1BmLmHCSkrZWyDl+11MSqgeIvCLzwcl+m
 HH9/5jPS7hGRrjXnu27uAkSH3E9fhj/YYVz4FoQsjLYLM4J/jCoz0yB6nBAOVrI8ia/A 0Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:36 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:34 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak8l++S+/bRozZrAw6DneiHu5m5a/3/TeyHGoA2jXhTSJfbO56np/vBBsSGIVMDd2Aadc5PWO3yRN7aKR5UmJpFYTvBhs8xVfJNdo5Stck/8uzih7eLOaTAGxfA9hj+0fd+DBNoYCyZnD5Wf5M/yVIsyFOymlfJwWCiQTeMYWX4l+nSIW1+2xvfOhwVOE034/3X2NpYE9jQmXRAAM+291xwN8sJjDuMuqFPkHv828fExEU/d47B9cTwHn3BXxHV7p5z3w1bBNK/r55hCS4XxZ4J8H9DDZqD+cLB0+CVze6mql5hFR2CqhlfLdaqNy4Xy7rkO/IRoeGO8YUEVPufkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r88CqJ4CRLirPG0YtAFyxOsUcnLoxZsotDSdCKrEUjA=;
 b=h6jpDJmdQxpbwanasOad9Yt3A6teNfH6KYliVRFlbTEgpFaHdEstoG++iU98HR6vg3m/p+O80edW+5sBoWC1ZwZJQT2Hxdp9JAynoiKsNYkgaCb32vaHASapfDdY0CKP0deeEw7kqjJdtlk2Gs7RE43r8YTgLHvbMtv6jU9dNUhFFnGgD3MzFtJqQAmb0oQvaHyCmyHgVeM7uVPMRcur1HFKWES8SyzUJekdlnkfBR0lGMBhOZ2ICl4Om0irBKCkJj1fBFhP1ePq0CpeuGvac9scECN0ZdxAeJFltFtVGzd1tWvmXIeFsoAInwiGZXBvj9Q9Hw7rtTjLPYNnkM44xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r88CqJ4CRLirPG0YtAFyxOsUcnLoxZsotDSdCKrEUjA=;
 b=nrFaLmk18hpx4Ql8Nc5Pd+Z/r9f6NFjpXQhexaiGj7kTyYvnZtO8KvDXJ9WES8kh74OVeMRxoFodSMJW4a8IkryuEby8F8U5v9cIwnzqA3UTUtRYDPugdimBE5Zxp0LpVMB0mOuuKZg6ZuM9HH2Or2aQFJGUjVGxAJcpWJl9+yI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:33 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:33 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/19] EDAC, mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH 14/19] EDAC, mc: Create new function edac_inc_csrow()
Thread-Index: AQHVf6jd4a7gKhx+NUm64guphBxEUA==
Date:   Thu, 10 Oct 2019 20:25:33 +0000
Message-ID: <20191010202418.25098-15-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f9a5187-145e-4068-25da-08d74dc00041
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447C52A0A251C7FBDB584AFD9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 96hbTvMZn4Zf/1Xwx/WN64fHLq8zc1ngvY4Y79IYEhL98Ypbh3tkH3ZIdSkJtH2KCXSiiQor9lEDfZCNYLWIFFC8QnePvKdjWJIYgbcP+mRTCC3RYVSL13RLYR06jB83WZWK1kacC+W0/RczOVgBzuwiT83z7v2ftbp9eR3OYrFjG8tQMz5JxvvTwcUiJn8Ws+JXBCavDi/xndQerNVJrM3XcgDKsB8qy5DXooK7iDFbWUDTqsXkclNFirikAF489fqJhUbwp62qhyfkRbhUj1GT2CyHD6Oqf56yUQhKG45vzzV6oVlrIhpgxsRbFt5fD5x7JY7CJk4KvAkxvhuNiGP8hUNeKSO8kUveS9/sls0zrZfa/lj4zx238jIsRPP8pc41QJEJqGXNSTYpAaBPXZQRVsEEszt4yaCceWF/p60=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9a5187-145e-4068-25da-08d74dc00041
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:33.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hkhx3B7D9xiHUuVTbLqWeUrJ4zKujTbZqAIqEsFl0EWaHvZo9EffnY26wiDl10gpo+ODhu/wZzL+PJ0Z9d4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Have a separate function to count errors in csrow/channel. This better
separates code and reduces the indentation level. No functional
changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 9e8c5716a8c0..3779204c0e21 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1045,6 +1045,26 @@ static struct mem_ctl_info *error_desc_to_mci(struct=
 edac_raw_error_desc *e)
 	return container_of(e, struct mem_ctl_info, error_desc);
 }
=20
+static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
+{
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
+	u16 count =3D e->error_count;
+	enum hw_event_mc_err_type type =3D e->type;
+
+	if (row < 0)
+		return;
+
+	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
+
+	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
+		mci->csrows[row]->ce_count +=3D count;
+		if (chan >=3D 0)
+			mci->csrows[row]->channels[chan]->ce_count +=3D count;
+	} else {
+		mci->csrows[row]->ue_count +=3D count;
+	}
+}
+
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
 			      struct dimm_info *dimm)
 {
@@ -1201,22 +1221,12 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			chan =3D -2;
 	}
=20
-	if (any_memory) {
+	if (any_memory)
 		strcpy(e->label, "any memory");
-	} else {
-		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
-		if (p =3D=3D e->label)
-			strcpy(e->label, "unknown memory");
-		if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
-			if (row >=3D 0) {
-				mci->csrows[row]->ce_count +=3D error_count;
-				if (chan >=3D 0)
-					mci->csrows[row]->channels[chan]->ce_count +=3D error_count;
-			}
-		} else
-			if (row >=3D 0)
-				mci->csrows[row]->ue_count +=3D error_count;
-	}
+	else if (!*e->label)
+		strcpy(e->label, "unknown memory");
+
+	edac_inc_csrow(e, row, chan);
=20
 	/* Fill the RAM location data */
 	p =3D e->location;
--=20
2.20.1

