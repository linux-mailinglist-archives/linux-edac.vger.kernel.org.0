Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8922B4611B
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfFNOkT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 10:40:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50956 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728210AbfFNOkT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 10:40:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EEFqA4004990;
        Fri, 14 Jun 2019 07:40:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ERF66L6s+U8S7cyPOBdGoYKkR22U4sPmL8vInQzDuNo=;
 b=v0wOv4dXKmMJs+CPj4hy6iD2gixf9DQqQ31rl8w0+iNj23MQ1T4gTPUo0KACSvyG6ZI0
 TW+iR3iIFFaLHWJ6fJrFXTqFUP5JycY/9pO5dtMXLc1l0TXx5q7izgTsGqxIMiCWQFPW
 ZQJv0F50priZPzpzAMzqk0T0dhsDgVTGKN3FrCKraURpeIXqrCOvJCmmuTJBMh60vFio
 eqS8El5VjAyy9TR2XD4L/5uCmTFgDjyN0gV5XVqwItcmzXbyMN2b6rti6u0K6/xxxfEP
 dX6yGGVbN5m+IY+ncGO1BRyRiGuwgbmITkCTXaz2EyfKb71qCsR6vpL5m9L63krx5jZi 3A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t41j62s6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 07:40:08 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 07:40:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 07:40:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERF66L6s+U8S7cyPOBdGoYKkR22U4sPmL8vInQzDuNo=;
 b=pWMSc9hxnJmTUsqsk5GC33wtHPyapPeAHoUFt8cAkkyblAoowiRY2zS3MfSb6ukOsBWr+Sl+ubv5sZKKx7Db2Ihnuz6W6RSJU69uYXXX3AANvpWXpAXfM5j/viluPVPqEvqtOQQpOpG2Ki0E7C4IOgtq2zx1wplL2jK8qxcVo+M=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2639.namprd18.prod.outlook.com (20.179.82.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 14:40:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 14:40:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVIr8MswIX1xUpx0i0as6jfxZ11g==
Date:   Fri, 14 Jun 2019 14:40:01 +0000
Message-ID: <20190614143932.cacobehkuw62frzx@rric.localdomain>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
 <20190613224130.GI11598@zn.tnic>
 <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
 <20190614100918.GA2586@zn.tnic>
In-Reply-To: <20190614100918.GA2586@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:7:16::25) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c44be7ea-175c-41c7-3620-08d6f0d62e94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2639;
x-ms-traffictypediagnostic: MN2PR18MB2639:
x-microsoft-antispam-prvs: <MN2PR18MB2639286239AEC6B67B3C2518D9EE0@MN2PR18MB2639.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(51444003)(256004)(8676002)(2906002)(6486002)(229853002)(26005)(68736007)(102836004)(1076003)(386003)(5660300002)(6506007)(6436002)(53546011)(81166006)(81156014)(71200400001)(6116002)(478600001)(186003)(71190400001)(6512007)(6916009)(66066001)(3846002)(14454004)(8936002)(9686003)(25786009)(53936002)(86362001)(476003)(446003)(11346002)(486006)(52116002)(66556008)(73956011)(99286004)(66946007)(6246003)(54906003)(76176011)(7736002)(64756008)(66446008)(316002)(305945005)(66476007)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2639;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hAis4TSFVKZ8mtRfePOrzqWheNPjrdnUdg9DRUNZGEebtQliv8ZIBGEdqSFagFkc9AAQGQkTVKSKy3RJvpRQyndhdHEiMeFwXEb2M2k947EKvtulZh26LO7CCBxIU05ui+W7J3MV97M6CHtRoZMu5eGayL2rI2sTT398UK4ZqV5V1gFA73PTFnPuNoRxQvLFn9TVYCJCVEGploVA4T/JTM7j9iHe9aBuSPZF/BxRpvWy0L7wCr7lmSCjldqM2Zkz9rEc6+zSzBhHS4rMBb35utSIE49eJBzhtyuPDP0U3kv8zXMUT8cnAbWG8DePX/PIHb+tJfNwG+EEIwVue2IyX4kaUYjM7jwiNiMntfn6x6DBcysHyLl6OQJeTNaumvIKO8eDpuzrvd7KrTfMbHTG7P9AaRgr7IiUGuBSpAGMSIY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70BDB4B119D1CA43B04BD5F9E2C1CF8F@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c44be7ea-175c-41c7-3620-08d6f0d62e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 14:40:01.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2639
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14.06.19 12:09:18, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 07:21:47AM +0000, Robert Richter wrote:
> > On 14.06.19 00:41:30, Borislav Petkov wrote:
> > > On Thu, Jun 13, 2019 at 09:07:38PM +0000, Robert Richter wrote:
> > > >  grain_bits =3D fls_long(e->grain) + 1;
> > >=20
> > > For 4K grain this makes grain_bits =3D=3D 12.
> >=20
> > fls(0) =3D=3D 0
> > fls(1) =3D=3D 1
> > fls(2) =3D=3D 2
> > fls(4) =3D=3D 3
> > ...
> > fls(0x1000) =3D=3D 13
>=20
> I believe the intent of the "+ 1" above is that e->grain was a mask of
> the type 0xfff so you have to + 1 since we count from bit 0.

No, as you grepped below, the granularity is the number of bytes, and
mostly power of 2. Also note that fls(0xfff) is 12 and fls(0x1000) is
13 ...

>=20
> > Correct for edac_mc is:
> >=20
> >  grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);

... thus the -1 here.

>=20
> First of all, you don't wanna do fls(0).

You need to deal with fls(0) as you don't know what drivers fill in
for the grain. fls(0) calculates fine here to 1 grain bit which is a
one byte granularity.

>=20
> Then, we don't want to use PAGE_MASK for grain computation because as
> James showed, it causes problems.
>=20
> > James' calculation for ghes is correct in this particular case
> > (assuming a bit mask with (power of 2 - 1)).
>=20
> And this is the question that needs to be clarified first: from what do
> we compute the grain.
>=20
> ghes_edac uses ~physical_addr_mask which can basically be:
>=20
> 	grain_bits =3D hweight_long(physical_addr_mask);
>=20
> which, in the 0xfff case gives you the correct 12 bits. It is assuming
> it is a contiguous mask though. It better be...
>=20
> Now, if you look at how the grain gets read out in edac_mc_handle_error()=
, it
> comes from dimm->grain. And that is defined as:
>=20
>         u32 grain;              /* granularity of reported error in bytes=
 */
>=20
> in bytes!
>=20
> Now, if you grep for "grain" in drivers/edac/ you see most (if not all)
> initialized as bytes:
>=20
> i82975x_edac.c:415:                     dimm->grain =3D 1 << 7;   /* 128B=
yte cache-line resolution */
> pnd2_edac.c:1260:               dimm->grain =3D 32;
> skx_common.c:313:       dimm->grain =3D 32;
> highbank_mc_edac.c:223: dimm->grain =3D 8;
> ...
>=20
> and so on.
>=20
> So actually I think that
>=20
> 	grain_bits =3D fls_long(e->grain) + 1;
>=20
> is wrong in that case.

This calculates correctly:

	grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);

and also handles the case if the number of bytes is not power of 2.

> It should simply hand down e->grain as it is
> already the number of bytes.
> Which we should simply dump in the tracepoint too - the number of bytes
> and not that silly shifting there:
>=20
> 	1 << __entry->grain_bits,

The tracepoint format for mc_event changes from byte to long for the
grain then. This is not backward compatible and breaks userland.

>=20
> And once we've said that the grain is going to *everywhere* be the
> granularity of the error in number of bytes, then we should stick to
> that and fix all those drivers which don't do that.
>=20
> Ok?

See my other mail in this thread with a diff. I would go with that
one.

-Robert
