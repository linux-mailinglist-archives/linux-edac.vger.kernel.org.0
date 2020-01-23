Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3914641C
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWJDG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:06 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45696 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726099AbgAWJDF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:05 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90d8b023738;
        Thu, 23 Jan 2020 01:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=y0Fv4tsM3qKc/iejFLmEdEi1PE/u4L3sWMpVgHzngD8=;
 b=RA890xw4KhdpGH1SYz+7+YwHekgMbGhUQttSIg6z1RTEaoiFojSrKKGhoI01JLg2UYY8
 LyEY+MKNv2hth3vfQB4b0TGYw93jfr+5yPJqvImy73n6THeXTCyYrFjdK1PXH0444M5R
 bVzymk2p/I4QYZG4hUCJLCl0LkSXSwH1NfIS5swYfuTc2jONUty6mkij5GmZhBJYtHi0
 fwwxC6fTgypSQGs9ENWEo/ZS5HHoilN1EoE3j/Ija/vBFs6O48nUJuPN4YkIzNQT1icd
 a5j3DCasxLb3sl6O1RNW3ZEQoRMITcEG65nYCcHFijyNT5zDZomc1v9NWplVnAF3Ea/j qA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:02:50 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:02:49 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:02:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLJkqASaOh8eAERpHB5yIS0rPDce03lsHsXwICfiTFRnRyHdNEKUTnNCj7bIJClcjYjfA6oIOI868dmPw30fTL0r4BY+o3gA0nc8DqxKyh957VrxZWL1D+K0kXOtgaPaVUjL8J2NKIQLgHpdb7+bzqfw8ER07RNlHpnq7tIElylD8oW28paTfhy0urq3Rdd11N++NXlmn1fEzNCcTIX8ZPUX5kb5dnqBqi/uUwCZrN1O2CmO3HapgbnHoCxpVKiPb0FlvdcbnPpxtYG8j5yCmGYFa3PSU9TdEtXYQGqspWz69KgsN6nKHnTiAEhs8sLkvkzQF2Sm9ZWg/B/w+kJk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Fv4tsM3qKc/iejFLmEdEi1PE/u4L3sWMpVgHzngD8=;
 b=PzrViEl4QrzwJPLSIiSLNy7P79fsmksSjda4NhXQc0BNoc+/wR8kRW3w2FcFpWh2Lspe6NGP3/WE4rgympb/2XYNjbLKBf42+vU0NTP4mHQ9TsBBGcTZAogd2S5ybK6KYVqUSj0CxrBucZuOlcNFK8nMUicNDa289Af7XJYquAIHoxgJHQsPO4hM/+IXiVRirqdyMaMTFa7OeAcCRuTA0Wmz/V5YZZi6fBqdfk/kttGFTI5p+kpdoQvN4hYj7XsInnkZNyRYAC1yg9gvNYe5HDfC4TUlc+Hi352V5p1E4gvqUrfwOnEInpzxzK/wl3c9tsa/pIfIzblNQMrM5bqW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Fv4tsM3qKc/iejFLmEdEi1PE/u4L3sWMpVgHzngD8=;
 b=l7c3rFjZBkhCRoyHGbbcUUa1Et+g8DvsZK6vUrWAscCMftUs+zllTNwVV/TCK5psMPXB3FKYy+vUMsQoMMUS951nef9RtRJYhq9hPNxUyekGtMdsOqk4x6vdN0qwtRR/ZMvrcmPYMNifS2IFFA0trvnEb35R3DSYpvZohYCklo8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:47 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:47 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:46 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Topic: [PATCH v3 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Index: AQHV0cvhmlR2OtRki0mv4Uuf7wV/jA==
Date:   Thu, 23 Jan 2020 09:02:47 +0000
Message-ID: <20200123090210.26933-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1150782b-2b30-418a-f5b7-08d79fe30458
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB32479551DB51F509ED3588F3D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(966005)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mfh8O1Eh2ho690dOuWzdIQuMh33gzjj/rLxrZz/dAOF625GMc/uPXzJhccNL5S6T0BfgwxtSb0Slsyhl0rSkxdPM1MPwqDbElMHGIP8RHFRo1AWx3s8f2CBbECC7y+PzoWaLU+Ln+mfZX8anLZXyYtIgNvLN/Cc8WFr5lor3UtUS92hPaxQ0m5cFa6ZDkJUh7SrfX7D/Yer9Nj7+TtHHXstxBzrpLfcpAAc9fCAnwBnVz7elhlH9eS+94z+FTQBFKrFYJLXmcYa6zfANHtYX7UPMPyH6JzZGqj5Mgy2aJ3LvjSxLy6370Yd9Wp5E6JG0GE6ST5/1bcHqqGISjEONSMN0DdKSZ/zOduv2HwgyVIRk2MDKyzP88Md1Mj8fYSKg9NVobBEhQFrqYT7KzfypRUr5hU29e8yApTf0yxYpYUwGuIatJHZUhpI5m1Kh+IJP/HgypdJ85b6HeaDj64SprLhknwI2kUjkoaagoP1JgOw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1150782b-2b30-418a-f5b7-08d79fe30458
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:47.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVM6rQSj5219vXgTKsiRbwGPa4O4YVQbUjbSQJ1z0XHfL/fs8gu6BpB5pIAyIxUOHdiq4uq6xqxyailUPC7vZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
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

V3:
 * rebased onto edac-for-next + "EDAC/mc: Fix use-after-free and
   memleaks during device removal", no code changes:
   7e5d6cf35329 ("EDAC/amd64: Do not warn when removing instances")
   https://lore.kernel.org/patchwork/patch/1169444/
 * added Aristeu's ACKs

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

 drivers/edac/edac_mc.c       | 502 ++++++++++++++++-------------------
 drivers/edac/edac_mc.h       |   6 +-
 drivers/edac/edac_mc_sysfs.c |  20 +-
 drivers/edac/ghes_edac.c     |  16 +-
 include/linux/edac.h         |   9 +-
 5 files changed, 252 insertions(+), 301 deletions(-)

--=20
2.20.1

