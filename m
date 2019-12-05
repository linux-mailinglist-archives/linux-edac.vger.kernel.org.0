Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67620113E39
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfLEJiL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4504 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728604AbfLEJiL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59bASe023600;
        Thu, 5 Dec 2019 01:37:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=Gp8wB4yF1YKkeqNupJblkwyIfkEPMm62+nkD1ZxhqTI=;
 b=q8XRDohQx/dNBp26HqLyWWmZBlkyzdgteN0ARFWhl1P7I61GEOA3tKeiBAievaOU/VRw
 0E9sMT/c3Dfzdo6NU9kAkUAwW1zF2cdvFsffMQ10u2osQqrHub6B/PXLwTGfuEf+2apL
 LxMcGwICW7VSFk9VwjBBBzXX5qIMcVwhHcpCmufM6iA9bkicvCLl0wObS59tga+cjvMc
 K5cFU4KqsszG/OIDpCZS4liO7x2zwy8pqOFF6xGmq3QXRoJ78bqXIkjqU7PU2v72ECtN
 Gp/NueiSZmmfLI97FVRTm9s9sRWmfNjga5LejnTc3HxlELQBwCdjRfrZUUMrNbmNCW3h eg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrcya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:37:58 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:37:57 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMayvu5zGN07yDJvmeQiL7FpbLBJkTHIToUwqpJ5miowrOg7rlN/q3sREs0AywYnMeyPFbnhHtBEzXoVDnHnAMg76Yd0bq7fV+IFlO3oB0KY9HuVTY6BhQkJbjF967Hk1HkJwxYCv9qFy4BCfXxpUTQ5DOKsQZymDf2OX0ijqSuP2mV/2+w/2mPrLmUaDBnftSE09XoYycrZY5LMjpp+i1U9DZCIKxf0mRQ4tN2oVrEW3aX83NyBuJkSVn8Nd7tdPVQs+SrzKOJVyJ9dU4AOJRKGTf56pO158GUuVk81kRCoVIHfulyJcAMbSjUH7gVZRHG3vKM6wQaWbUuUNG99+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp8wB4yF1YKkeqNupJblkwyIfkEPMm62+nkD1ZxhqTI=;
 b=BI+iwOnBChYUlD5jAAsCAcdjCzZmIRieDpC89gsFQPzAInI+Z9WU7k5Xk7TKHuVobNlFHfks8vakOjW7ZxEIbLyuZJjOex53Zp7Pr6Y0wvqtYWA65G4sHuzt1Ejt6/a9Gmp5HNIck/I9SockRnzGNnv10hM510acdckp7xDmPka7E0BPz+ccEGIhvOrs5VmPjHytKRIAG/0KU/CXkm6niiTBi9rXwPRecBCCeIU2A8ZHL8gCdxMMJ2vSGJZxWTRG9naN5lkuREB8BKrSlOw3Bz03Y2DzNQB9fSW9J3vcIV0AYGkx1StiBnBuKK54Mh7KiPc0cFjnbj4YhXNcvfjpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp8wB4yF1YKkeqNupJblkwyIfkEPMm62+nkD1ZxhqTI=;
 b=iMjeON40+jb1aRighRln21U6N56KukFcswATG9gfORKJt/FqIhvIHPPgz+OKgTTp0X1DcyiAihRnk+PGyzF67x8IgzWcGRZL4//D1Ojvb1WfT+scXg2jpkSCXb5VTHIwPVofaqFesQQuXiIqlmW9SzLip7S3BtINA7OHjZYvWpE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:37:55 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:37:55 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Topic: [PATCH v2 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Index: AQHVq0+sz98n7KgjO0C17RD2HnwZvg==
Date:   Thu, 5 Dec 2019 09:37:55 +0000
Message-ID: <20191205093739.4040-1-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 3df6a764-34a1-4482-68a5-08d77966ce9d
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2367CDE3B011A2BACE31E834D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(966005)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(102836004)(305945005)(1076003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2vTgK+3JGsFTKgIYNco7zPe8J/Xj3gDviTUO+Y/cXfovlKtwEwhpd2I5eJ6JPSd2bGCPaQXNXg7bRD5XkOlX2oV+hc2xWu2S++fBGPLumyvAZkKEGKzdjSn8Z6DBlF2me8CTmDjTQQstIIs0mIf/JHgNv2mdvkpnNjmZN8iYfnnnhjuXhBGEY4ZOiMm2bbJnSws/WShgyIfPe6mEDgUFiEhq/CyxP2aixV5GPIy5iqUYVLi5xnlHk/03QxS9TPDE4zFoFeb4tCTvf0ANtz482RmJkj/fKjslwrHCjHvMfN/7OQtq05PNpIzbubJb7oOX1p04/4RdgdRhCRzPmlzQnmNyzrXOMMcNsgaY4yiFKrHE4/2BFau/l6cSl8X0YLlcFaRe+khZor9A+Qn2sFkBJ08yISpgN72DE2hSN4L29H0nbvd7ECGaFpbfhKr5NzVI0z8ZayKLA2RYkKs08QzG5kL1/QZ36ffl6pydx2Gq/E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df6a764-34a1-4482-68a5-08d77966ce9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:37:55.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWTPRK6H3waaChIU5nmqVpRhjI4pmhW0KQ0JxLXsgIz2lLM0QIz/F6DbRPiqz+ZlA3Ti4BUZEIm/DM1lhGUeTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set is part two of a rework of the ghes_edac and edac_mc
driver. It addresses issues found during code review and while working
with the code. Part one has been included to v5.5, see:

 https://lore.kernel.org/patchwork/cover/1093488/

The changes of this series include:

 * add helper functions and factor out code (#1, #2, #5)

 * improve function interfaces and data structures to decrease
   complexity such as number of function arguments, unused data, etc.
   (#3, #4, #7, #8, #9, #10),

 * minor functional fixes (#6)

 * improve code readability (#9)

V2:
 * fixed documentation issue in #3 found by "kbuild test robot
   <lkp@intel.com>"

Changes compared to part one:
 * rebased onto 5781823fd0d3 ("EDAC/altera: Use the Altera System
   Manager driver")
 * reworded patch subjects
 * reordered patches
 * collected Mauro's Reviewed-by-tags (note: I kept them though there
   has been small conflicts but dropped it when reworked)
 * dropped: "EDAC/mc: Rework edac_raw_mc_handle_error() to use struct
   dimm_info"
 * split "EDAC/mc: Remove per layer counters" into smaller changes
 * added:
   "EDAC/mc: Report "unknown memory" on too many DIMM labels found"
   "EDAC/mc: Remove enable_per_layer_report function arguments"
   "EDAC/mc: Pass the error descriptor to error reporting functions"
   "EDAC/mc: Remove detail[] string and cleanup error string
   generation"
 * moved to the end:
   "EDAC/mc: Remove per layer counters"


Robert Richter (10):
  EDAC/mc: Split edac_mc_alloc() into smaller functions
  EDAC/mc: Reorder functions edac_mc_alloc*()
  EDAC: Store error type in struct edac_raw_error_desc
  EDAC/mc: Determine mci pointer from the error descriptor
  EDAC/mc: Create new function edac_inc_csrow()
  EDAC/mc: Report "unknown memory" on too many DIMM labels found
  EDAC/mc: Remove enable_per_layer_report function arguments
  EDAC/mc: Pass the error descriptor to error reporting functions
  EDAC/mc: Remove detail[] string and cleanup error string generation
  EDAC/mc: Remove per layer counters

 drivers/edac/edac_mc.c       | 496 ++++++++++++++++-------------------
 drivers/edac/edac_mc.h       |   6 +-
 drivers/edac/edac_mc_sysfs.c |  20 +-
 drivers/edac/ghes_edac.c     |  16 +-
 include/linux/edac.h         |   9 +-
 5 files changed, 249 insertions(+), 298 deletions(-)

--=20
2.20.1

