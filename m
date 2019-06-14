Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18B455A3
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfFNHV6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 03:21:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfFNHV6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 03:21:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E7KBDE011883;
        Fri, 14 Jun 2019 00:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ikhk4mihh80GWAHtiJSxPvO1ZJCkrWUvk0nmp6rvaAs=;
 b=KELRzjp9wSwYOBOc/G80uQWGHG4CRx1eB0+mZe4v8n11FumGb7cVTdHwGr4OkCxJ0QZG
 vG5+CcH28CAE+MZrb2T9A83saxHpwSGg3FJ029El2Dkx1Zycpk6F9jWVzP1FRZJegikb
 Hh580XPUWG9kx86WRgZZYy0L0z05KEfZOuuvoO2r7OyJpRT0oHaIzwLiM311D8eX03WU
 UW7TTSKPzxCkYiWyCYsiPSescdfSuCZ1JKdfArh4LWVnOVVympxAJyWggM1bSyqzGG5M
 tyQcWji/+awEEiopFC1ZRQw7W2+vaXLYvAXrP2JaLd0hm7uqjNMw63J2GRHZ1idm450C AA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvpvw1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 00:21:51 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 00:21:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 00:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikhk4mihh80GWAHtiJSxPvO1ZJCkrWUvk0nmp6rvaAs=;
 b=gpjrRtJx/B49c+2WyZIKGbTBQsmkchM7m0NOFotlbWuXPbUUhDXqY7K+we8z2CM1xZPElJO/qMf9b8+KIFpRLrVpbcEsyUlobbYtrRH3g/35IwlS5ulhYIlpQonvOv4L9QQyAwH91jP04qt462ak+3XTRLS7uGgj280l4HxK0lg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3440.namprd18.prod.outlook.com (10.255.239.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 07:21:48 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 07:21:47 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVIoHTCQs47YBdYEyrNX78UqEudw==
Date:   Fri, 14 Jun 2019 07:21:47 +0000
Message-ID: <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
 <20190613224130.GI11598@zn.tnic>
In-Reply-To: <20190613224130.GI11598@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::38)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 264541c3-9217-406b-df76-08d6f098f5e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3440;
x-ms-traffictypediagnostic: MN2PR18MB3440:
x-microsoft-antispam-prvs: <MN2PR18MB34409B78FC6A0B65353516DED9EE0@MN2PR18MB3440.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(81166006)(6246003)(8676002)(6116002)(3846002)(81156014)(2906002)(68736007)(6512007)(9686003)(6436002)(71200400001)(71190400001)(1076003)(53936002)(8936002)(14454004)(76176011)(478600001)(52116002)(25786009)(6916009)(7736002)(305945005)(486006)(229853002)(476003)(11346002)(446003)(66066001)(53546011)(6506007)(386003)(186003)(26005)(102836004)(54906003)(66556008)(4326008)(6486002)(86362001)(256004)(66946007)(316002)(64756008)(66446008)(66476007)(73956011)(99286004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3440;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Jp8yuApSJ6ExXfPK0knXJKxH5ck6R9EAkg5pLtYO6W9FD9kITI5hI9W1dCl2gh/tMnydEpcOt5mLhKEP7tEn821lN4iuii546uEwq3uZpNGlov4+euidsTcU4pxQ9wLqd31gwIBzxv3VXDXSCS/k57nutqraP8LYjbK127Ah5YlLxUz6kA21wB8T9t6Kue/sP3EJb/mkA7dNRPaVRxND+51AVRC75arlOVFR6Yv0nOKjcj+jELeGnITVEhAvxLU5Zrwz0BmCFd4iPd+aiikt6ykMzjCJcJGs5zSO8LpDpXXCaqDDAIdPVzRu+TlBXRpb+YGIR5x5T1OhF3Oe+gWdjCWRYoxmKmWeR9UCgHngdmqqr07zw3tBF6ii+VkpVm71Wmg1vuonpkPlIs3FpX/wrbsJhQTpde7mnpj148H7RM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35B5044EA4427240ADE394E1E7EA53C9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 264541c3-9217-406b-df76-08d6f098f5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 07:21:47.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3440
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_04:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14.06.19 00:41:30, Borislav Petkov wrote:
> On Thu, Jun 13, 2019 at 09:07:38PM +0000, Robert Richter wrote:
> >  grain_bits =3D fls_long(e->grain) + 1;
>=20
> For 4K grain this makes grain_bits =3D=3D 12.

fls(0) =3D=3D 0
fls(1) =3D=3D 1
fls(2) =3D=3D 2
fls(4) =3D=3D 3
...
fls(0x1000) =3D=3D 13

grain_bits =3D fls_long(0x1000) + 1 =3D 14

>=20
> > In ras_event.h the grain then is calculated different to edac_mc
> > again:
> >=20
> >  1 << __entry->grain_bits
>=20
> and this makes it 4096.

It then calculates to 16k.

>=20
> Looks ok to me.
>=20
> But if in James' example, physical_address_mask is 0xfffffffffffff000,
> doing
>=20
>   grain_bits =3D fls_long(~mem_err->physical_addr_mask);
>=20
> would make it 11 because ~mem_err->physical_addr_mask (negated) should
> be 0xfff.

If it is not power of 2 (e.g. 0xfff), with

 fls_long(e->grain) + 1;

from edac_mc there is still an off by one (so James' calculation for
ghes is correct).

Correct for edac_mc is:

 grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);

This works for both, power of 2 and less:

 grain_bits(0x1000) =3D=3D 12;
 grain_bits(0x0fff) =3D=3D 12;
 grain_bits(0x1001) =3D=3D 13;
 grain_bits(0) =3D=3D 0
 grain_bits(1) =3D=3D 0
 grain_bits(2) =3D=3D 1

James' calculation for ghes is correct in this particular case
(assuming a bit mask with (power of 2 - 1)).

But my formula is more generic.

-Robert
