Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95AD3204
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJJUZ5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42974 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfJJUZ4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:56 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPRsq029940;
        Thu, 10 Oct 2019 13:25:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=FzPxPqi7Fp4/j2fd+EetHBwp1eY08PYShhNu5gCcwvI=;
 b=EAq/rFHDpt0hNnDOO9gA9jXUWQmTVP8WwW96+Ik7TGRWhg97WRgTX8oVSkYxV95bC/vD
 xEdJw4dIinL3cHRdmGlAE4DvADsYY5qIrbSIKz78ttpFJDa7hl2yuhib6yl7RM0A6TXn
 HGhwPZVemBFfv+NRW4aZ8C/iDcwdrApLg2qm+sDGv4RRgvZur2Ndf37iNqjl7OvSG4TH
 XfL78yaP96JOyn2Rpora8dUy3Rd5/cJLkiB5pJK+So2f6Y0xfyk6hU3t0fH0G8SMK4cL
 L4RsIusjt7KH+7xx3j5hndEV4ViimGpYFD6fWyDn27gXQKu292mOQWtKLzHaPEBgkl5z sw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:40 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:38 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO2XiBYexvLsiD4u+1mTF4Lt4fRNVN/Z37Wp91QGxgunB/lnwH5Ec91B5hHQuxCC+wj9QeIKb8MjJjXfriQFFCfzX7l1MBbFvpm9KybBibO5h8X44po6SE8hLRUbgjCYXtH+f3fuvaGrv6RIqkaPu+5megYaybPmv16oSavly1m+kaIspEs0sqkr8Ntofp8ruvuzxTNURjzmFpntnscyDlqkK4ZOJGCCgvgZIP0BUbVJId2yirOOXEGT4b++eu+uIAC/mOn+yCN2/wt2sq1pXE4apiufqSLKCeBP9SpUOLftT7X7AloYsVtUmGD+7yC+FY46TknUYCv7vwyh9KpLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzPxPqi7Fp4/j2fd+EetHBwp1eY08PYShhNu5gCcwvI=;
 b=AZ6k7mbv4aVSJMNj6jajObMfWh2WI82E9wXs3d1G2ekKtcJ5iM6PYmCttWjml9N8qtnY8NgTM7H6y5I324UpQesQbAyZKEOfdZ6xc5HBIg4srIzuljIvQ0MnpkK0FEa7s/wX9+LD7EHX6rFS6TAPu0FCS27os3/IDaDHAD53INv58OQJ0/Qwx2MhBT1sSkIkXpXo78IqctHsDnFcq1I2q9bXuf7FAYx70i5WLOmaJ7TIYjwvEp/FmANuLzu28mFWNGXJo4QWA+dEluAiqu4CxlM3lHb0nH2iJG2xzSAxfANZM0J/HvIOp6f57a6L2i1s0YsoX/RWeT5UrilVkn9EEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzPxPqi7Fp4/j2fd+EetHBwp1eY08PYShhNu5gCcwvI=;
 b=dcwTUyoyH1cwtx0WoJ6nXa5GJVCdPyjLztRoqIyZnQfO1DlSNii59SctS3QY9djHQYPiM/YbBalYKTwx/kDu204L3wKBCksfMlD6KSVHXZp9I9rDdQH1g4MXFDyGcG5EawT8yqMWxueqC0ETKrI/FUXMtEmOHwZw32C/6XA838E=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/19] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH 16/19] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVf6jgOwyP4hjp2kqaVCWyMPMEMw==
Date:   Thu, 10 Oct 2019 20:25:37 +0000
Message-ID: <20191010202418.25098-17-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 115b99ff-b167-4d80-f7d3-08d74dc0029d
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447F958565A7B0466FFCDB9D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(14444005)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHELFrIqXap6qXvSYpqt3rZn7xGtxL/MW6Qv7uoxN83COA2GXtUhjzKNuuvno0NEsiw6zlZYhDSBRbFRWLZsYH7J3+vwwRbF36QO/rca61m91g36kSbr22gBH8KlOgF781ExzrtZHz/6dctsCYQy+XgTx6fUq03ojHtFrUXd+COgUubxKZklQbdq1bNw8/hf+wmiQPkHSCKlyRoTHhc8XfJBp/3SJM66m5mCj5sPIitwNg6lJxY7sd9UaRk4cYaqYDWtez9nfa2Bht7/k4GVZ5kg5loyWVFEY+Z/mecVUxRgW8WF7aMcdOFwJSqUHiQamgP9sUY8UxcqdrgLSvxDCxVPi3aqzbCQYO12ZY/n1/OFceyxBLozv5k4a7Z6eIWYujMEOa6hABDsRT6fjHFTVT5IRQ984EJrLQjyKId23wU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 115b99ff-b167-4d80-f7d3-08d74dc0029d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:37.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibhXKI7bs8OW53Xl3GhIAKssPltUhO0gtJ9uFqom8euH39dZgphOEr8v+fEVJCqn25fSnXpsFI4C7gB5B+Wwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current code to convert a physical address mask to a grain
(defined as granularity in bytes) is:

	e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);

This is broken in several ways:

1) It calculates to wrong grain values. E.g., a physical address mask
of ~0xfff should give a grain of 0x1000. Without considering
PAGE_MASK, there is an off-by-one. Things are worse when also
filtering it with ~PAGE_MASK. This will calculate to a grain with the
upper bits set. In the example it even calculates to ~0.

2) The grain does not depend on and is unrelated to the kernel's
page-size. The page-size only matters when unmapping memory in
memory_failure(). Smaller grains are wrongly rounded up to the
page-size, on architectures with a configurable page-size (e.g. arm64)
this could round up to the even bigger page-size of the hypervisor.

Fix this with:

	e->grain =3D ~mem_err->physical_addr_mask + 1;

The grain_bits are defined as:

	grain =3D 1 << grain_bits;

Change also the grain_bits calculation accordingly, it is the same
formula as in edac_mc.c now and the code can be unified.

The value in ->physical_addr_mask coming from firmware is assumed to
be contiguous, but this is not sanity-checked. However, in case the
mask is non-contiguous, a conversion to grain_bits effectively
converts the grain bit mask to a power of 2 by rounding up.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 851aad92e42d..97242cf18a88 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -220,6 +220,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	/* Cleans the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D 1;
+	e->grain =3D 1;
 	strcpy(e->label, "unknown label");
 	e->msg =3D pvt->msg;
 	e->other_detail =3D pvt->other_detail;
@@ -315,7 +316,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* Error grain */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+		e->grain =3D ~mem_err->physical_addr_mask + 1;
=20
 	/* Memory error location, mapped on e->location */
 	p =3D e->location;
@@ -428,8 +429,13 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain =3D 1;
+
+	grain_bits =3D fls_long(e->grain - 1);
+
 	/* Generate the trace event */
-	grain_bits =3D fls_long(e->grain);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(e->type, e->msg, e->label, e->error_count,
--=20
2.20.1

