Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A824663D96
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfGIV46 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:56:58 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:41787
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfGIV46 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXLfZ5O0tgBGkVchBS5bVfzUl2SBW9bznFVOmqkI4AU=;
 b=gCqhGDSURsprqA52H4i3Z7pClcYPxFo8BGEKwC+7ZfU1ZMlqNahuciMhQiYsf7GhCEnbe5TdgVLocZmA7ZsNnB7Iz67sCwFhJkMlu4U0OatpqO30nMreqPUgPK/5/NrBIV9NEopTzilZf1yWQwvjMBPmk4fs4qmJNRtsHPfWduE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2637.namprd12.prod.outlook.com (52.135.103.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:54 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:54 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 0/7] AMD64 EDAC fixes
Thread-Topic: [PATCH v2 0/7] AMD64 EDAC fixes
Thread-Index: AQHVNqE4C2hUM14zc0W5mv2Ndq5NWw==
Date:   Tue, 9 Jul 2019 21:56:54 +0000
Message-ID: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca7d8200-2774-4a46-2a57-08d704b85ac3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2637;
x-ms-traffictypediagnostic: SN6PR12MB2637:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB263718E15104D54537405399F8F10@SN6PR12MB2637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(50226002)(2906002)(256004)(4744005)(81166006)(81156014)(8676002)(53936002)(5660300002)(36756003)(26005)(386003)(6916009)(102836004)(66446008)(5640700003)(6506007)(478600001)(966005)(6436002)(6486002)(6306002)(6512007)(316002)(54906003)(8936002)(52116002)(71200400001)(71190400001)(486006)(2351001)(99286004)(25786009)(2616005)(2501003)(86362001)(186003)(476003)(6116002)(3846002)(7736002)(68736007)(1076003)(66066001)(66476007)(66946007)(4326008)(64756008)(66556008)(305945005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2637;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bs541YYLYBOeIBZzvLZabjTKTXtXEhWC+xY+eGIgZvo5HwOhGnxHWpIvSOgVRh2YpxZwbuF2oCZkQjokhoZKEv64ce1x3Dy03Nq0W1W99GWLV0E80uZJgwO5E1IuVcCf447OC5puTXjsQ4kXOey3d/rTp4bkYTPp14kpkybtd7F17nkmT1v8zAksbob64KeY4oOJVw1PhxjrT2qOTW5yQSpeOBj71xUk0v/NX9LtmnIfKCuFsFH8id0DhvCArTLyFMknQJaYLyzktIymsVF8TDZerVl7V/rTXYVtAe6EGwuKedMG0v2ise5zBGK//pkGVpNGy9mtfoqzpv/XQS00Yzvb6eMgHiz87ctLOM7/NPc7PJukrM8WJRV0MczG4kRcz2RxnFHM8WUiPQTl7jiLK3Z+qXRih8sq28tksFF7Yt4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d8200-2774-4a46-2a57-08d704b85ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:54.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

This set contains a few fixes for some changes merged in v5.2. There
are also a couple of fixes for older issues. In addition, there are a
couple of patches to add support for Asymmetric Dual-Rank DIMMs.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20190531234501.32826-1-Yazen.Ghannam@amd.com

v1->v2:
* Squash patches 1 and 2 together.

Yazen Ghannam (7):
  EDAC/amd64: Support more than two controllers for chip selects
    handling
  EDAC/amd64: Recognize DRAM device type with EDAC_CTL_CAP
  EDAC/amd64: Initialize DIMM info for systems with more than two
    channels
  EDAC/amd64: Find Chip Select memory size using Address Mask
  EDAC/amd64: Decode syndrome before translating address
  EDAC/amd64: Cache secondary Chip Select registers
  EDAC/amd64: Support Asymmetric Dual-Rank DIMMs

 drivers/edac/amd64_edac.c | 348 ++++++++++++++++++++++++--------------
 drivers/edac/amd64_edac.h |   9 +-
 2 files changed, 232 insertions(+), 125 deletions(-)

--=20
2.17.1

