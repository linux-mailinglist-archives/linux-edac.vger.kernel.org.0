Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7489748
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 08:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHLGmU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 02:42:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63914 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfHLGmU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 02:42:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7C6eOLG011541;
        Sun, 11 Aug 2019 23:42:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=b7MBgAqxYMGybf44FbTzf7Bmn4r1SGl8eGVebCxJwyQ=;
 b=pUKerSaoEbQ1dNA+cBTEwMWg50s/DOWnJAwU87Kh/Im30kDaSDYvwyQ270qv9Pj80cNc
 vZ3XGAX1D1D4cFNp54H9FMLApdWpJeK7RGHj8uVa21OHEirGeY12s5swW6aKfkiVXNav
 e1RK7w0oOaTGfC15CMbI6CtV75lkcKJL3psncE15sW0grJwbnR8El/zVLYyUWa3vt9Xa
 xr4bCpAe/hghfvC81BuTvV24ERY6sOnelj/ZuzKL2frn9pH+/OcKtyMNPatB3m9/mC89
 LwgUDKKsoZegX3Z8VEbXPiSk5ce0q3gjqxuU4JdfzTuZZEazg2du2YRxPOHjcNmGxJyu jQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2u9wem4vu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 23:42:07 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 11 Aug
 2019 23:42:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 11 Aug 2019 23:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3PJaZvvUEjPOMu055WukhbkvCQyRJJdSM5F5HyDfsYm0XmCqDp1bbZJlRS/fU20uH6VUhli5djsGdhNkzlvuQuOoG+dky2+jZrIDTryFaAWrXNNjYxjcpyXzHw5UoaQdJLgQuEYmMj8L2o/arzuuykcAjdAB0UfMrnLfV4JFLYbxmtgk/ESmrTDPLJSLBMjWsSOOJkDPuIWvKg+C8MV5NW8/RWr90Poty1+I4kYpoVUlNuiAxGRd3yExspfep8/NA3P4rASA73td6mr4bNY6hS3GDa9whLfYkLDEM1eFPv/1tg36CHf61VYwFmMZ8zClRBBDdRJP8VRxiQ9+K5Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7MBgAqxYMGybf44FbTzf7Bmn4r1SGl8eGVebCxJwyQ=;
 b=XSNrNt0jxPWR2/ULj2rWXfShto8LsNGPx9yrZtFXGJGG2Zmec3ORo5OMa7r6f9iMoC5ZmiMURNJ7unJeSnu47lAHFvTD8C6NZ8hDgUrdeQnk7JxpGtFAjoDZaRBx4lFrMWkJZ8xP7YE8C/OZxnhmiDpExtQTpzCtZqVLy1xkbbeibeVtW0mYeu1zAJ39JPXOo9iR4TWrSFE58zk6zA4Fi704xNXr1dBXGLO4AyMHROwM5+XLjExtCr5EbGi48bXpYL/6/xFtTdeHkHkjummClrYhf/Iyo93KM2V8OECK6zIf4P5pGk+VgpNv3slQfbvH6Cgwg4z5SaYs7LF/7jV+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7MBgAqxYMGybf44FbTzf7Bmn4r1SGl8eGVebCxJwyQ=;
 b=udAZfrNVsb8nvQU07GqvcRRUnZ+nQ02mvpzRY0w/wrmY5owM7awTEVspqtT82OaV6DNpfoVBxUzQ/qgtgIpG3ES75IqOh6NwuDNXvvH3/FCTVyk826/I1cksJSoRi6rawE1abf+MSCvGT1iKwSM5bwYYruLJlrt4R2A66lCGhiU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2638.namprd18.prod.outlook.com (20.179.84.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 06:42:00 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 06:42:00 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVUNkLbpxW2SmePE2AQC4JnMRuxQ==
Date:   Mon, 12 Aug 2019 06:42:00 +0000
Message-ID: <20190812064147.5czmkj7e6hxgvje3@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-3-rrichter@marvell.com> <20190809131559.GF2152@zn.tnic>
In-Reply-To: <20190809131559.GF2152@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::33) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2f5f7de-5b61-4041-8bb8-08d71ef02d8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2638;
x-ms-traffictypediagnostic: MN2PR18MB2638:
x-microsoft-antispam-prvs: <MN2PR18MB2638083D27E60DEDC3F2F9CED9D30@MN2PR18MB2638.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(366004)(136003)(396003)(51914003)(189003)(199004)(52116002)(14454004)(66946007)(11346002)(316002)(4326008)(81166006)(81156014)(8936002)(305945005)(6246003)(7736002)(53936002)(8676002)(71200400001)(71190400001)(446003)(64756008)(478600001)(486006)(54906003)(66476007)(99286004)(66556008)(476003)(66446008)(25786009)(26005)(6486002)(229853002)(2906002)(9686003)(6512007)(14444005)(186003)(6916009)(53546011)(76176011)(3846002)(6116002)(6506007)(256004)(102836004)(1076003)(66066001)(386003)(6436002)(5660300002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2638;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zut930JXllpTjdXmrWWzcxAGWVHuJgmCezN4W2vTh5n2PTzW7RDBKk/2ox2kOkjJstWj4Nme4RTDEzg+opaSdtaV0apN26TIYEELG7JthBbWUVVPgRcJ31GBvAQZsqUrVU1H7V5SEU+G4zWvZ96UJN74T3//bpxLv/IpKOlMljzj+EohGbXEzSVXMzSs5k34k+48+Gyoik7KwyKdeXXfaU+GdX9Pbw7kmv0i4yg39AdL+RSA14dUtaDSLQZJLpJli8hwMVNZdcu+hpSLy2mDPdYCL913FIQYaQ4D7grWcwyju0fA5mh38XmNUH1XD0R94xk4iFEiVtyAa8xyIyNnnjNarew2BhN5ZSCI9hDoLevtMJKn7CqTKehv3ZLFyaBTKC/3EszBpA0nM5BzvIfklj4aRffBjvYJuhppoj+c7LI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A04C1D88E150B646A1A7034BFAD366AA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f5f7de-5b61-4041-8bb8-08d71ef02d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 06:42:00.4289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ikz0vFC5Fi97ljsNJJxHKrwiPFwkwCaK9/ppAcRgjWuUMzD75NFsOEK1gqboUIp4TykatjE3RDqSae8Oe3V77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2638
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-12_03:2019-08-09,2019-08-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 09.08.19 15:15:59, Borislav Petkov wrote:
> On Mon, Jun 24, 2019 at 03:08:57PM +0000, Robert Richter wrote:
> > The conversion from the physical address mask to a grain (defined as
> > granularity in bytes) is broken:
> >=20
> > 	e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> >=20
> > E.g., a physical address mask of ~0xfff should give a grain of 0x1000,
> > instead the grain is wrong with the upper bits always set. We also
> > remove the limitation to the page size as the granularity is unrelated
> > to the page size used in the system. We fix this with:
> >=20
> > 	e->grain =3D ~mem_err->physical_addr_mask + 1;
> >=20
> > Note: We need to adopt the grain_bits calculation as e->grain is now a
> > power of 2 and no longer a bit mask. The formula is now the same as in
> > edac_mc and can later be unified.
>=20
> Please refrain from using "We" or "I" or etc personal pronouns in a
> commit message and in the code comments below.
>=20
> >From Documentation/process/submitting-patches.rst:
>=20
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour."
>=20
> Please fix all your other commit messages for the next submission.

Sure, will reword.

I have seen you had actively promoted this style guideline, I even was
not aware of it, thanks for the pointer.

>=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/ghes_edac.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index 7f19f1c672c3..d095d98d6a8d 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -222,6 +222,7 @@ void ghes_edac_report_mem_error(int sev, struct cpe=
r_sec_mem_err *mem_err)
> >  	/* Cleans the error report buffer */
> >  	memset(e, 0, sizeof (*e));
> >  	e->error_count =3D 1;
> > +	e->grain =3D 1;
> >  	strcpy(e->label, "unknown label");
> >  	e->msg =3D pvt->msg;
> >  	e->other_detail =3D pvt->other_detail;
> > @@ -317,7 +318,7 @@ void ghes_edac_report_mem_error(int sev, struct cpe=
r_sec_mem_err *mem_err)
> > =20
> >  	/* Error grain */
> >  	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> > -		e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> > +		e->grain =3D ~mem_err->physical_addr_mask + 1;
>=20
> This is assuming that that ->physical_addr_mask is contiguous but I
> don't trust any firmware. I guess we can leave it like that for now
> until some "inventive" firmware actually does it.

With the grain_bits calculation the mask is rounded up to the next
power of 2 value. I therefore don't see any issues for non-contiguous
bit masks. I have updated the patch description.

>=20
> > =20
> >  	/* Memory error location, mapped on e->location */
> >  	p =3D e->location;
> > @@ -433,8 +434,15 @@ void ghes_edac_report_mem_error(int sev, struct cp=
er_sec_mem_err *mem_err)
> >  	if (p > pvt->other_detail)
> >  		*(p - 1) =3D '\0';
> > =20
> > +	/*
> > +	 * We expect the hw to report a reasonable grain, fallback to
> > +	 * 1 byte granularity otherwise.
> > +	 */
> > +	if (WARN_ON_ONCE(!e->grain))
>=20
> Please move that WARN_ON_ONCE in the
>=20
> 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
>=20
> branch above because you're presetting grain to 1 so the warn should be
> close to where it could happen, i.e., when coming from the firmware.

The reason this is here is because this check will be moved to
edac_raw_mc_handle_error() to unify edac_mc and ghes code (see patch
#4). I understand the warn should be close to its source, on the other
side we need the check for all the drivers that setup the grain. Thus,
it cannot be in the driver that is setting up the grain.

Thanks,

-Robert
