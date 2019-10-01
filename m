Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65CC308A
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfJAJrX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 05:47:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13730 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728708AbfJAJrX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 05:47:23 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x919ivW4009138;
        Tue, 1 Oct 2019 02:47:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=b1HgRmi0P5Zt0vOBGJZAz4o4IA/dcSjoflDnEoS9doc=;
 b=xyVB7+aM3JcHJeHzuF80dQwSWsHKcTzk2ZNFwJMXkUh4eLw/ZhEWN+fLi6BKObnYc/Mi
 vV2SNTCvUR/VhAsGIaR2bizMD56JzE972ljABAPrnhHszOW9R++AiqeUNiuEu63+E8Ps
 IhcdWOeJyIOrZrrIH9Rh04oSI61/zb4mbEF9EiVI1fBlCEvbXxrKRTPpMcVcx41eS87l
 UDZsYySSpcycRZWVls4NWSoIg9k4/KvfjDzQMMaBEfTP+CwXA29rg/TcLeT63tgHWhCh
 VlHpcSAST8qJehEDXi0o3DI7emx5TMjHSP5U7tiJr+MC0GdVcAcZ1H+fKnm83jDtnQ+9 Hw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vbur19jmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 02:47:10 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 1 Oct
 2019 02:47:09 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 1 Oct 2019 02:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khy3njG8wia/M8fFf4WcyjdjVH5VLaOXDEr8MYxj8GUTRo0SsAGEtFt7O3eKDbPBTCGmGeJBcf7EDGpB4L8RrGW9VQRV4vXtFUaow8p+8cLhFpYzQz6SxHUMnOT9yIMf3ww992lwhLMuUAFHlFzzM76/IQ0OswNHG1pr/L+rxvf/tebMPaB/cAvP5vOKecvdoMk4fM9oQMD6eUERa5gSOu5Jh946mg8qBMX8CAlpnKXW6AryClJcbWQOAYDvW9dOr//5dDN2S2lGRgCtEfh72Z/VbqCVV5RShO/GO1hOjfAjXuh6aYXJxnKRvcXHcN+vTuf6sNFeotO9fKjD1T91jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1HgRmi0P5Zt0vOBGJZAz4o4IA/dcSjoflDnEoS9doc=;
 b=Vn8dt1L/GCL60pUfhR6TPqWIwu6lZtChTLLs4gQAYy56dI2SirKMO7TRMXKb52K5hXPTpDEeQ2YURiNfTehs7LbBfeajJjnRGtXYUMr570icEGRoiibh4V0z8+FxuS59HUxydO3zyj1GJOOUjAkLJSfvtljJNQwsHmBK8Vqnd8C6fPAbgjyqblu51WCH5NqnTsARztjY1dqpF/FMhFaUPYiUHA8WwysBn+o9qMxdQXYH6ipBDJyXxvYkx/tHFtoCrs1cCWnXlRglzN7hv8kqEMkwL/Cc4LlwYzzxcCszhlT6EDams111hOOD8yfK+DgBJ0qKITlCVfm0Xc8ZQGinyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1HgRmi0P5Zt0vOBGJZAz4o4IA/dcSjoflDnEoS9doc=;
 b=iqw7kK/8kNkrjY6BuK+hUxTaPN37/2KNP6Chsa5hlEe4bVMpdFnnabvJURc2nWHEVDzPpzyAcMcUs0c6B1npGWTXk6+/+mrFevkQdl7RJpAcmUzYq5bJhDFdgkS+H7HNYWTdqCnU4NKz6MRFqXypslA1yZ+dQsovpP9yVXD5DG4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2751.namprd18.prod.outlook.com (20.179.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 09:47:07 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::88e4:c340:f520:6b36%3]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 09:47:07 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Hanna Hawa <hhhawa@amazon.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVeD0w3a8Q6Y9qUkqSALBVLRrJbQ==
Date:   Tue, 1 Oct 2019 09:47:07 +0000
Message-ID: <20191001094659.5of5ul2tof6s75px@rric.localdomain>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com> <20190930145046.GH29694@zn.tnic>
 <20191001065649.a6454bh4ncgdpigf@rric.localdomain>
 <20191001083242.GA5390@zn.tnic>
In-Reply-To: <20191001083242.GA5390@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 885747b6-5664-4e81-6ca8-08d746545292
x-ms-traffictypediagnostic: MN2PR18MB2751:
x-microsoft-antispam-prvs: <MN2PR18MB2751BD926E7103014A0A7BD8D99D0@MN2PR18MB2751.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(6512007)(9686003)(305945005)(6486002)(316002)(1076003)(64756008)(66446008)(66556008)(54906003)(66946007)(4326008)(66476007)(6246003)(486006)(6436002)(476003)(86362001)(478600001)(7736002)(7416002)(229853002)(446003)(66066001)(11346002)(99286004)(6116002)(3846002)(8936002)(8676002)(81156014)(81166006)(102836004)(71190400001)(14454004)(53546011)(6506007)(386003)(2906002)(6916009)(25786009)(52116002)(71200400001)(76176011)(26005)(256004)(186003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2751;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Te52llMjrpj5jyW0WAH+DKekQutyuQuHhPBqVbibVJuot8/Xt0j1Es9FmLjR24bXbVig053p5RGVnAGm6cvpYRjIxeAFrVE7HEXx5A3KyTinlA/7sXN2FerPj65LueC9bHKiv6w3T62uRZ0DxhHjoON2ILeIIm99b0oachV7mR9jWBDKzCCFF2PSdswC+bsd3om7FHOa7L0yL4wakU+nvkHneaggrZUEJEesm94a4PUoMnNyGHvu9fDAXv3lAGR+9fcJocWVhsDQ7swQnvo/NYNbNaX0Ru78PIZbXA7BqQTzGEolQiECwHPPEomverfZtBhQdBzCIwsRFJpZP66yRSa2y4/XR9mWOXRyKgilhEw0J6UPZJw7/mbXBcu/Bf04B+1AwB3Pnk1189a8L99qPhDsZVw0gdRMViiwQHwYhr8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F96B9A032DD11B43B46C5D4C8E8EA8CE@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 885747b6-5664-4e81-6ca8-08d746545292
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:47:07.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4/6oMSv+u/VvBaq8VcuWsfs0lkZxYHvH8xS+zvVcu4UIyr5YwDrBO9kzdcdJkc+HyeUNRhKy5fENdUzKiwsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2751
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_05:2019-10-01,2019-10-01 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.10.19 10:32:42, Borislav Petkov wrote:

> ----------------------------------------------------------------------
> On Tue, Oct 01, 2019 at 06:56:58AM +0000, Robert Richter wrote:
> > It is *not* the counterpart. The __* version already has the...
>=20
> Lemme cut to the chase:
>=20
> "Make the main workhorse the "count" functions which can log a @count
> of errors. Have the current APIs edac_device_handle_{ce,ue}() call
> the _count() variants and this way keep the exported symbols number
> unchanged."
>=20
> I want to see exactly *two* pairs of functions:
>=20
> edac_device_handle_{ce,ue}_count	- logs a @count of errors
> edac_device_handle_{ce,ue}		- logs a single error
>=20
> Not three pairs. I.e., the "__" versions are not needed.
>=20
> > The first patch only adds functionality but keeps the abi. Thus it
> > makes a backport easier.
>=20
> Works just the same with my version - single backport.

If you move to static inline for edac_device_handle_{ce,ue} the
symbols vanish and this breaks the abi. That's why the split in two
patches.

Your comment to not have a __ version as a third variant of the
interface makes sense to me. But to keep ABI your patch still needs to
be split. The first patch still must contain symbols for
edac_device_handle_{ce,ue}. I am not sure if ABI compatability is
something we want to make easier here. I personally like the approach.

-Robert
