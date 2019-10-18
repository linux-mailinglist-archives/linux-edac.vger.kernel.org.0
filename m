Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8608DC880
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408771AbfJRPb2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 11:31:28 -0400
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:25120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408707AbfJRPb2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 11:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxcFbBOG0I+qxoBrmELebOcuNF0eHsMKqIE3AclSAO+UwyTqVILt1VLWTFlrpa1J983/3jtmNmtBcOXwGGpI+vve83mHChBWkR4VhicaDyE22x9bdq1DPGYMp3LLThvMX/1AMQ1ksSbY9uLrejzA4kk6+xdtFuyyI7QZH9r50XyTsg8RY249PwlcoVgcR3bML2VmLOHotp1ejya+kkecUnaVc7i7z/BSRvmnFz+O+TlXOMWmsub0HEJnbnPsZbyVK619A/xZlQGVzPTr2D85gvB6uCtm2X01nxOotULjoQoy+SoGQyrGWJl4GitrdtBz3vm+2pcFTz5J+gpS2LO+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iku+TKnvbZmtq9iYbqUwsbJE3nAHw2CQQfrwb9S1V5s=;
 b=e/QWG+42nnUz/pTg3Lk3ukz+XDcILhAmPAvR2szpEYdUSbdpCALjGfvig0RPcbzatuqmcsDqrnnM5Zc8qjGecvNgfna23sHVdYky7F9KWm1NqRHXFTCswxDW8COOBuSFTcetqSQdePYJesiHjD9Ja1bZx5p2kxS7VTjsbJu/4klE/Q4UlifvPC9795zs1H1F50bd2stYy/sLBc7y2IFtpTNNLr+VR1S01xVoUkkOh8jcQMqszXsXfanVuTH1X+f/wwigfYbs85iZk8KykxWkF+/lzxqPDY4JnhTP1y5askdpnFJV+G0d85PIpWEcFFfUdnibxG+t7BGGyIydz8xaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iku+TKnvbZmtq9iYbqUwsbJE3nAHw2CQQfrwb9S1V5s=;
 b=IzCUbMDj2JsXOQfrrpZgH0Yeu41sRsGuoOb0vwI3J0xafppA9ZotGp2R4qubpjZ3HlJhzxQPOtb5qT3tJSm+gY9Kr0+f3ZkqwL8wj1NIef08cgH7O7rsIPlaOcH+aeLtyzgptKjj+i/fxsgl0wAX5RP9Cs9afI3lUG9sT7wILDE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 15:31:25 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Fri, 18 Oct 2019
 15:31:25 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVhcka4q8ovNc5PECMwVgUuntBSw==
Date:   Fri, 18 Oct 2019 15:31:25 +0000
Message-ID: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 910463fe-e19b-4729-4e5d-08d753e03c99
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-ms-exchange-purlcount: 3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2670F38C9B08E94A15B63E43F86C0@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6512007)(6306002)(1076003)(14444005)(316002)(3846002)(4326008)(6116002)(66946007)(66066001)(25786009)(256004)(66476007)(5660300002)(6916009)(2351001)(66556008)(66446008)(14454004)(26005)(486006)(99286004)(52116002)(305945005)(2616005)(50226002)(7736002)(476003)(2501003)(478600001)(6436002)(2906002)(5640700003)(6506007)(102836004)(71200400001)(36756003)(966005)(8676002)(64756008)(186003)(81166006)(81156014)(8936002)(6486002)(86362001)(386003)(71190400001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mB7rMSiSxlskcrIfue65J/ZednmJSsYtr230Aez+z0FyRLbn4UUXwr+u+/Hctr6T3p1dzzwXd0BFrQXlURMcnwk6wPg4fsin50oQN52F+d+Q31H6lkQgrCMdt1yEUTxQUPRbqFsvIvYAZNtAZaQRhzCYeyd6WA6XB3PcR4F5AFeDdFqTacnFLGpnK+ogoa3PBSam0c4yxtcUdcojAD9/KGAhG9px5S9u2l4r09Nrq2NdZsZgi+UDJW4aOO4EnJWidj1pFOgV+uBqB1pTyPRU1NmaZVggCXF5wSEslTkgQpz3AQiDmSJ2VewPySvqZqa+2vq1cqxmtFVrWo7QRIMe36tYEgflwy1Lm/3CM9+4LNn37+VdE+IVCQNRbhU4/ShTydmuvnnZjhH3sExKZqIs+13PWo2TwglY5jj4BLe3/Bv6Rc/WBYcICdArpBi+/Zqbh3OFUnwO63mo2zDZvact2w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910463fe-e19b-4729-4e5d-08d753e03c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 15:31:25.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6S718wxKGqaHaihR66pl30ww8ITXh2cJDK6hMXmHk4wXcGi0uoMHq7q6QEXZL+smMpIhoIbXNxDm+TqrDUAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

This set contains the next revision of the RFC patches I included with
the last AMD64 EDAC updates. I dropped the RFC tags, and I added a
couple of new patches.

Most of these patches address the issue where the module check and
complains about DRAM ECC on nodes without memory.

Patch 3 is new and came out of looking at the family type structs and
the boot flow.

Patch 6 fixes the "grain not set" warning that was recently introduced.

Thanks,
Yazen

Links:
https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com
https://lkml.kernel.org/r/20190821235938.118710-10-Yazen.Ghannam@amd.com
https://lkml.kernel.org/r/20190821235938.118710-11-Yazen.Ghannam@amd.com

Yazen Ghannam (6):
  EDAC/amd64: Make struct amd64_family_type global
  EDAC/amd64: Gather hardware information early
  EDAC/amd64: Save max number of controllers to family type
  EDAC/amd64: Use cached data when checking for ECC
  EDAC/amd64: Check for memory before fully initializing an instance
  EDAC/amd64: Set grain per DIMM

 drivers/edac/amd64_edac.c | 174 ++++++++++++++++++++------------------
 drivers/edac/amd64_edac.h |   1 +
 2 files changed, 94 insertions(+), 81 deletions(-)

--=20
2.17.1

