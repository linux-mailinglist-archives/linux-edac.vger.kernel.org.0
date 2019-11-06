Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4044AF1267
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKFJdT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32502 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727618AbfKFJdT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:19 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UQxR002783;
        Wed, 6 Nov 2019 01:33:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=p2asbBPKuTPQwL9Z1tgP4EbxKegqCdylo0cRHfNbaAo=;
 b=Jc+eB01yb/LbpLJjVTw1pt5RWxm5ZKZLaoTkSJDT5IK0Tnr03M5355Z714Yg8BzrCj4U
 BBTx9pQeWNEKMDD4RY+9iQDY/WXLVcQeVC7zKe424D7Xy2bUGniOVGY2ZHYnmm7bOW9I
 gQhc3OQlED5CHhboVMMYZxt2hYRjGiQM2l8QjXwValqemfOrc+J2iO9DEebD+lZGLDBz
 suPFeSwHfN5vg1i72tlWyFx+gJWnOSfJCaAUZGAriehIztFk0axZrCId5Np76Pw2x+8x
 dS1JdMrH7C1OGE7QxIrFExp/NVunFnJObuXeEV+OGLfwMjbGGoTTNA2x+Si6WPeCGfKB uQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:02 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:32:59 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:32:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMHVWmPpPKQE42fNj88GSNCgAtBTP7o2rNKlA/SL5Efn7W5tDV14c27ImNcsLeo/sVUzLGp777RQgwg9c2rKBVYjbfN1KR7ixnnkeWpMVFxI11r/vfzGaoNEsbkrlUUuclonObf6R4U06F1kictDulQJ8S1yZzbAUqbcaEP2eOU3EpuGRIZkUZP4/iuqDT3JXxrX1L00IOf2/OGapXX6eS/2DJTG66T9a18uW3166NjE73Lnw4H8yDbJXU+22f3w4JVRPcBFlvbGvrkLnpDeM6cnIxRoNE/SR+AZA9qd2xv9HIawd8CU/UjCqgY/lgtmal5NnjgAzptZCCwTI4/kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2asbBPKuTPQwL9Z1tgP4EbxKegqCdylo0cRHfNbaAo=;
 b=CIO/6pyxq5kHKj9NPe9N7Sb6GHlOiNauRXKDRt5XaCUlnZVatRwcCdQxiN+cdd/HSyQF7f1YQyDJg9/2oZXHpkqCuIqSGKYj+rBgm/B6CDOQOYkPhsrhwtlxpPKWtZufjsHjKiy/qEHGpFDr6vJQM1+EoxhWhfMZga+y2jG5oifhv+FkiZxFj/uWLu0bDeEUOP+Fy97lYNvIZscj1TM334+e0zC9uZyF9U4UPSCiMKonjFQp9X61jMfAOY3LHnfTheNO16uo2tc4sWy/tCPKvoYwysO/s+vFH5MwDaWECTzmAfH8JiF83ZUFp+9jILXMmnkfT0GcCBmvq4vGJEyovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2asbBPKuTPQwL9Z1tgP4EbxKegqCdylo0cRHfNbaAo=;
 b=ZJFXaI/mGzFQOWz9VHf/3uFW6ZEprcFQdzD17ERc6HpasWXkijcZbKLNBUrXfPZvtJZ0baGYw24t8mkbTsVEhUHHS+PZk36FHYm8BPQEI4P2pK0+vEzjB/eH/bmBnuNhDPC7nECjY8Idn7b4L1lNANr9p9TsHga+bAPq2CbPUR0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:32:58 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:32:58 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/20] EDAC: Rework edac_mc and ghes drivers
Thread-Topic: [PATCH v2 00/20] EDAC: Rework edac_mc and ghes drivers
Thread-Index: AQHVlIUsauSGdd6usk+YjQIQVCTkCw==
Date:   Wed, 6 Nov 2019 09:32:58 +0000
Message-ID: <20191106093239.25517-1-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 7e694da3-a4d3-4903-0662-08d7629c4f2b
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165083D4CBC58C73909285DD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(71190400001)(71200400001)(256004)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+6FwMwePrMbR8iPhrhao9WICM0m/v/3aMBYKa1266kXg7dmKg15sD0hRCcgj4gEPrd4pa+dXaRkgYagycbCAa6rqDGg833p+f8OEeMQOMPz/eNxZ+l0hFHEzTGtQABwvGhjJmreZOgC3C1ogaNUx+ECWBvGOKh5SIO+0LgR5DlZiOAkMz2J0doNqiMkn2idU4DZ3+VkbFNah3qxNddM3ZmZCOhiQpWc2gwD4s9uLTTe6TE+7eQF9eeWWokQH7G6Zlt7HlaN6+bckTjLElpF9cqo7Wdi1tUS+qp1iIh0bkIB4zeD1ZOXebKKVXRgFACJIAv7BoIV9kIgtUvewqiybsq854Spu4s2hcPbQ+cz8jqAn/oGufppS8KZde4JVMukv9AsLGSDz3xc/txNGafBgmnyVNAYdoAwIILkoH5zh9BF9gAimk+yytE/S2na4iMD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e694da3-a4d3-4903-0662-08d7629c4f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:32:58.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iss4iLQyR2rVCQqnYOBbx9xtiGyiPllIoKCAXAXf8OVYTgsVpB+bho/FT46/7/6qjxwwLrT2rnWrktIq1Mb0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set is a rework of the ghes_edac and edac_mc driver. It
addresses issues found during code review and while working with the
code. The changes include:

 * improve function interfaces and data structures to decrease
   complexity such as number of function arguments, unused data, etc.
   (#1, #2, #14, #17, #18, #19),

 * add helper functions and factor out code (#3, #15, #16, #20)

 * fix style issues found by checkpatch (#4)

 * improve code readability (#5, #6, #7, #8)

 * use of standard kernel macros (#9)

 * code unification (#10, #11, #12)

 * documentation updates (#13)

v2:
 * rebased onto edac-for-next and ghes locking fix
 * moved adding idx to struct dimm_info to patch "EDAC: Remove
   EDAC_DIMM_OFF() macro"
 * added patch: "EDAC, mc: Remove needless zero string termination"
 * added Mauro's Reviewed-by: tags
 * moved patches to the end:
   EDAC, mc: Remove per layer counters
   EDAC, mc: Split edac_mc_alloc() into smaller functions
   EDAC, mc: Reorder functions edac_mc_alloc*()
   EDAC, mc: Rework edac_raw_mc_handle_error() to use struct dimm_info
   EDAC: Store error type in struct edac_raw_error_desc
   EDAC, mc: Determine mci pointer from the error descriptor
   EDAC, mc: Create new function edac_inc_csrow()


Robert Richter (20):
  EDAC: Replace EDAC_DIMM_PTR() macro with edac_get_dimm() function
  EDAC: Remove EDAC_DIMM_OFF() macro
  EDAC: Introduce mci_for_each_dimm() iterator
  EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
  EDAC, mc: Remove needless zero string termination
  EDAC, mc: Reduce indentation level in edac_mc_handle_error()
  EDAC, mc: Rename iterator variable to idx
  EDAC: Remove misleading comment in struct edac_raw_error_desc
  EDAC, ghes: Use standard kernel macros for page calculations
  EDAC, ghes: Fix grain calculation
  EDAC, ghes: Remove intermediate buffer pvt->detail_location
  EDAC, ghes: Unify trace_mc_event() code with edac_mc driver
  EDAC, Documentation: Describe CPER module definition and DIMM ranks
  EDAC, mc: Remove per layer counters
  EDAC, mc: Split edac_mc_alloc() into smaller functions
  EDAC, mc: Reorder functions edac_mc_alloc*()
  EDAC, mc: Rework edac_raw_mc_handle_error() to use struct dimm_info
  EDAC: Store error type in struct edac_raw_error_desc
  EDAC, mc: Determine mci pointer from the error descriptor
  EDAC, mc: Create new function edac_inc_csrow()

 Documentation/admin-guide/ras.rst |  31 +-
 drivers/edac/edac_mc.c            | 477 +++++++++++++++---------------
 drivers/edac/edac_mc.h            |   8 +-
 drivers/edac/edac_mc_sysfs.c      |  65 ++--
 drivers/edac/ghes_edac.c          |  56 ++--
 drivers/edac/i10nm_base.c         |   3 +-
 drivers/edac/i3200_edac.c         |   3 +-
 drivers/edac/i5000_edac.c         |   5 +-
 drivers/edac/i5100_edac.c         |  14 +-
 drivers/edac/i5400_edac.c         |   3 +-
 drivers/edac/i7300_edac.c         |   3 +-
 drivers/edac/i7core_edac.c        |   3 +-
 drivers/edac/ie31200_edac.c       |   7 +-
 drivers/edac/pnd2_edac.c          |   4 +-
 drivers/edac/sb_edac.c            |   2 +-
 drivers/edac/skx_base.c           |   3 +-
 drivers/edac/ti_edac.c            |   2 +-
 include/linux/edac.h              | 153 +++++-----
 18 files changed, 401 insertions(+), 441 deletions(-)

--=20
2.20.1

