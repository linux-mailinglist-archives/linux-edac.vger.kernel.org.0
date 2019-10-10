Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06C9D3207
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfJJU0D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:18372 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbfJJUZy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKK6Uw030102;
        Thu, 10 Oct 2019 13:25:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Y7mtzjNaWo4Is1zCUh8RMkqF1hO1/qe6MlFV+MwsIHI=;
 b=hAhMvvOSf4D6Df51lydaNsynDGITvYD75lJe0H+A59qDK5MPAvYsIjIQHRf84VE6/Jg+
 GZzrrSUj3Q6I9OhlhcI+bPWyyLx+YzXRd6nAVu8RYJCWU4cYEL8pvyClEgJu58L9lE45
 dPF2wv6MigkSVO6am6vRziXiwlBT6sTg83uog3X2UBnLY4Ff66+eHmvlZV55qRudmG5Z
 JdkHdN6X/CfK6kUgmHP+ayKOZyjO1pSIB9+ebNCPprkAhUa8zmI73tb0OGURyM2rQ9ZR
 XIM3jE9RJIktCXgvdVu3/z+PfZFDHS5oDzSeN//WxwLhMD4AeVUAgLyHlO91c+dEUR8M Ag== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:45 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:44 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgPl2TR0AZyev9OX8eVThuPbeTmBD3EsygWFTHcwuqSZg4YQXLNnMKqvMPmkWvwDS6jIGoK1Ogp81le8j4tZWy/Y3AtWA6J42xPNNbE40vhJ+JKX/PzJjOe5lzvl1KsIXP4TG4sTIxvb1kTvoTBczr0om1caI2JDVZqIEcYMHxVgCfvkNx8kzrP0IxPEN4QbD0DxLBQObxxwqX9re120AIdfFmdaYzGGS27TRag5/fzvS3gtHcaoh86TSEtNgcI17Ej+hVAC4w/CgAzD5fAMbrxSGpkAFhTKhWuQkG2HWZ2oxN3SH6t/jibYje+B4aMHq9rbKjpYuAcH0QKBgIXViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7mtzjNaWo4Is1zCUh8RMkqF1hO1/qe6MlFV+MwsIHI=;
 b=fH7/09e73dw7r3HMXglgJZpIX1q7HsqT6zu2BhP20jIVp0JOzdZS3oiaTWh9gfU9FFEj5efETubaXi0dtf/BsTsMN5YNjPjXBNRIDQO9soQPTdAdMhRwnveBetVUuHqPfyOLrmBQh9uRf2c9m/ELWtemvI3GSYDY6F6aSBtMy7FGzxMJF+ZqxVgPOOpr7PpIimcvhicW1I8UuvwNApi5ooYgIXk7bbaJmbJZR6WRo1iY4D4CaQe7Ny64+1jZGgedXCgH6NwmAiyI9n6zRPzXeor8MiL0PNc7k8GJs+7QDIC2JBPvaJnIg9YxgIP2rPJGKZVqwHR2M2GEns0MqH6+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7mtzjNaWo4Is1zCUh8RMkqF1hO1/qe6MlFV+MwsIHI=;
 b=gmnXhicD/6MWq2ngnxSqotuBDVaKyc8sMQMWXwtpxU+Aa8G9/z8pLgEiUb5J/mvpW43D9HzT+VTQWAu+hdVyDo4AHL9zeuU2hKY3c+FzSWpbUzvu7jS/kTfZW5i2MZimNO3gArYQQ+kUxBnc2GDVr9jBDYMcJyyHrSKjdy4Ab9E=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:43 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:43 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH 19/19] EDAC, Documentation: Describe CPER module definition
 and DIMM ranks
Thread-Topic: [PATCH 19/19] EDAC, Documentation: Describe CPER module
 definition and DIMM ranks
Thread-Index: AQHVf6jjo1IdYWQkYEOnV71CnJn51g==
Date:   Thu, 10 Oct 2019 20:25:42 +0000
Message-ID: <20191010202418.25098-20-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 7bc98929-74e4-4fe5-bd96-08d74dc00628
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24478B3FD9FBDD81744A7A53D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(14444005)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fj+lszWgNBEigYfW0CwEVdLsniDFMfXFeLY4BWqwq9iqZ6kF414W2z3MgUiAjmPSupBP5pblgJ4PsHv0b+oPIbW1FrazXo0EhZqwp5EszXPyy/axHWj34IjzqT/Mxa61LbSXL/JJQR04OGpNKqSLpKWaooYprKkfaj32p3HBUPgVurjTyvMwKPFuCqD3v534StpQMHAiox0/ae/eidGRgskULnfdDMJDwJIlH9dqzTlmRFLW4DoweDebprFMa2TVSKuAcbVGVvVGuV85WQ7owgB0byjjKM+Iym1hn8jjZoh+6cXmP9oJ9KcbA2YXzzIiPwQ3mXMYtBKRUDiJz6W5G28J9ae2TdxVZN6RAr4sx0uis/1emcdWvESAC+pOvTQ2yz2c5mMnMxAuZ1A9z97n94DwNIyI8T+aHlx82Gd5CKw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc98929-74e4-4fe5-bd96-08d74dc00628
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:43.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6RtPo5GXEjU5PJsLk5C8dYiOKloRttDIimBdGhUmcUiBu36+sLPMLyYOTbM1i9XodiJyDcmFVinYNB5tMm/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Update on CPER DIMM naming convention and DIMM ranks.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 Documentation/admin-guide/ras.rst | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/=
ras.rst
index 2b20f5f7380d..26e02a59f0f4 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -330,9 +330,12 @@ There can be multiple csrows and multiple channels.
=20
 .. [#f4] Nowadays, the term DIMM (Dual In-line Memory Module) is widely
   used to refer to a memory module, although there are other memory
-  packaging alternatives, like SO-DIMM, SIMM, etc. Along this document,
-  and inside the EDAC system, the term "dimm" is used for all memory
-  modules, even when they use a different kind of packaging.
+  packaging alternatives, like SO-DIMM, SIMM, etc. The UEFI
+  specification (Version 2.7) defines a memory module in the Common
+  Platform Error Record (CPER) section to be an SMBIOS Memory Device
+  (Type 17). Along this document, and inside the EDAC system, the term
+  "dimm" is used for all memory modules, even when they use a
+  different kind of packaging.
=20
 Memory controllers allow for several csrows, with 8 csrows being a
 typical value. Yet, the actual number of csrows depends on the layout of
@@ -349,12 +352,14 @@ controllers. The following example will assume 2 chan=
nels:
 	|            |  ``ch0``  |  ``ch1``  |
 	+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
 	| ``csrow0`` |  DIMM_A0  |  DIMM_B0  |
-	+------------+           |           |
-	| ``csrow1`` |           |           |
+	|            |   rank0   |   rank0   |
+	+------------+     -     |     -     |
+	| ``csrow1`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
 	| ``csrow2`` |  DIMM_A1  | DIMM_B1   |
-	+------------+           |           |
-	| ``csrow3`` |           |           |
+	|            |   rank0   |   rank0   |
+	+------------+     -     |     -     |
+	| ``csrow3`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
=20
 In the above example, there are 4 physical slots on the motherboard
@@ -374,11 +379,13 @@ which the memory DIMM is placed. Thus, when 1 DIMM is=
 placed in each
 Channel, the csrows cross both DIMMs.
=20
 Memory DIMMs come single or dual "ranked". A rank is a populated csrow.
-Thus, 2 single ranked DIMMs, placed in slots DIMM_A0 and DIMM_B0 above
-will have just one csrow (csrow0). csrow1 will be empty. On the other
-hand, when 2 dual ranked DIMMs are similarly placed, then both csrow0
-and csrow1 will be populated. The pattern repeats itself for csrow2 and
-csrow3.
+In the example above 2 dual ranked DIMMs are similarly placed. Thus,
+both csrow0 and csrow1 are populated. On the other hand, when 2 single
+ranked DIMMs are placed in slots DIMM_A0 and DIMM_B0, then they will
+have just one csrow (csrow0) and csrow1 will be empty. The pattern
+repeats itself for csrow2 and csrow3. Also note that some memory
+controller doesn't have any logic to identify the memory module, see
+``rankX`` directories below.
=20
 The representation of the above is reflected in the directory
 tree in EDAC's sysfs interface. Starting in directory
--=20
2.20.1

