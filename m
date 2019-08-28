Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6339FCC2
	for <lists+linux-edac@lfdr.de>; Wed, 28 Aug 2019 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfH1ITU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Aug 2019 04:19:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44682 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfH1ITU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 28 Aug 2019 04:19:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7S8Epoe018694;
        Wed, 28 Aug 2019 01:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=kw7HypEog7DYOQDqUjjZ6aH9XaBxbXk3gKMhcnaoJ1A=;
 b=DCAIATWkcj7dNZdv3MoE9wyGNtv5uPfH94J1imp0uw8IhLb+hNhdgoLRasn+e9imZwFQ
 smNq10/0Knl0l5uLMzTX23BipfZ+OuK4aMIcsUOX7rYCTuZC1COHPmlp8dzc+lSOA5yK
 hoixvXHVMe9BiOyPNYUKuah8rMme7glLxg4gS6t1WPnd35UIkGEyrfR25unBYjYVmXga
 sqdnfoYYTP93tGFGm+lGEqbP6upV0m2SynHwRCN3wFHlqf8cRw/RVDa3VLSSZpJkKDHI
 8cXaKdj1J8CSJJrSy8kKV2n6gu/8mSBB1b/mZKV0LgsQh6l1jKraZ8wPNYwJZUwmeN1z vQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkp68a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 01:19:03 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 28 Aug
 2019 01:19:01 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 28 Aug 2019 01:19:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enlvT94JTSoQjDJPBEmeN58hJKFUUef8DlIbDXPOA4jwk/UlhILtO1c9bhK4KB9g3HvOfVzldtV0eZal0csUtTyYkP5SjjH6wdeKcq/cFzk7xrZJfCq5MeIhIs8EQqeLhBUwW4fnVlUdAcV7ZafVJPXuiS6kMb66fLFFqG7lqOFZGn3VbG2JkqNcF+yAyZmf0hGce+044c/NEXee0BddCbBzXExXu+qyGiAEHv/HDHCZjK+GZyOM8twl+q7iEn5q9xZS1p2uD4sZZK3bJx3oMUYXZD7hixliq4lIVaWBXnBSsolC/3ALW1eDlKBuaGsjhWzAYM8+mfTaDhW+Y79YLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw7HypEog7DYOQDqUjjZ6aH9XaBxbXk3gKMhcnaoJ1A=;
 b=WoJ9l7xiWI51ozNTVNJpd6tDiGHTTE/lkIIMtMIBWN9z1Z+FZjf3nQCVia0o3NOIF5tdu222SuMiqcgvul08AlIfqbfKBuJVeoFtaNTIrIJhbFUtL2G7B33HeOXB9nEzC6ZG8/xgEF+E4mC7WVz+b2YZfvbAv+LTmOkeqGMKjklvrF4CCQMfcwaEDpwyepctJoV8b+lFsXjCqL5yAtJI71Z7UiP8J1SKLhw2UOWWR4YYaPfIg6xF+gLxzEQBz84UOUqSHuwtvEUurqjNiYiqWzINm8sUnbhLLDoQzWnyylmf6m0/ptV4VPDNxWrVpSTP+ZLa8PG1+ccHsjkh3GzjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw7HypEog7DYOQDqUjjZ6aH9XaBxbXk3gKMhcnaoJ1A=;
 b=sdAjT1YFPdqEHVIgTehI5TJzIITNuUOHF30QdqATjB1belgY1cVGZTApAV9Bof6Ljyp2lhVOuJ3UWlH4704yYbY8U8edzyDDVlmWRF0laVeQBv0EN1h1pfQnm1mGM3MewD+PKPp0fXm3RNyFh1WiDNZx8YDWyMnkJ5575SnEVsA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2479.namprd18.prod.outlook.com (20.179.82.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 08:18:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Wed, 28 Aug 2019
 08:18:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/24] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Topic: [PATCH v2 08/24] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Index: AQHVXXk8O9FaCqNi1UGTsoT9yxk98Q==
Date:   Wed, 28 Aug 2019 08:18:56 +0000
Message-ID: <20190828081849.xwbfgro6dfrrtdac@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-9-rrichter@marvell.com> <20190814151824.GB1841@zn.tnic>
In-Reply-To: <20190814151824.GB1841@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0043.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::11) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 175d6b4a-1ef7-425d-7023-08d72b905efc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2479;
x-ms-traffictypediagnostic: MN2PR18MB2479:
x-microsoft-antispam-prvs: <MN2PR18MB2479A079E059831403C7996CD9A30@MN2PR18MB2479.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(229853002)(6916009)(3846002)(81156014)(81166006)(6116002)(8676002)(476003)(486006)(9686003)(6512007)(8936002)(54906003)(66556008)(478600001)(316002)(71200400001)(66066001)(66446008)(66476007)(66946007)(64756008)(71190400001)(6436002)(99286004)(26005)(305945005)(76176011)(2906002)(4326008)(5660300002)(7736002)(53546011)(6506007)(14454004)(1076003)(386003)(6486002)(25786009)(11346002)(446003)(14444005)(102836004)(6246003)(186003)(53936002)(86362001)(52116002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2479;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WYKA7ujOZJUwFHf7iTYsaAEAowj9rhlc6n6JfxpqlF7ZFHEM6KqlukDfKsv3e7vmld+PFBPnI/K3HmW35q8SmXjexE2bWSTLHVrOWOeIOjxgvdx6pb3o9Kgs2q20lzuZL4UtEMcCmad73utnSpfoeS6dEze9IY9eHhInMUriSj4BVoZvmDY58fL7t8aDJnwomOzpu/asxMlZoB8BcubtYXzshH0Nz2LcOZOYDNyNv14P6Y6LoB5Wdzp6lVp0HrucoCkhECd7pt7PvAnO8Sp5JDxY+7P3/a7vVnOwqulN/Bh+MWZkkm0KEnlWhHnB4tAGrNe5cW8eU1rxEp5BFWM7z9dNVltpCh2nmb7iTipiBoknnQ4HQqMjygAceBWoOeYwGtGrZyovM0FnnKLE9K1pGB+gcg8+3puJrGiQwVfEDCA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D7470063D0414459A3EBA9A3D923573@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 175d6b4a-1ef7-425d-7023-08d72b905efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 08:18:57.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iEyVCfrvTAc6PlI/TssNfAektTO+e4zZasTY92OAiQI5JqS6HOUMlHt6oETTXQmeWu9vu6Ccg90w5oiRn0L/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2479
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-28_02:2019-08-27,2019-08-28 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14.08.19 17:18:24, Borislav Petkov wrote:
> On Mon, Jun 24, 2019 at 03:09:11PM +0000, Robert Richter wrote:
> > Make code more readable by introducing a mci_for_each_dimm() iterator.
> > Now, we just get a pointer to a struct dimm_info. Direct array access
> > using an index is no longer needed to iterate.
> >=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/edac_mc.c       | 18 ++++++++++--------
> >  drivers/edac/edac_mc_sysfs.c | 34 +++++++++++++++-------------------
> >  drivers/edac/ghes_edac.c     |  8 ++++----
> >  drivers/edac/i5100_edac.c    | 11 +++++------
> >  include/linux/edac.h         |  7 +++++++
> >  5 files changed, 41 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index c44bc83e8502..27277ca46ab3 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -145,15 +145,18 @@ static void edac_mc_dump_channel(struct rank_info=
 *chan)
> >  	edac_dbg(4, "    channel->dimm =3D %p\n", chan->dimm);
> >  }
> > =20
> > -static void edac_mc_dump_dimm(struct dimm_info *dimm, int number)
> > +static void edac_mc_dump_dimm(struct dimm_info *dimm)
> >  {
> >  	char location[80];
> > =20
> > +	if (!dimm->nr_pages)
> > +		return;
> > +
>=20
> What's that for?

This is moved from the iterator loop below to here. It limits the dump
to only populated dimm slots.

>=20
> >  	edac_dimm_info_location(dimm, location, sizeof(location));
> > =20
> >  	edac_dbg(4, "%s%i: %smapped as virtual row %d, chan %d\n",
> >  		 dimm->mci->csbased ? "rank" : "dimm",
> > -		 number, location, dimm->csrow, dimm->cschannel);
> > +		 dimm->idx, location, dimm->csrow, dimm->cschannel);
> >  	edac_dbg(4, "  dimm =3D %p\n", dimm);
> >  	edac_dbg(4, "  dimm->label =3D '%s'\n", dimm->label);
> >  	edac_dbg(4, "  dimm->nr_pages =3D 0x%x\n", dimm->nr_pages);

> > diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> > index 39ba7f2414ae..7ec42b26a716 100644
> > --- a/drivers/edac/i5100_edac.c
> > +++ b/drivers/edac/i5100_edac.c
> > @@ -846,14 +846,13 @@ static void i5100_init_interleaving(struct pci_de=
v *pdev,
> > =20
> >  static void i5100_init_csrows(struct mem_ctl_info *mci)
> >  {
> > -	int i;
> >  	struct i5100_priv *priv =3D mci->pvt_info;
> > +	struct dimm_info *dimm;
> > =20
> > -	for (i =3D 0; i < mci->tot_dimms; i++) {
> > -		struct dimm_info *dimm;
> > -		const unsigned long npages =3D i5100_npages(mci, i);
> > -		const unsigned chan =3D i5100_csrow_to_chan(mci, i);
> > -		const unsigned rank =3D i5100_csrow_to_rank(mci, i);
> > +	mci_for_each_dimm(mci, dimm) {
> > +		const unsigned long npages =3D i5100_npages(mci, dimm->idx);
> > +		const unsigned chan =3D i5100_csrow_to_chan(mci, dimm->idx);
> > +		const unsigned rank =3D i5100_csrow_to_rank(mci, dimm->idx);
> > =20
> >  		if (!npages)
> >  			continue;
>=20
> This cannot be right: the code here under this does now:
>=20
> 	dimm =3D edac_get_dimm(mci, chan, rank, 0);
>=20
> but dimm is already set. It used to get the DIMM using chan and rank but
> now you're iterating over the already initialized pointers. So I think
> you don't need the edac_get_dimm() anymore.

Right, it should calculate to the same pointer we already have and can
be removed. Good catch.

>=20
> Also fix those up too, while at it pls:
>=20
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #235: FILE: drivers/edac/i5100_edac.c:854:
> +               const unsigned chan =3D i5100_csrow_to_chan(mci, dimm->id=
x);
>=20
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #236: FILE: drivers/edac/i5100_edac.c:855:
> +               const unsigned rank =3D i5100_csrow_to_rank(mci, dimm->id=
x);

I am going to fix this is a separate patch, though I will exclude
rework of struct i5100_priv.

I have reworked the patch according to all your other comments.

Thanks for review.

-Robert
