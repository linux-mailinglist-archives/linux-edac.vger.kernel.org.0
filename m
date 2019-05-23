Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D7284CA
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfEWRUj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 13:20:39 -0400
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:46599
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731121AbfEWRUj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 13:20:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=sx4ggxpacaPJ6hNUy1Eu4ShOVLq7N6/+Vl7ZR0/6FDz4J2+p0KB+1ExBOUflwGcnEIDkpDJwdLJnyjdBh+W9PJ4+YR4L95C0b3ePnAzXzhlfmKfhxAVOsR1gCsQzgb/GtxCFtXQ7DhOpJmTb8zVdEycnyB6hJhLaHcHncoJ0PxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8M3k1xYYiKmn5XfjEsrxirQ7S0PPQBYDLQy+HW8AAQ=;
 b=mN0ff5Fxaw1NgajXwqHezEcV3FJLRpbUVN4F5G3a0icnjixthBDkeD2sRPohO44qY7ZSiG7S9EfngiUuuYCEHK9GAf4AH8qIVgqdsz86qWrakBFzZWnfUXIwEwj835/U+kWYs8pRDUzg8Q2phfu/hYRZaUpM1fUmJFGfc3wJK10=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8M3k1xYYiKmn5XfjEsrxirQ7S0PPQBYDLQy+HW8AAQ=;
 b=N2A3v/pjQyJET5y7bxtWnmuDiiZQvpnB7GUC5k3G73AI7lm82+e8pxTGy584MYIS4E3uPxZZt/2OpNZy8tm6Cdx2oQNQQFUssPJELnhlLjbUVfGsfsV1ROpiSRJH4UVJ1ag0WDcgCh/L4+QKxDYMYv/BvlL+0ag27Zk7o7VadRI=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (2603:10b6:903:bb::17)
 by CY4PR21MB0742.namprd21.prod.outlook.com (2603:10b6:903:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.6; Thu, 23 May
 2019 17:20:36 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1%5]) with mapi id 15.20.1943.007; Thu, 23 May 2019
 17:20:36 +0000
From:   Rui Zhao <ruizhao@microsoft.com>
To:     James Morse <james.morse@arm.com>,
        Lei Wang <leiwang_git@outlook.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Lei Wang (BSP)" <Wang.Lei@microsoft.com>,
        Rui Zhao <ruizhao@outlook.com>
Subject: RE: [PATCH v3 2/2] EDAC: add EDAC driver for DMC520
Thread-Topic: [PATCH v3 2/2] EDAC: add EDAC driver for DMC520
Thread-Index: AQHVEYUGdXz32HFNiUaYdLQDHxz2DaZ48+Lg
Date:   Thu, 23 May 2019 17:20:36 +0000
Message-ID: <CY4PR21MB0279BB0E40B86CEA485CF19AB3010@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <CY1PR0401MB1244FDD9E720C9D9C1F41FEE860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
 <b1e360bc-2329-3f8b-3c93-65380f62d6fd@arm.com>
In-Reply-To: <b1e360bc-2329-3f8b-3c93-65380f62d6fd@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruizhao@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:657c:5a11:ce39:5653]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84afae33-da0a-4b98-78f6-08d6dfa2f866
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742A254223DF979E595B0A3B3010@CY4PR21MB0742.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(66476007)(6116002)(66946007)(73956011)(64756008)(10090500001)(66446008)(305945005)(7736002)(66556008)(99286004)(76116006)(8990500004)(33656002)(74316002)(68736007)(6436002)(14454004)(4326008)(53936002)(8936002)(478600001)(10290500003)(558084003)(316002)(6246003)(52396003)(7696005)(229853002)(102836004)(25786009)(55016002)(2906002)(81166006)(81156014)(76176011)(8676002)(9686003)(53546011)(6506007)(486006)(446003)(22452003)(110136005)(86612001)(256004)(476003)(14444005)(52536014)(11346002)(54906003)(46003)(71190400001)(5660300002)(71200400001)(86362001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QSo/ACmgMCHjIorpBaNxwiSuKuiadXM7xvWYjeDtFbCPoR2itkcHs1R2t/9ua9wV4SWzqdAOeMp+X4XJbpGDsFsy/aK0bALj12G6e4Gj1r6buPRUA895bnl7zGNYI3WS2j7gpTq2tse+2OcCMngt2S1sOCLUvKgrjyWL3RjuzKpnJ0QA7jnMCigvI+BSZFB0HSbeolPIex8XghhR/Grg3755hC16nPlG+PckYPbfHlHSYtXhrzqtFPeONnMxsuGce9qfDsZVNo36yzj0IXw3a1EFtdCqe9Bk6Ks39DTJRfEBRY5xBSg3Y4/KX6LESVcpVMgFb4YBhw9aHrewLgqSXqlvo7cUfZa8lmQYiFfK6ayQzvxCOKJ4as0usHBsJM0VkTsrUga0xDpr9JukI4mLAGAQE6zXL0WVljvbiKonrzg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84afae33-da0a-4b98-78f6-08d6dfa2f866
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 17:20:36.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruizhao@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgSmFtZXMsDQoNCk9uIFRodXJzZGF5LCBNYXkgMjMsIDIwMTkgOTozMiBBTSwgSmFtZXMgTW9y
c2Ugd3JvdGU6DQoNCj4gSG1tLCB5b3UncmUgbGlzdGluZyBzb21lb25lIGVsc2UgYXMgbWFpbnRh
aW5lciBvZiB0aGlzIGRyaXZlci4NCj4gSSB0aGluayB3ZSdkIG5lZWQgdG8gc2VlIGFuIEFjayBm
cm9tIFJ1aSBaaGFvLi4uDQoNCkkgY2FuIGNvbmZpcm0gdGhhdCBMZWkgaXMgYSBtYWludGFpbmVy
IGZvciB0aGlzIGRyaXZlci4NCg0KVGhhbmtzLA0KUnVpDQoNCg==
