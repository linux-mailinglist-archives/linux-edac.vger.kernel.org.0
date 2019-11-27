Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B610BFF4
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfK0Vy4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:54:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7298 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfK0Vyz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:54:55 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLniuO004627;
        Wed, 27 Nov 2019 13:54:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=3ou5LSPKzHI7VRUtHJwVEDsvioukhl0QAzjiQwo506c=;
 b=PuzDK/lDBOAywNwy/seAR9XZF3eBkkcEHfGFlDdCFv6+XnudWyEnsslxg40QWqiQcnXm
 tHGsSXrb7v1/XhWBofM3BJjrUHbJlpd13pO4KP7bic5J0JTTA1ynzbtVZffhkeg3SRki
 +M9Z7xPJ3rnzwpCHb3wbPWgry4LbPOj+l+HDRRZjTgiapXWhKXcy8jsvm5/jG2TLoqKk
 fR3sCGxW99MKKh7v/9qfyqDF+jpJ8P7n9deDXFeOfH/w5S7wPtgzrsACVJ7Znv52UiQh
 Q3DIujdiqxiz3Cuh8RvQPiMHPOI5DSA/nli3M2bTsL7frpxjMA70GWIwatjRL37J7qN7 vQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:46 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:45 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbDMy5djV6VKu7wtf93cCvON8we5fcK0W+s5OAWktKU7dDtFFHNd9hwTW90rjGAGMqU1FtgY5FfaujMhRA34bF0H+6ZiAdGhfP0te5/I6qv7qXoa7zZmLO65+MCbJD2SYxxFzlJYMjkPq/udWY5vtqPc5LX07aiiSKqkR51CfI/QZRdTnwLszU7uFcy0UR/ivPIPilO/Y4TOvjbNKFzjHZlRaqT6KfZ2h10GoeucAedtQwPdwZMiTokQiaw7aMyTAy2JurZTOJeXnUMpjkBsVlvEMHm7fNjR9Fvm6cxSZ3oxX4HkdvSLuhFuS9ypV5lv7m6TJQ0LlVzhReQtml1Kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ou5LSPKzHI7VRUtHJwVEDsvioukhl0QAzjiQwo506c=;
 b=BZ3hHY2O9zd3kRW4TJP+n+Tra+zgrqMBh/SoB2LtgCANrIB15Y4/d/uHaXAgvq7E9AiaTLlU+B2/aUWEeKtvjzMm3zPFy320k/XHvZEbVBRYWEhUFXaQeDm4SCzspGyeS8SKhU4AIzTL3Pdoe9nw7fY1+xMA8MRSJPAefEYEmvd/Oykv300ndTF9iQO3OV4QNTodPheieEe8VbL/zIcUprz0vNgoRmYvY8NF4WJN/SF55VXQtMweQLftgD4WdX0jxG2a1dT6DszIwAKhV3c0GRmeaDU/bpCosUhH6Tp8i6RCEIAC4KY8aFEEv7mFaXR4JWGNoyJWfliR14E+aOdWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ou5LSPKzHI7VRUtHJwVEDsvioukhl0QAzjiQwo506c=;
 b=Ek5kM6EezUiegJcvLh6OVfBk/Vh0gQIaq2VoySw8tfArduNz4FT/RhPnT7EyhPeN1sSWviKxVmGfrL/1U1XLAK4riNnRCI5cFmxXIHv+NlG59FCdpscxtbka5wlKm3Y9v+j8Ds4RPjUYLekESs0WBl3mw4O5xihivXqTQTVCazY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:43 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:43 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Topic: [PATCH 00/10] EDAC: Rework core and ghes drivers, part two
Thread-Index: AQHVpW1G1p0gsbgfOUOkTAsvn77vZQ==
Date:   Wed, 27 Nov 2019 21:54:43 +0000
Message-ID: <20191127215415.11230-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07841ab0-4dc3-4770-01cb-08d77384694c
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24770FF4CDCEB0B18286CC8AD9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(6306002)(256004)(186003)(1076003)(4326008)(966005)(86362001)(6436002)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Url1HfyNy/qnK8vNFCjqDNaA+GDyk05IAZ6tZLhpeFYweQzxiyyDReoV57vu6Tq7TIEG9HdW/zwD+81wq89PtvmbGT6MmcJvXbCKaOCboTP2Iwr7xX8jGDAdbxjBVa8v8WLUJbvDavTjDi/M0BF8/E/vGtTh3KD2mSec1JZRNFba2Jk1veQm9/3T/JAGyE+TpHQT+R7U0biLrLokZEjOqhoz3Bg2qI4yU1xFwtlvYr+4d7dgz8c9Z0LTwQFhuaSfkTftQ7ebkbdsG7DEVQQnH7tR0f5hfAfCrr62Ar/wdZoL25D95TlncQTVQ0MxoLHV1Y2krWa6Hzv8yHJKjYO+a2UCW4ISwbPSzpLcAFhDg2xzFqZK+ADZKshuNJhKjj/Lfx28FtFmUPcauhXEd0gHQAGkjBEJnd1T8CtMvUrjThvUrWPykC+b0p4aWm7Sc071rhRb6M+mb7qSL5RrPkB6IE6ZwgTVWX/UgWzndrsloMA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07841ab0-4dc3-4770-01cb-08d77384694c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:43.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlNa4iRHT7dOChwqJgim03OADR9mMXXztjHBvghn7aScVoLShXv7406GqWmHDXA1gXPRgUAzVQ7/jjFIw7kWCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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
 include/linux/edac.h         |   8 +-
 5 files changed, 248 insertions(+), 298 deletions(-)

--=20
2.20.1

