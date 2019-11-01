Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B77EC4F8
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKAOsR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 10:48:17 -0400
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:63947
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfKAOsR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 1 Nov 2019 10:48:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8lv8J30kzqim3MKI4GLl9wgP5f7aRyrzRHZ0zu000c1ScljkdA6vhzBaBLLj2KA8dft0zrf5LOr+2hDASCFxA5IJpJrCxUI5ZLKUGH3GbcV6qrLkYtooHiNLDCwF8kax/YsKKbdbvVbJAMUiGYn4m9UQe/Eq135J1fqTL6Ann0KlIWNDmC2E1HkqY5WbrghLMo5hEIHZdgCOp/O5ot6wURHaqNLeZMP/DlRdMDVBotCtfA9Wpxb27XQTdssnmlQYJfwS9QGPMab0PrWynP47RsRwU6YW7/Yy7GsBEE+10XfvF9O9tB3/6aIHW5u4e+yyb3jc+vRUAQ5hrBAjdzosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEVovOM9QwXpAcK9g+5Bn222O6iwSGTSqokHALh1lro=;
 b=XvymZsKGiN20R3KC4WMEJxYi35fjnGsvCcQ9MdmDbb7A8BiYwrSTUU68NLdkpkJ6aCUEnQzVow/ubexMJmB/ROqVo4RBGCaFCPybm1gdfyQJCrSGaA3xfopGHA4F9US+XXRxPKul/bjdyd9gG3alW1w+PdE2zwaJa7U0gSbF9GJG7ayPnZZRegot8U0Bvv3oHpjmxLfzyLbrutelzZ+yrw1QQUIg7VWJIA2Rc/DWBK6jJxnaIIs4FUHgcrZQ8/JE+2qM+rYo5/lMnWHeXzEO2PDofGsAP2Q7skuzQN9nAwdlFP9eBeml9PXqoC5QkgMJKhX7Lxey6p2a1FrEKH6JVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEVovOM9QwXpAcK9g+5Bn222O6iwSGTSqokHALh1lro=;
 b=hbQhbcnwetMKj1PmHYWmTI/Qn8fFp7ElY320Xw0BHgt17exkKgoTTX457cOckjX2ZiCiSakdwxuvfdpgrbJ2DKMIT6kPpnN9J3zdZz7mJlSslyB9a5gKCDdFBBVe+YOlS/LfXjyTeB0muCCLqB7Y8nBbmI8qgkJOOtNDXgOvyRs=
Received: from BYAPR12MB2630.namprd12.prod.outlook.com (20.177.124.91) by
 BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 14:48:13 +0000
Received: from BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528]) by BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 14:48:13 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>
Subject: [PATCH 0/2] rasdaemon: Add new AMD SMCA error decoding
Thread-Topic: [PATCH 0/2] rasdaemon: Add new AMD SMCA error decoding
Thread-Index: AQHVkMNiNm2YvPLgSkWqoykXY4msig==
Date:   Fri, 1 Nov 2019 14:48:13 +0000
Message-ID: <20191101144800.20803-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0017.prod.exchangelabs.com (2603:10b6:805:1::30)
 To BYAPR12MB2630.namprd12.prod.outlook.com (2603:10b6:a03:67::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54d627bb-3987-457c-899e-08d75eda8545
x-ms-traffictypediagnostic: BYAPR12MB3525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB352557887163BF8A7C70546BF8620@BYAPR12MB3525.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(14454004)(4326008)(486006)(2906002)(25786009)(26005)(305945005)(66946007)(64756008)(476003)(6512007)(186003)(7736002)(2501003)(66556008)(66446008)(2616005)(66066001)(6116002)(66476007)(8676002)(8936002)(36756003)(1076003)(3846002)(478600001)(71190400001)(316002)(6436002)(5660300002)(81156014)(4744005)(99286004)(6916009)(6486002)(2351001)(256004)(102836004)(50226002)(5640700003)(6506007)(52116002)(86362001)(386003)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3525;H:BYAPR12MB2630.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWLdh6mTUyjhnoCYJl5PpYe4aD2583iPPQ0TJXq6pwIJsq5Rygli74hOedUNI08hS8LwJlT8T71IIRwVHz/R6nuI+ae0dcH1eMmNOYq3AjybnViV1n4CUuddvlBsAcFgFUYLiz++Nl3jPQ3HvGSfPRYS25trNlQtT2FBdrF8LzIBVz/Qu4fC82xiP7iUe24+4KP9SE7OlA51823FbovP8Jrmk3unUKuulAOR11knbdEUhpLe2rSjkzwTTvygVuvSvUzKCVEeSoqYy6DEfgueOY0yJjx8F+l01tNn7GsRr0jdp8D8eKN9F2pQSutgBoely2j0BpmDr+hApPYMy5JaiBifefjhQWH1GOc3+QPWA3ZCyDnHqNzUdNuMUy7ssLCpaAVWRYx5/eMZj1HrR+fo7M8nlVeMtm9XI6cUwk0stBYAt/QTRcB9m8jpywcQVgC8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d627bb-3987-457c-899e-08d75eda8545
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 14:48:13.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atvdT8DeNKq8cnN5xl0RmwL9vPqTMufwunuoJFB8sEiieeVogcE3DBExOd7FMmOJAuwzZ8CGEUfxveCivaoHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Mauro,

This patchset adds new error decoding for recently released AMD Scalable
MCA systems. Also, the CPU family check is changed to a feature check.
This is because the Scalable MCA decoding should function the same on
any AMD system with this feature.

Also, this set was written by Brian Woods at AMD, but he has since left.
So I'm submitting on his behalf. Please let me know if I should re-do
the Signed-off-by's in another way.

Thanks,
Yazen

Brian Woods (2):
  rasdaemon: rename CPU_NAPLES cputype
  rasdaemon: add support for new AMD SMCA bank types

 mce-amd-smca.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-mce-handler.c |  10 +++--
 ras-mce-handler.h |   2 +-
 3 files changed, 119 insertions(+), 5 deletions(-)

--=20
2.17.1

