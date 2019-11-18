Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10316100D26
	for <lists+linux-edac@lfdr.de>; Mon, 18 Nov 2019 21:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKRUau (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Nov 2019 15:30:50 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12944 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfKRUat (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 Nov 2019 15:30:49 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIKUEsE015509;
        Mon, 18 Nov 2019 12:30:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pqkl+yoOGgizyCRoltbgtN13NxYk3zG2IWaniOjq7x0=;
 b=pCRBTvT9fX57ZAY4RKjeXnYnmjwfQxpWGfoEqLoA1ilMtLpYDjalBFzIxRC7CdbPP6rv
 qw3pIJUiDw/KeTIFkY/vHl8dXpJswax0tzrbj/IrscNw9/SxvBjfUepOr/aCv4IPQd/y
 fXKxgODUXC7rHP1Lvg6cRF0SuxlikqOWDgrwJXRf0ZH2DyztCz3Qr1nL5irZ8KmQUESk
 +IrJ7uzOfwTzcJ9RydXNvv0mZZMg6wA593Pm3emj6V9a14p/+jyF0jC+gwpZP5ZdmJ5t
 X22vvEF25JODFsjE18ToGeM8HsQQe+Q0U4e8oX+QlmmsusNriXApIiaBJ1ZrKA78BeET rg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wahgs7tya-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 12:30:33 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Nov
 2019 12:30:31 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Nov 2019 12:30:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx44EXaqnYNeNaDJRmSBvoj5YO6VboaU2owW9fLM09QGSgMHt5ex2uC4auR/ltbWdjft66wZb9sGchgaHFbjE+7UwQNiFkfmaVdDu2E/68B5IEeZ8+UUPN7A1oV/U/yMWbZL0TyFfITrFGGzpxwmfiodKO1Dd5MwXqspcaxKisL7julX+WCXRXWcYOA3wDJtOyJG9wfVl3TyAYCWs9OnBl5osVUHUtJQmd2I2l04aQ5KHdA0lyW2ZUDCtiGRmdaBjvV7EhE2alzsR8T5msPwjLMG37O+X20VFu9Ea+9d0RO40u2QqamV6geKeRuXsJ71jziAkh/KZGLBAzd/7gnazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqkl+yoOGgizyCRoltbgtN13NxYk3zG2IWaniOjq7x0=;
 b=ORcoJa23oaMe+AhyvCvSYOi/EKAKiVTcOy0sw6szdKX5tQGRTAUiEyuwkCHUv/rS/5Lw2UnHykrkrqbG+CoF+6UThTxisgedctmF6wdV0RXW3yUEhVs1h1D9DEmZTo4NKZx421NcsPPbHq6eSz3Hk0XXKGjLBKDythMFw1bEiFaAfjJKGAnWCk0SmjonNEwzzXV2cRi8OEvVxn+hpFVPznHew61gWOMS92CrFhmdpjk+I5k0rG7A0XO4DMOhFY+bd9bxJs1oqKkC1aCwP8fLScNGYjIQrkm/nij1pbzIE2NGIpMhO9AcwUenK1bE+kn+AsqpPs/XAKWho8GmL9RSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqkl+yoOGgizyCRoltbgtN13NxYk3zG2IWaniOjq7x0=;
 b=HfwKJ95q8KvL69kfVOIvOK10GcWBao5tXNfwv1K+k3E7lxPGkn2FTbZjxnqYMBfiXvrxIOv5s2/LUQFUC2KBgUmbQbNt4PZHKxTAFZgPOk+QPe6KK/t4/wXzH5pLkufz5pgsw6AEkgu85Vj6MN4JX+Tmw01+0BSe31z/Re2L5+M=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2927.namprd18.prod.outlook.com (20.179.22.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 20:30:30 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 20:30:30 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/20] EDAC, mc: Remove per layer counters
Thread-Topic: [PATCH v2 14/20] EDAC, mc: Remove per layer counters
Thread-Index: AQHVlIVBBrxvjhXd+UiTNn0fviO3o6eCeQAAgA779QA=
Date:   Mon, 18 Nov 2019 20:30:29 +0000
Message-ID: <20191118203021.jvlerg4k645g43yn@rric.localdomain>
References: <20191106093239.25517-1-rrichter@marvell.com>
 <20191106093239.25517-15-rrichter@marvell.com>
 <20191109084056.35b4b8ab@kernel.org>
In-Reply-To: <20191109084056.35b4b8ab@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::22) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8744af76-fb9d-4c86-6e28-08d76c662744
x-ms-traffictypediagnostic: MN2PR18MB2927:
x-microsoft-antispam-prvs: <MN2PR18MB2927F7BE4AE09A50B7395B59D94D0@MN2PR18MB2927.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(76176011)(1076003)(6506007)(316002)(478600001)(4326008)(6916009)(81166006)(14454004)(81156014)(25786009)(6436002)(186003)(8936002)(476003)(26005)(6512007)(9686003)(486006)(66476007)(64756008)(66446008)(66946007)(66556008)(5660300002)(2906002)(305945005)(386003)(8676002)(446003)(11346002)(256004)(99286004)(52116002)(53546011)(6246003)(7736002)(86362001)(66066001)(3846002)(6116002)(54906003)(6486002)(102836004)(71190400001)(71200400001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2927;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJAhXF/noQ2ZyMXP0epWHaLBVkWR+Hxifj+g2iqk7htAC84yUH5QZup6Ue2OvsnbIbZ8EV3rp5cYCtTlM/3Od4G11gFaROqqho7e8Da0YhMYF+3ce/a/XUP95ZIgLZawq0sAjNEBNYvRBguzn5zW8XBdVtshY4ct0erLMO2AdEsEcKxU2XFai30dr+/QBs83kEGNTOei/2uLuYVxdepisOnZZchPb33DyWrsFzsIKus5pQ6T67LAtreS64vS566v4i2hmnrNTNAdAJWDUoYYTDEmSsNk2TUo8oUIMXmhgcHG+f2pUoXZ+7kOr8sZvr8aeOfNZbYDgLNA5wXKRdeoG0YodoW/8LQpRHFMo+//Gfb8pQuwhPjY0uGI6udiBkkm87oDSCN/EZKvS0VRtjxIgnT7aPjS2OSxMOoxso7apJYJx8X5+Qm4376gsR1VVlIy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC0219FD6C145C49A2EFC6B866D98E66@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8744af76-fb9d-4c86-6e28-08d76c662744
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 20:30:29.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dz2514VD5y1SSYQrhGbCh+DV0CoXvKPnzu+Q02xyDyT6LsVrGO9tB6EAUHxkyUVCYNBH1Ec9kuOfHZ0x3EhB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2927
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_06:2019-11-15,2019-11-18 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

On 09.11.19 08:40:56, Mauro Carvalho Chehab wrote:
> Em Wed, 6 Nov 2019 09:33:32 +0000
> Robert Richter <rrichter@marvell.com> escreveu:
>=20
> > Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
> > turns out that only the leaves in the memory hierarchy are consumed
> > (in sysfs), but not the intermediate layers, e.g.:
> >=20
> >  count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];

first of all, this is the only user, where ce_per_layer[][] is
accessed *readable*. Note that n_layers is a constant value per
mci. Thus we could also convert this without any change of
functionality to:

 count =3D dimm->mci->ce_counts[dimm->idx];

We can also remove the code that writes counter values to inner
layers, those values are never read.

The above is nothing else than storing the count per DIMM, which can
be converted to the following by just adding the count to struct
dimm_info:

 count =3D dimm->ce_count;

Same applies to ue_count.

As we have the counts in struct dimm_info now, we no longer need to
allocate {ue,ce}_counts arrays and can remove its allocation and
release code including everything around.

> >=20
> > These unused counters only add complexity, remove them. The error
> > counter values are directly stored in struct dimm_info now.
>=20
> I guess this patch will cause troubles with some memory controllers.
>=20
> The problem is that, depending on the memory type and how many bits
> are wrong, it may not be technically possible to pinpoint an error
> to a single DIMM.

If a DIMM can not be identified, the MC has one or more of the pos
values (pos[0] to pos[mci->n_layers-1]) unset (negative values). The
count of the outer layer (mci->ce_per_layer[mci->n_layers][index]) is
not written then. See below in function edac_inc_ce_error().

>=20
> I mean, the memory controller can be, for instance, grouping
> DIMM1 and DIMM2. If there's just one bit errored, it is possible to
> assign it to either DIMM1 or DIMM2, but if there are multiple bits
> wrong, most ECC codes won't allow to pinpoint if the error ocurred
> at DIMM1 or at DIMM2.

An error would not be counted for any DIMM then.

>=20
> All we know is that the layer has an error.

Right, but this hasn't any effect on DIMM error counters.

This has only effect to csrow/channel counters. The code for this did
not change, see edac_mc_handle_error().

>=20
> So, assigning the error to the dimm struct seems plain wrong to me.

I think this is the code in question for you:

> >  static void edac_inc_ce_error(struct mem_ctl_info *mci,
> > -			      bool enable_per_layer_report,
> >  			      const int pos[EDAC_MAX_LAYERS],
> >  			      const u16 count)
> >  {
> > -	int i, index =3D 0;
> > +	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2])=
;
> > =20
> >  	mci->ce_mc +=3D count;
> > =20
> > -	if (!enable_per_layer_report) {
> > +	if (dimm)
> > +		dimm->ce_count +=3D count;
> > +	else
> >  		mci->ce_noinfo_count +=3D count;
> > -		return;
> > -	}
> > -
> > -	for (i =3D 0; i < mci->n_layers; i++) {
> > -		if (pos[i] < 0)
> > -			break;
> > -		index +=3D pos[i];
> > -		mci->ce_per_layer[i][index] +=3D count;

No value written here if pos[] < 0.

> > -
> > -		if (i < mci->n_layers - 1)
> > -			index *=3D mci->layers[i + 1].size;
> > -	}

So in an intermediate step the for loop could be converted to:

	dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);

	if (dimm)
		mci->ce_per_layer[mci->n_layers - 1][dimm->idx] +=3D count;

No change in functionality, right?

> >  }

I hope this explains what this patch does.

It looks sane to me, please review again. If you still think it is
broken, give me an example.

Thanks,

-Robert
