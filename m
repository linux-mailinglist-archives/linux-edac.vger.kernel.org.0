Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E0D3200
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJJUZu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:50 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32618 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbfJJUZu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPLp9029864;
        Thu, 10 Oct 2019 13:25:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hLoups3dF+xoDLUwS/dA326mDDuYMC/B7Np78wKqtCQ=;
 b=axYka27Dwe0bT6MnX16gzIp/bh6kbKM+ArWiYXakKa20jOy66OQiTjVdgjYK7cVO1mQ+
 WrSN7dRPB8xwmPPson4pmIwgg5uyI8ujLepqsXrSW5sZghQz8fs84HmYKbXBgRvco9bz
 +R0bcOjYaTiSKWrYv2Cs2nrdd+PRIw+ne2IraHUctemznvbvt7feQi33YIq6Rk+r0glJ
 apNB8Md+YllYtlnnoNPHQwkkt9tW/WcdFv7Vh+UE460jnagdA86+92xS+/YKHLcUDyQw
 8JV382fsxZzY/XUAFlhsdEwx95oSRo8s4pdgnYeydb3EtRXuT6Jrk1dSoMk5HAA4OYFk +g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:41 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:40 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxHGBDafIPSHtrJzc9teCkzeagcCwlOGzVHleNsfgSlHc5O4eSuClPbvJnNcfydCzbv1BhUlAt1xMkpmvkZsxRODllrDmSEtGqr42czBl7/jeG6nmHw7tjzQQ7qS5Aizqi68XL8Gx9rouWHCPU6CsPvFB48g/pkcZmTzZ7ezmr9sO503JbI70zU6UqWaaQm1n//fgHQMvzsC0t+bUWyZUYRi01ofhxuTdv2C4R8iwxdCF3R97f0oDcpkhk5/AC/A30pOU1YwQZLrS3aiRNGNFbnX3nL0nWXo6l5zBu5cwMaH5UlavxQb5Oo3lRlunoMpr1FiH0Sby8kKzNQ4jgwVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLoups3dF+xoDLUwS/dA326mDDuYMC/B7Np78wKqtCQ=;
 b=amOdHCrCFrUyFGQDU5WmuYSgYxjKsUygcZIJQ7stPITq7TfWMep4nWDV2TPTNHguDmSF4KTk079cQYSrOS1XoviO9XR7uLZCb54fl2BdhtHaRKKDTQz97wDZ6NIoim5BW84EpdNc+4Utj0DwKpAC1rhYEDkNtlYDulZBxW9hiGI8ZS3SFdTHnS12OKJuxOrVfXwZSUv2XqZMzYRXYIgYImje1cTngCXoIN5jnVVEXEQTuyyJGNvveL/c5up+H+/N/6EpESi7X6dInd6wJ6OStB9xmPwvsGadgAenA1H++Fq49abnave1DPn5IlTszhl/ISWzvTQhCtjPcrv4TzjSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLoups3dF+xoDLUwS/dA326mDDuYMC/B7Np78wKqtCQ=;
 b=D42kh2sdmrBUkpnGYD55eygOhLrieMeLEh5SrSWYLo4L0Svnbiv2D0ANt6bsiJSof2JB12SJ2wLf4O76vxwJmgAvDyfBILwAP0kzBVzaFrKHfJAgSsITavDhvW2nKTYv/ylY2qcC8cSv40qi7nuyS4jiRlJKATQxvjWH7xrVhBE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/19] EDAC, ghes: Remove intermediate buffer
 pvt->detail_location
Thread-Topic: [PATCH 17/19] EDAC, ghes: Remove intermediate buffer
 pvt->detail_location
Thread-Index: AQHVf6jhvWLXT91WTESlXtwQORRIng==
Date:   Thu, 10 Oct 2019 20:25:38 +0000
Message-ID: <20191010202418.25098-18-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 3cb8bfe9-5eb1-4340-9209-08d74dc003b6
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24473A719F22B7725B591FC1D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1SAt9bK1vchL9n2jmsHL2yBOB6DKCpcpyYz/BZmIeZ48yO7IcCorV2Y8QVXZ8qLdEepVu1Wpi0/OiAeP3mEyLC7NIMBc+TdyorTTzjb+xiITHgmBfX/balG2iNlEvW4nWp19Vv5acwO0k7L1t/ZDnfBR5ZRpylLFsa/hgqkJkYBbIVzZOY+6C8uT2/JzTCqcFbBXpmuF5OevmHkgoOlfbw1wOgBEIDru9EM0wuvP64O0ugQQg2UQhkBSQ5T5DBzUIDVrPN/6g7EIHiCjYbT5R7lV63YDrJ9lBwV4W/Uk1nPiBKcFFlz66EA6YNB8hfz2P11jOywsbOdC5aa5o8ggOzrnu1PM0SSh8H1g27Sz4p/fv6yB5DqVokdz5xFbcOIb7/DPGqx/5ydvtuDmLmLgVDKpLUiRpaiA+1K44FRpL0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb8bfe9-5eb1-4340-9209-08d74dc003b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:38.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v46H7EtrE6Ya4TAtSOjGU7mj0y1QRzN+tImDysJcQEKkiVvoDRkEqjSQsy0cJ74yYo5/GSd6Qu6EQLIGgvH3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

detail_location[] is used to collect two location strings so they can
be passed as one to trace_mc_event(). Instead of having an extra copy
step, assemble the location string in other_detail[] from the
beginning.

Using other_detail[] to call trace_mc_event() is now the same as in
edac_mc.c and code can be unified.

Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 97242cf18a88..8d9d3c4dbebb 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -21,8 +21,7 @@ struct ghes_edac_pvt {
 	struct mem_ctl_info *mci;
=20
 	/* Buffers for the error handling routine */
-	char detail_location[240];
-	char other_detail[160];
+	char other_detail[400];
 	char msg[80];
 };
=20
@@ -356,6 +355,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* All other fields are mapped on e->other_detail */
 	p =3D pvt->other_detail;
+	p +=3D snprintf(p, sizeof(pvt->other_detail),
+		"APEI location: %s ", e->location);
 	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
 		u64 status =3D mem_err->error_status;
=20
@@ -436,12 +437,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
 	grain_bits =3D fls_long(e->grain - 1);
=20
 	/* Generate the trace event */
-	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
-		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(e->type, e->msg, e->label, e->error_count,
 		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-		       grain_bits, e->syndrome, pvt->detail_location);
+		       grain_bits, e->syndrome, e->other_detail);
=20
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
--=20
2.20.1

