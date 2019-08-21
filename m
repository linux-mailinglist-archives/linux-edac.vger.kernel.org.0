Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D69882E
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfHUX75 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 19:59:57 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfHUX75 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 19:59:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMpZT/H+zChS1wad3/vkpKQ11iHqrjkjm/9FqMNqlBUnPlBkPcSxNaaV8OeJPUvfqXxN9Qzp03SaqtK5pdVcV9gY4Nn40ybDDZ7B6EOOkiZPUWt19aTQjtnPZsd6Jb3XS/oSOWwn4CRY85hRyzu7Gy+XRjcPe+s3dFP9bptJ4Mb98QRKlND/pZ3Ya3DDsAOC34rK5qM9QXfly7Ko2BGdUpfy4O+3xNMnJH5nKdLjnmYLqRS3wk+OC23+vRLnUYYfpO59Wl89Tgf81U1ATVv2giNW0KCQPsgrKxYtbfkGmKFJ+0K9JlHuC+dIUZtGSj/o7lNRNjoTKfOPePW9DE5Vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKggGy3Ls7+UFE7JskUtb9vMWRIDLBCdyheCExTksoQ=;
 b=XRkXEHa2yMq5QpdnoHV4Nc4PC+sGOFdr+7EUsfUjMfx0Q2B+IFG7UANTAURzcp3c4RPuvQXGEpgf6ZEEQT/v85jHxDzwXEMjyeMUiPS9U2vE0HqwegLtsn4K4FvN1OEOLBfl20u3Ourw/e3lqZoT7B9QtLHu1devwPq2fbMkPXVr+bmOf9GRAltyRiH675LCXgJexqOOT3W5iogjuG4k0yJU+2TbM3ITxdWU393dnx60Yq/fN6vUIIuZCZGTGI/Wo8e6aVrKERkRpDE0CchXExRsSyzqkwwUsNr4ZrZx28tg6k4aQqpfoPo4ArBZ3AoHOqWu91U0BcZf64GyrayM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKggGy3Ls7+UFE7JskUtb9vMWRIDLBCdyheCExTksoQ=;
 b=y1uQwjqBTUXlKdXs1oxe1JlX0Zs/Cpw67q7XTCfPgFxQuLr3CKCwIlsKmARe9DIvlRJh9L8kDEyNNhRbqoQn/S1BM5UjijTaabK6VNII39jeXlkh2uTZAr+iDGdaEA91Vo4oK0nOTQXpn7K+7NVGWf6bMEhHU3wAUHkXTVJ538U=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 23:59:54 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 23:59:54 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Topic: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Index: AQHVWHyGkq5ZZJpNOUKXQmjNKGyrbg==
Date:   Wed, 21 Aug 2019 23:59:53 +0000
Message-ID: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e35ab55a-d07a-45c0-217b-08d72693a922
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815739C2DFCE08BA84570A9F8AA0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l5MVJimNaiPTU8qmgXkTwWd9XdGvsVQ9Ltp6EKsC22PygJkjP6KRbMD4AsU9nulot/0kwb/kyAKeDPOyJjxTM+KTMlNFLLnusl8Z9dq4xxdssHfz8rMzU2cn5hxuMchACHf+zmRFK5Ut9FWH0taWjETL238p18/wE0tWT7gizr4Di8bP3ez9I0xn+iugYLjy5vkENf0a/0FloknI6zkPbZV4Tm5ShFoPp6gc5rdqGRnuxC9r08tUfld3JXCBrCORcvvVeUALZhswefAJnP73nprf5M4I9cDdXg1ivmMqH86rwMBei7tTe90sKG3dUYW2yMGad5pjkn6jYwLURpNXXRkzvh1mwdciu/t2L9ch6yR+EUQ7bF4pHiSWzvn403Oza55FuSF+5DuTjxL0gQOH62WAv8iDgn6ZJHvEmX36b5E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35ab55a-d07a-45c0-217b-08d72693a922
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:59:54.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pMFkVGS2ryHUO9IFuEvXVlr1gl87TsVg+9Y1iKxKaEgHf+4QDJagvyIaX9C49SP2Z0viwzJsMrykIhJB+L7hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

This set contains a few fixes for some changes merged in v5.2. There
are also a couple of fixes for older issues. In addition, there are a
couple of patches to add support for Asymmetric Dual-Rank DIMMs.

I don't have the failing config readily available that you used, but I
believe I found the issue. Please let me know how it goes.

I've also added RFC patches to avoid the "ECC disabled" message for
nodes without memory. I haven't fully tested these, but I wanted to get
your thoughts. Here's an earlier discussion:
https://lkml.kernel.org/r/20180321191335.7832-1-Yazen.Ghannam@amd.com

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20190709215643.171078-1-Yazen.Ghannam@amd.com

v2->v3:
* Drop Fixes: tags in patch 1.
* Add detection of x8 DRAM devices in patches 2 and 3.
* Fix Chip Select size printing in patch 4.
* Added RFC patches to avoid "ECC disabled" message for nodes without memor=
y.

v1->v2:
* Squash patches 1 and 2 together.


Yazen Ghannam (10):
  EDAC/amd64: Support more than two controllers for chip selects
    handling
  EDAC/amd64: Recognize DRAM device type with EDAC_CTL_CAP
  EDAC/amd64: Initialize DIMM info for systems with more than two
    channels
  EDAC/amd64: Find Chip Select memory size using Address Mask
  EDAC/amd64: Decode syndrome before translating address
  EDAC/amd64: Cache secondary Chip Select registers
  EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
  EDAC/amd64: Gather hardware information early
  EDAC/amd64: Use cached data when checking for ECC
  EDAC/amd64: Check for memory before fully initializing an instance

 drivers/edac/amd64_edac.c | 371 +++++++++++++++++++++++++-------------
 drivers/edac/amd64_edac.h |   9 +-
 2 files changed, 251 insertions(+), 129 deletions(-)

--=20
2.17.1

