Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4DA6441
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfICIqt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 04:46:49 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50762 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbfICIqt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 04:46:49 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x838eSNw006123;
        Tue, 3 Sep 2019 01:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NW3oOyORFkUMTAjHynfbYRlsskxJcAfAx6Mw1gJNvog=;
 b=ynMFqHrraDYofHFn5VL2o2NdkDQRu2VZKw3kvk2nr0vv95qRmzScHYxy8wKgFw9RF3zM
 jlvUgZvrs5LwO6SvULMeBekAPqCsfO5LNX9WCQOnoyWzjB8VNNtsNyfddpvy/Ne0M2Gp
 Pn0Du4R6s9W+0fjiFjRxXb5RAf5shkLwDzsklF70aIoKsDdXuFpE7GKa9MYCfm9hkoWC
 eg/rnFdEpnQQqO1NKZVU5KcbMZ3YhtFhFCEEgOnACFq4Ysmpd8dmZgQZsdVj0UJFQUNn
 9hR12fbvMhWv27RxzziNSljIh/aXM8hyYnpk9nj+B27ZZfO6nADqlxmDZMPQXshy5gJW Cg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p9dts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 01:46:27 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 01:46:25 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 01:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzzfzIN6vxQuIxt4RaONlbiGmdbtp2rOg7qcXThoGtLelOiE1TLwC1TG7cOuYUTZojqtXX2cqPYCixyIwyK2Y9Qxo4Q/Wd+0AdCRMkI/Q3i3Jz4lMZrcB5JlcINTIEmdUFE7ZGLVlfQJ+gjyIRg4FzUHcSQTVxv2VWRXgB4gp+YCsMivE5GoB9aDVuLiFPsSzusj89B0edmAmj6TDwraTQKfngoLTZzqo/cPW5Kw08/ExsriRCnPpgA80g8j4KMOmYcF2mooWcb3ZDEsWVEbZbjtdkvbZsS7KRV0Y4C93kSc6/EPgpyxKfqmsGUQudDd8whgiVQIP17FqrWjtfiNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW3oOyORFkUMTAjHynfbYRlsskxJcAfAx6Mw1gJNvog=;
 b=E+akIc5JDDWyc8+HiRRPrXCwalC6lGiKQQvO8LEJZMbphOMrIjeNCcsk4FkVkmCwor7asF0ZKBYjGDi9qs009anWWKnzQ8un75NwdLppb8SJCTEkmHJ+2q/ER11Qm0EVAvVFK2vK5hFBIcTGqfrBzItElIlKGmIWsPIvETdJCksrnKGpoHLqpMQEGu7xfIzPUf3HX3yJXWR6evXOInKFAJPpJLZL+ZpbRr4m8nGySOCQozDEgnvHntaTBTxXIOc2uu12f+5KAGN+FVxPCZX8Svx2raVijTzZ+5h8WGiEcWm0Lu/iqR9Lk+IaGOjWp0z3inkT16ETxEqy07iCTKoDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW3oOyORFkUMTAjHynfbYRlsskxJcAfAx6Mw1gJNvog=;
 b=MlNAr/BwhmPijOiuUD10ZKLEppYORGcexJN3Ju6duoIvwxRvIwFa0xA/Gce+sijobCvpOpNmJdU/4Y5jfEseqn/KeQu2C6pzCebdufr+ZuHnXpu3g+K14r+efxERbTmftE51m8BWaxQW00o33JzIzSHoCGyGvII3d3t01YyH+dk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2670.namprd18.prod.outlook.com (20.179.81.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Tue, 3 Sep 2019 08:46:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 08:46:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Topic: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Index: AQHVYjQRuF4AVfmYn0apAc7jnih3Yg==
Date:   Tue, 3 Sep 2019 08:46:24 +0000
Message-ID: <20190903084614.mthff6hzbchkw7t2@rric.localdomain>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
 <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
 <2bce020a-bf7e-1d54-48c3-0aa6d23c84d8@amazon.com>
In-Reply-To: <2bce020a-bf7e-1d54-48c3-0aa6d23c84d8@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0017.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::27) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72da2a25-c041-4213-52a5-08d7304b3377
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2670;
x-ms-traffictypediagnostic: MN2PR18MB2670:
x-microsoft-antispam-prvs: <MN2PR18MB26705343DFBAAE42E32DBCD4D9B90@MN2PR18MB2670.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(346002)(376002)(396003)(366004)(47630400002)(189003)(199004)(54534003)(7416002)(486006)(6116002)(81156014)(6916009)(53936002)(9686003)(6512007)(6246003)(2906002)(305945005)(6436002)(8936002)(11346002)(446003)(3846002)(476003)(229853002)(7736002)(81166006)(14444005)(256004)(71190400001)(71200400001)(52116002)(186003)(14454004)(1076003)(102836004)(66946007)(86362001)(64756008)(66476007)(66556008)(66446008)(26005)(478600001)(8676002)(25786009)(6486002)(5660300002)(4326008)(99286004)(386003)(6506007)(53546011)(66066001)(54906003)(316002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2670;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ncT0ymQBE99wxIxxZHVW8lu3D+TSG6QFV1GqbdNtt456Ah8jO5DacaB6zWqLRNjk0kbQm+OvqIqaunMSAqDHZ0EgxQUWPWbFChCUgmmfen/rGbt4AS91WaAIc5ZovdsbYq6tXKab0yqqKzKBQntoRc4njCix6DGJUJc4ViBarK3raEf3bKveCD1K1U9PKxglgLL04Dyy9ZqgfpmGG+awzpA9MuZQ8D+GVicGcTZwrqHgPzWZjx9SlmR/7EF9+PLAHp0nv1p+wthQ9GQgm26j30c9OHqO1ZQwqiPJl3zxEfGQXGqztaPlVIL2c9q2CuOivO6Zl5LkdV04EmI/2vu5gnNvtZIgc+3s0qUJmBFrXC1h/Orz2vtY/0EjNPiniFiidZDtc8/bH7wqtiBn1YuzRGJky8XNbjwEiNHmr5tRjxk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F1F622723E9814484DCF6155A64ADD3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72da2a25-c041-4213-52a5-08d7304b3377
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 08:46:24.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkxEg0x9WWGetp0DzQoy9BniQID+GWZ1e7KubGzVPdRdRlKIE68iok+IKjzPIatpUCzoSNQaGQKqs86+39WasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2670
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03.09.19 11:28:41, Hawa, Hanna wrote:
> On 9/3/2019 10:27 AM, Robert Richter wrote:
> > On 15.07.19 16:24:09, Hanna Hawa wrote:
> > > Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> > > report L2 errors.
> > >=20
> > > Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> > > ---
> > >   MAINTAINERS               |   6 ++
> > >   drivers/edac/Kconfig      |   8 ++
> > >   drivers/edac/Makefile     |   1 +
> > >   drivers/edac/al_l2_edac.c | 187 +++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   4 files changed, 202 insertions(+)
> > >   create mode 100644 drivers/edac/al_l2_edac.c
> >=20
> >  From a brief look at it, it seems some of my comments from 2/4 apply
> > here too. Please look through it.
>=20
> Thanks for your review, will look and fix on top of v5.

I have later seen your newer versions posted which haven't made it
into my inbox. But looking at the changelog my comments are still
valid. Thanks for addressing them.

From the changelog:

"Changes since v1:
-----------------
- Split into two drivers"

This is good, but recent practice is also to have all the drivers for
the same piece of hardware in a single file, see e.g. thunderx_edac.c.
I don't know how detailed this was discussed already, but I would
prefer to join the code.

-Robert
