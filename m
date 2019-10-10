Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720C7D31EA
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfJJUZS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46728 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfJJUZS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKK9d0030109;
        Thu, 10 Oct 2019 13:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=vTPZMB71TsAW0Qab0KKWazMmEEYU9OBibqyoYXvEONs=;
 b=idmTRTa3alWXFklYWuKQ6EBb1zYIk7F4qMfFkdJIPkuqFg1SishqnGMe9pD2bFctMphg
 MNOOecWHxc/H4DqcpBMlXWAq1exWYzvwiYPqTCrZMLacqC5wM89vh5h8y2uGi37d9r6V
 lVh7Pzgb2zkHlUmbBJVFOTpddhEFkulRlwESL+u9pDaGwXUgO65fNpsHDPRkCbjU1wj3
 9G+VqWzT/DTi3bSb1+aPn38W7l2Be9RzLPWymY4vNlTpyJSNyHeOu9HKyLX/ATY+KkYq
 th+0buTPLpL+O06EHr0I3nlLVT5h4YdJ4vCpv/OKA1fwFPQnaiuKMEo1sK9Yy9Uyt5vx LQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:04 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:03 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6unu8b+CPO11aJ6M7UjFI0CJ2j/7LUAL7MANv8/KsSTvzNjaWA5RdArBLyM9XWOlX1Ea7IhhxlUX1OM+1DnVwRxfsWPG1/gZSYvVFNNYSMaS+FTBL72l62p/T5fiaRMHnL89+aZz0HYuByXZYGVwM5X9ZCiZmPvdFon+5Ledgqxk3xHW8hPrOe1RwJzFi6dcU8QJQtctIY0FUWKy7A9ILMHfULSmljIEgUdJCFm9LCDDziewkeRznJuFMsmhkpz9bB481fj6LNLRU+GRjFtfoFxcvQp0/gokgNr/ARCArdijchMswpy2kuqoP2ttkRwZUSgpcLgYns9qBsZwZgt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTPZMB71TsAW0Qab0KKWazMmEEYU9OBibqyoYXvEONs=;
 b=MexmPNdEr9gpuKifWiGePjGktI6XHoZh1kumZNDdVVIYbMFThOkh8p5NTFpjCjxRUnYWWFZqq5vwfKV5P66sYmzYTyIeprr60k7pCVdyk37lyfynEd9Ag1VjlXbZS7G+FQP6K64u979dxph69G1ShtwE85mPk2Kuxmrn3CPl7S8PPSaidD2A58u2A96uh2HMSnrwCUErqIEPz+hu6Q7fMidL8KAAQoYcf0rzWsM1ILpSgQfYjKNCAJzJ3meJBGyefS1oW2vi5GC3z2gg3UnxoYkTnWTaM1HMPTqdGdIUoMUzUV11tuZ0vUoNfdAG8fQhJFo/W0drbraPLphDg3turg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTPZMB71TsAW0Qab0KKWazMmEEYU9OBibqyoYXvEONs=;
 b=BVYkEdmGJwePlp3dk8ntjLzGUNoMMUcD7cMf7/XErtHWR5vAoEjriTCIckyoir1VG1grj0Wd0pHChA04J1+f1Sl9teOAJv3OuZCzBTkpiQHz6E2E7hhePvlzJrE1uuBEmQhPMxwTdX0w8MVcleQJC4MBAuJbUm0I4+fi90cBL/s=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Topic: [PATCH 00/19] EDAC: Rework edac_mc and ghes drivers
Thread-Index: AQHVf6jLshPLJWnlTE6zMo1DcW8g6A==
Date:   Thu, 10 Oct 2019 20:25:01 +0000
Message-ID: <20191010202418.25098-1-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 5f809408-ee34-48f3-e246-08d74dbfeda9
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2701D6B8CCE88488043691DAD9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(966005)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(476003)(486006)(6306002)(3846002)(6116002)(2616005)(99286004)(1076003)(6506007)(4326008)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FL1WOM+GlfHuUZ113LBSsocmDX0YI3Qge69p+r9o2TaY93MUTXnpjPvCkSli7jC1jGKIbt0mmxEJrM2sn6icunjumQSGgEuDuoZwG1IcAS76BFSpKQXh6cOy7shXiSYNQkRtf9OHL6HD1oL+PuB+pJzMUZ8Pzk6g1Uxyj6rW90/TKs7fWns5QUHGXTNhgCLq1hPbqIcvi2t81x6hJTBoCy7gIb9a+mD3EI4RomT61QivPGxyzr9/imX4/9SRkjJ/3IEDHoK5cmBZmTSpjn4Fav2aPzN+fN1s/ruxohWZvmyHoAdz9WIU5GRcqbmxDOdhgNe/7NWQfkHOHPhgSF4gTqJ75ukrcshvvnxAA3/AFMFRtSuG2dY13PbnscFRHqp0S7JmKZIOYAV8DmnL4PIPJCFP+k76yqqLKTlh1+TOpYbnhtNvvaH5DXIZDMPa0Mr7sXOPC2luakBsTTWaridzbA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f809408-ee34-48f3-e246-08d74dbfeda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:01.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+aI8dyvc8KU4BnIsOsFTb6v+oYEQbbGFE/YaSPna408/z82Qkk8enH60iG0rasR0pQ7b+8PsZFS0jPP3F+Kng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set is a rework of the ghes_edac and edac_mc driver. It
addresses issues found during code review and while working with the
code. The changes include:

 * improve function interfaces and data structures to decrease
   complexity such as number of function arguments, unused data, etc.
   (#1, #2, #6, #10, #12, #13),

 * add helper functions and factor out code (#3, #8, #9, #14)

 * fix style issues found by checkpatch (#4)

 * improve code readability (#5, #7, #11)

 * use of standard kernel macros (#15)

 * code unification (#16, #17, #18)

 * documentation updates (#19)

This series contains some patches that have been posted and reviewed
earlier here:

 https://lore.kernel.org/patchwork/cover/1093488/

Review comments have been addressed and the following changes have
been made to those patches:

 * rebased onto ras:edac-for-next (v5.4-rc1 based)

 * reworded patch descriptions

 * dropped hunk that only reorders code in "EDAC, ghes: Remove
   pvt->detail_location string"

 * updated description for edac_get_dimm_by_index()

 * updated description for edac_get_dimm()

 * small style changes in "EDAC: Replace EDAC_DIMM_PTR() macro with
   edac_get_dimm() function"

 * use unsigned type for dimm->idx to avoid need for negative range
   check

 * fixed mci_for_each_dimm() loop in i5100_init_csrows()

 * fixed off-by-one in mci_for_each_dimm()


Robert Richter (19):
  EDAC: Replace EDAC_DIMM_PTR() macro with edac_get_dimm() function
  EDAC: Remove EDAC_DIMM_OFF() macro
  EDAC: Introduce mci_for_each_dimm() iterator
  EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
  EDAC, mc: Reduce indentation level in edac_mc_handle_error()
  EDAC, mc: Remove per layer counters
  EDAC, mc: Rename iterator variable to idx
  EDAC, mc: Split edac_mc_alloc() into smaller functions
  EDAC, mc: Reorder functions edac_mc_alloc*()
  EDAC, mc: Rework edac_raw_mc_handle_error() to use struct dimm_info
  EDAC: Remove misleading comment in struct edac_raw_error_desc
  EDAC: Store error type in struct edac_raw_error_desc
  EDAC, mc: Determine mci pointer from the error descriptor
  EDAC, mc: Create new function edac_inc_csrow()
  EDAC, ghes: Use standard kernel macros for page calculations
  EDAC, ghes: Fix grain calculation
  EDAC, ghes: Remove intermediate buffer pvt->detail_location
  EDAC, ghes: Unify trace_mc_event() code with edac_mc driver
  EDAC, Documentation: Describe CPER module definition and DIMM ranks

 Documentation/admin-guide/ras.rst |  31 +-
 drivers/edac/edac_mc.c            | 478 +++++++++++++++---------------
 drivers/edac/edac_mc.h            |   8 +-
 drivers/edac/edac_mc_sysfs.c      |  65 ++--
 drivers/edac/ghes_edac.c          |  55 ++--
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

