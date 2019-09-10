Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70FAEABF
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfIJMme (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 08:42:34 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42338 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726869AbfIJMmd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 08:42:33 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ACgKr8029755;
        Tue, 10 Sep 2019 05:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Wd5lxrUWS/KUwqPqptb0Lr9IB55xc5YigAddqaU8mUU=;
 b=d3NTLZSsLvaCJgOqWA79bkLiMy0ct+9q1DwWOiUVUjPjH5Q5HP6azEZMaeIZqEw4Mzie
 VwaRoTUUCL+/En7rTdizp4tLWxtHcNLELdXr++EwDXbhAQHfvLLEQYfUZ1x1LAuur3c9
 EVKmD1ShOQ/RkugFujBOQMYRso0NBtuI4QUXXCVvSfewaru70B5kUiv1RSpasmdmfFD9
 UQKuYG1N7xECwoO5K2GO/6sNanvqCCUx9duIGCrb3Za+LLRi8+sy5w6/b0Hih6xmxm9e
 KyaElfPFM1H/aE8wUPEI8bLQ7BOjiZiumoTlg1LelwmHda6s5VjSBgrwJIqF10WB8EWE vw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uv9wpvmdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 05:42:20 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 10 Sep
 2019 05:42:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 10 Sep 2019 05:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtC4ORxLHxEUp2Lim+NSVED3O4yZ5/Z+STx7srU2xjFRZfoWTuBfWXhQgUvx7B5aRK8dcYzjP3McDhkU+JkN02afiGgk+2LWuLf7PaHfxXJkKZpLuoufqZEkZnTxQHxieqdUQMnEv2OVQf2HwTBe3n5vw8bOjySrP87Gt3IQ4Omu05tzM6Y+G0EKGjnwNFfoodDVdPpBoh3Hk/msOfFQcD2J3RzgPD6EOnhmYlLqtqZg878df2Di/JFtu143/DEn/i4YY++205olm88v/aIaIBg3S3zJ2GbAH/cIwmRTGELZAJAJQ87SXdxNpIL+oSRCblWKSWz47Rvfdk4IdMeNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd5lxrUWS/KUwqPqptb0Lr9IB55xc5YigAddqaU8mUU=;
 b=OB2Icke/JB4bYINKY0Sklgpk7UnSJJiGu299cEK2LNGAv/557APQxcDZwvlX4XNOhzh81cDslUXOA/cXSZsz0y0BNWeSrNVRE7w338czf4UuCD5SZJOpQJ1B8J7xocCJVT65aS0EyOINMWR/tJd33EP8XAH3LGQJx6ag9XOaxzgQnEJ9WrOxAGTo1cOtrjGUX9512XP7VSyR8xa2o92FUqQgTrwwaqiVvfvwGlsdUk7eyAYgn/hZmTkC4dBYeHD0Z/KYfBALP2j4rTJ6rH9x89u7JVQifRUuEddRyt/huWIp1a5CC0NteTwUWCuBTOsWX+32dC/3kI06avzW514nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd5lxrUWS/KUwqPqptb0Lr9IB55xc5YigAddqaU8mUU=;
 b=PuSkjp4aneIaAquQGCzsSXLucozn98I9eDEvcs2u5ggcl+rJfywldVjsa463MJrUx7/faTeTcdHiWgb+FlM5QjxHc+CCVPn1ol0NtyLJYPpTeZLZrDPuPuJjykc5+A6wU4xGpFT7uDjPIIY9lf69jD0hZ/hU+tcHnLWsqXHXV8A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 12:42:17 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 12:42:17 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
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
Subject: Re: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVZ9Uu24P7OPd3VEusb2+oWe/R+g==
Date:   Tue, 10 Sep 2019 12:42:17 +0000
Message-ID: <20190910124208.iomkmkvaejyuzlcn@rric.localdomain>
References: <20190905083745.6899-1-hhhawa@amazon.com>
 <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
 <50f5bc27-98da-ee3e-59dd-7252c3ed7a0a@amazon.com>
In-Reply-To: <50f5bc27-98da-ee3e-59dd-7252c3ed7a0a@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72727a04-1dc5-45fd-9c88-08d735ec5069
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB34374773CBE5E1E29C4AF88FD9B60@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(53936002)(66066001)(66446008)(76176011)(186003)(386003)(6506007)(53546011)(102836004)(26005)(8676002)(81156014)(229853002)(86362001)(11346002)(446003)(52116002)(486006)(476003)(305945005)(81166006)(2906002)(8936002)(7736002)(6246003)(25786009)(478600001)(9686003)(7416002)(6116002)(3716004)(3846002)(6916009)(54906003)(66556008)(66476007)(316002)(99286004)(64756008)(6512007)(256004)(14454004)(71200400001)(71190400001)(4326008)(66946007)(1076003)(6486002)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RGxjzq1VbOycPc2s3UY6s3wHY3SPIZqSfCHigiiqkc+2dnp6YlMfFnyf/i6aq6V5PvcJsHD7n5RlABzhH3gMUxUZ1/utSRZWV3trS5uT6ojzrK4Oyjz8eIF3So94pqW8eSZFvg0fnWHxdrRqz4bexxjF2cjzWashS9ZnX3WCxpQDW1w7I/TzKoNIr4cd09k+ioV6djcgBCU6R5YMb4hPLj+vl9aQv2nXwH5XxDkaKXrmWzXmcIMx352dVgSpzRj9hs7JnordATz3GDYoBBoqAkg0moPDdMQLJhdvWZA67gVnQXCD0oRQ7v1tdRbm9q+xu+/CGAws9wdR5sPathVL6e69/ELSa1pn9vB0088AKmyvg/7FR/TfoerN6PD20iyGYtGAbcnCeSNEiMThrkWoTWqmJ0aI0hSh2cERKycktbg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1152581E0FC8124FA65C847516AF77C2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72727a04-1dc5-45fd-9c88-08d735ec5069
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 12:42:17.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDLJpzeHPc/gVnR2lbXRU5ufHtRt9e2cqT8YqVIK/GaHL612cEhd5479X+rv4qUH8VH82erCXZf6BFOO25AYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3437
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_09:2019-09-10,2019-09-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 08.09.19 10:58:31, Hawa, Hanna wrote:
> On 9/5/2019 12:56 PM, Robert Richter wrote:

> > > diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> > > index 65cf2b9355c4..bf6a4fd9831b 100644
> > > --- a/drivers/edac/edac_device.c
> > > +++ b/drivers/edac/edac_device.c
> > > @@ -555,12 +555,15 @@ static inline int edac_device_get_panic_on_ue(s=
truct edac_device_ctl_info
> > >   	return edac_dev->panic_on_ue;
> > >   }
> > > -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> > > -			int inst_nr, int block_nr, const char *msg)
> > > +static void __edac_device_handle_ce(struct edac_device_ctl_info *eda=
c_dev,
> > > +			   u16 error_count, int inst_nr, int block_nr,
> >=20
> > Just curious, why u16, some register mask size? Maybe just use unsigned=
 int?
>=20
> Wanted to be aligned with edac MC.
> I can change it to be u32.

There is no specific reason for u32 either. This code is generic for
many machines and compilers, so unsigned int seems to be the best
choice here to get an optimum.

> > I think the variable can be shortened to 'count', the meaning should
> > still be clear.
>=20
> I think more clear to include 'error'.
> maybe shorter name 'err_count'?

IMO 'count' is clear here, 'error' isn't. I prefer short names for
local variables and arguments.

> > > +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> > > +			   int inst_nr, int block_nr, const char *msg)
> > > +{
> > > +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
> > >   }
> > >   EXPORT_SYMBOL_GPL(edac_device_handle_ce);
> >=20
> > We could just export the __*() version of those functions and make
> > everything else inline in the header file? Though, better do this with
> > two patches to avoid an ABI breakage in case someone wants to backport
> > it. Let's see what others say here.
>=20
> Waiting for other reviewers.

If no one else complains I would prefer moving to
__edac_device_handle_* as exported sympbol. But make this change in 2
patches to make backports easy, first add __edac_device_handle_*()
(and introduce the *_count() inline functions), then remove
edac_device_handle_*() entirely.

Thanks,

-Robert
