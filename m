Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8DE04EC
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfJVNZo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 09:25:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13464 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388697AbfJVNZn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 09:25:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MDOK35001137;
        Tue, 22 Oct 2019 06:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3FFhvefGLynnRIWcfP+qIfbNNMijK8w3ld92NpHuvek=;
 b=TQOfTIpXHjgJQEpEVLG7CLoB6c1HxlzGsHNhdNN/Vfld1OxFIG8YxBm+cGChs+O6h5IG
 CTsR8QXaomr6KvehSOMXo+3GpWQH7luaF8lWdqIM6x7B9eCn4f/QzTn7E4fz6ciHKKmB
 kpiykZ0N2QVXKqxx/uarViMAPB2lfU+PNXnPKPloaYWwoLD7mUg5QTqku673BOGStmkF
 SdLLbYFwMTA5+FGcuBJJXAq/+Wuc7JA4AhtRWkHSv/G4etDJgyaFO7dmX22j1C0iEQQj
 p6GHpSBxCMU5qABIIYkEae5/L616MFPUqt9aB9qbxBQ6cuVN7K1Ii3b97SMcJS4TlyZE Cw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vsw61138k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 06:25:09 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 22 Oct
 2019 06:25:07 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Oct 2019 06:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUIccfVBUlfxcocSBoNfHi3cdzwbVyiDSkMIsGpoRCYCfXfx0sNski0uz2zritSepPURI58bYwLzdT+1S7FJ3QGUXmHE9ACqRG2nsF8Efv+8l+W8ZKyTYNopMfkOnaHAr9UHIP1ebJ25OhNGzv+CJZLYKsg7T89KwJpWfHg7hzYJDwW0EA7NoVOgMaVAaC7fQEnffA3EvWYPflP8Lt0ENUzJb32faK8wyeMb3sNapDSjqXFjJVoPUCE4VrnHvmelX5DiUdlUlbC0zXk9WzMwhpb76TUXkBmAMvxBj77U7rkaBl2kJjWOyMEUlyYgjILy5Gpxzxcx+seJCBTfyyostA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FFhvefGLynnRIWcfP+qIfbNNMijK8w3ld92NpHuvek=;
 b=Q+R8vcjVxmFYtLwS1LdSfHxNg6Xa9NTeDIykRwtK2Q6SdpiM8n01mGeC5dBbqKfGfGigFP0jg23BwGKTQh6J62TZFUiCKMxvb1KNbkl9h1Kx/WWHLkoChkLxVb9Xtah3DJJ6vbjWfkMTpYFUeyhoCzs7TSwhPVzi/YWd7pjeimJ1bnJ2Sc+gkzUQvZP7gImLqwrHIUWM1N/Zd4Dy6xHE4Upi8Yllu1NSpDxExFj+d3swfRu+5bw2JS1tNkk20vdMcdahrkLw/YyLVkmR2pv81ZngGWsPBMVExoLtVmTQPekGkj93niTOPbwzBQy3mrlnPLruQ0DJe5kwNH2RZO1jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FFhvefGLynnRIWcfP+qIfbNNMijK8w3ld92NpHuvek=;
 b=XXxnPnTY6F4YqGXXD65JOZxVeiGz7zsWvpkEjbkO1Brfb+1GP1aKs4wSlKcKkIvB6wBleBpHekGrlUAoGoiUTh6xxh4MbWlR6nzBvG5JwfjzYn8+CiU/sP4xU5q5wr3bP/KKuNDbQpHOjC0stWWrjc1ndQkxLxNhhiIzJ5EYf40=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2687.namprd18.prod.outlook.com (20.179.84.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 22 Oct 2019 13:25:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 13:25:05 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Thread-Topic: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Thread-Index: AQHViNwdt7a5Mo4z/ECMIZh+Lz08Cw==
Date:   Tue, 22 Oct 2019 13:25:04 +0000
Message-ID: <20191022132456.j222nlkl3qptg4vw@rric.localdomain>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic> <20191016151751.GH1138@zn.tnic>
 <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
In-Reply-To: <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0003.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::13) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e049b798-f2e1-4604-0769-08d756f33f89
x-ms-traffictypediagnostic: MN2PR18MB2687:
x-microsoft-antispam-prvs: <MN2PR18MB2687004C13308DDF6D34184ED9680@MN2PR18MB2687.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(199004)(189003)(7736002)(305945005)(14444005)(256004)(86362001)(8936002)(66066001)(81166006)(8676002)(81156014)(6436002)(316002)(3846002)(1076003)(6116002)(6246003)(54906003)(9686003)(6512007)(6916009)(478600001)(71200400001)(71190400001)(11346002)(446003)(53546011)(386003)(6506007)(76176011)(52116002)(2906002)(99286004)(102836004)(26005)(186003)(14454004)(4326008)(5660300002)(25786009)(6486002)(486006)(66476007)(66946007)(64756008)(66556008)(66446008)(476003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2687;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCuPuQfa64XxEphq6YcSEdZG+zf4ko23duLHmU4xJj1btZYX9rlYWsPP9eHE8SMq7hzJp1Q9x7qP8DlFA0mKqr5+VQEqhJsSdpu6//bjit+1Jie5NOyKCcTqiadrU6Lp62CVyzKaGfo+5l+7AmKQ1o+zLm4SBDQPiFsuJHUX/ty7q/4ni6kMIew1EsIWu6gNLJVk7SJ/pZ0W7YC1/StOpTxtHGYm3tKINyxAaFtle/b6V/r7tx+Gr4QoT5wA0a2DgZfDl2jzGIVGG/GuaJMPGoDPKgZfNjTf0yugWu40RMTGe/8NdvI2v/B8DTx/Tv/RcgnTQXQle/Ip26HuN2FHDNxrYlLOhXcwffHvL3nurOrPMC8lQrknNV6mvc/GutkUxhNCoBx40I/w8jdb040ChCPKweHXcxyMhwpw29ixPDvlC7EiL70XKoSRMJbUxFEn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE31BBE3423DCC4FA2A659F3B45FE790@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e049b798-f2e1-4604-0769-08d756f33f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 13:25:04.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xe3W8ojTt4CKDNdyWziL4uBnxzpgBMc5PmLk59EwG/C8mcSPDgQZRopOXDwxWkxcl3F/XpU2eEi81RpabI+ccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2687
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16.10.19 16:30:24, James Morse wrote:
> Hi Boris,
>=20
> On 16/10/2019 16:17, Borislav Petkov wrote:
> > On Mon, Oct 14, 2019 at 07:53:19PM +0200, Borislav Petkov wrote:
> >> Provided unregister cannot be called concurrently, the
> >>
> >>         if (!ghes_pvt)
> >>                 return;

ghes_pvt should not be used at all outside the irq handler. It can
being protected by the mci device's refcount and as long mci exists,
ghes_pvt exists too (mci->pvt_info).

So a better fix is to use the mci's devices refcounter (get_device())
to prevent ghes_pvt from being freed until this pointer is invalidated
for sure. The mci can be freed then with just a put_device() call.  Of
course this needs a proper refcounting of all users and a release
handler. Since the mci or ghes_pvt is needed in the irq handler the
pointer to it can be set/unset when registering/releasing the mci.

See also below.

> >>
> >> in ghes_edac_unregister() should suffice.
> >>
> >> But just to be on the safe side, it could get an "instance_mutex" or s=
o
> >> under which ghes_pvt is set and cleared and then that silly counter ca=
n
> >> simply go away.
> >>
> >> Thoughts?
> >=20
> > IOW, something simple and straight-forward like this:
>=20
>=20
> > ---
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index 0bb62857ffb2..b600f010fa0e 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -26,9 +26,11 @@ struct ghes_edac_pvt {
> >  	char msg[80];
> >  };
> > =20
> > -static atomic_t ghes_init =3D ATOMIC_INIT(0);
> >  static struct ghes_edac_pvt *ghes_pvt;
> > =20
> > +/* GHES instances reg/dereg mutex */
> > +static DEFINE_MUTEX(ghes_reg_mutex);
> > +
> >  /*
> >   * Sync with other, potentially concurrent callers of
> >   * ghes_edac_report_mem_error(). We don't know what the
> > @@ -461,7 +463,7 @@ int ghes_edac_register(struct ghes *ghes, struct de=
vice *dev)
> >  	struct mem_ctl_info *mci;
> >  	struct edac_mc_layer layers[1];
> >  	struct ghes_edac_dimm_fill dimm_fill;
> > -	int idx =3D -1;
> > +	int idx =3D -1, err =3D 0;
> > =20
> >  	if (IS_ENABLED(CONFIG_X86)) {
> >  		/* Check if safe to enable on this system */
> > @@ -472,11 +474,13 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
> >  		idx =3D 0;
> >  	}
> > =20
> > +	mutex_lock(&ghes_reg_mutex);
> > +
> >  	/*
> >  	 * We have only one logical memory controller to which all DIMMs belo=
ng.
> >  	 */
> > -	if (atomic_inc_return(&ghes_init) > 1)
> > -		return 0;
> > +	if (ghes_pvt)
> > +		goto unlock;
> > =20
> >  	/* Get the number of DIMMs */
> >  	dmi_walk(ghes_edac_count_dimms, &num_dimm);
> > @@ -494,7 +498,8 @@ int ghes_edac_register(struct ghes *ghes, struct de=
vice *dev)
> >  	mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct gh=
es_edac_pvt));
> >  	if (!mci) {
> >  		pr_info("Can't allocate memory for EDAC data\n");
> > -		return -ENOMEM;
> > +		err =3D -ENOMEM;
> > +		goto unlock;
> >  	}
> > =20
> >  	ghes_pvt	=3D mci->pvt_info;
> > @@ -541,23 +546,29 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
> >  	if (rc < 0) {
> >  		pr_info("Can't register at EDAC core\n");
> >  		edac_mc_free(mci);
> > -		return -ENODEV;
> > +		err =3D -ENODEV;
> >  	}
> > -	return 0;
> > +
> > +unlock:
> > +	mutex_unlock(&ghes_reg_mutex);
> > +
> > +	return err;
> >  }
>=20
> There are a few more warts we should try and get rid of with this:
> ghes_edac_register() publishes the ghes_pvt pointer under the mutex, but =
the irq handler
> reads it without taking the mutex. (obviously it can't).
>=20
> ghes_edac_register() publishes the pointer before its called edac_mc_add_=
mc(), which is
> pleasant.
>=20
> (sorry I've been sitting on this while I found new and exciting ways to b=
reak my test
> machine!)
>=20
> Combined with the spinlocky bits of:
> --------------------------%<--------------------------
> >From 61fa061790fe7c19af25b25693b61bb75a498058 Mon Sep 17 00:00:00 2001
> From: James Morse <james.morse@arm.com>
> Date: Wed, 16 Oct 2019 10:02:15 +0100
> Subject: [PATCH] EDAC, ghes: Move ghes_init and ghes_pvt under the ghes_l=
ock
>=20
> ghes_edac has an irqsave spinlock that protects the contents of ghes_pvt,
> but not the pointer itself. The register, unregister and irq-handler
> functions read this bare global variable expecting to see NULL or the
> allocated value. Without READ_ONCE()/WRITE_ONCE(), this is racy.
> ghes_edac_register() also publishes the pointer before it has registered
> the mci.
>=20
> Replace ghes_init with an unsigned int counter in ghes_pvt. To access
> this or read the ghes_pvt pointer, you must hold the ghes_lock. This
> prevents races when these values are modified.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/edac/ghes_edac.c | 69 ++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 0bb62857ffb2..804bb07c6acf 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -15,7 +15,10 @@
>  #include "edac_module.h"
>  #include <ras/ras_event.h>
>=20
> +/* Hold ghes_lock when accessing ghes_pvt */
>  struct ghes_edac_pvt {
> +	unsigned int users;
> +
>  	struct list_head list;
>  	struct ghes *ghes;
>  	struct mem_ctl_info *mci;
> @@ -26,7 +29,6 @@ struct ghes_edac_pvt {
>  	char msg[80];
>  };
>=20
> -static atomic_t ghes_init =3D ATOMIC_INIT(0);
>  static struct ghes_edac_pvt *ghes_pvt;
>=20
>  /*
> @@ -79,9 +81,8 @@ static void ghes_edac_count_dimms(const struct dmi_head=
er *dh, void *arg)
>  		(*num_dimm)++;
>  }
>=20
> -static int get_dimm_smbios_index(u16 handle)
> +static int get_dimm_smbios_index(u16 handle, struct mem_ctl_info *mci)
>  {
> -	struct mem_ctl_info *mci =3D ghes_pvt->mci;
>  	int i;
>=20
>  	for (i =3D 0; i < mci->tot_dimms; i++) {
> @@ -197,15 +198,12 @@ void ghes_edac_report_mem_error(int sev, struct cpe=
r_sec_mem_err
> *mem_err)
>  {
>  	enum hw_event_mc_err_type type;
>  	struct edac_raw_error_desc *e;
> +	struct ghes_edac_pvt *pvt;
>  	struct mem_ctl_info *mci;
> -	struct ghes_edac_pvt *pvt =3D ghes_pvt;
>  	unsigned long flags;
>  	char *p;
>  	u8 grain_bits;
>=20
> -	if (!pvt)
> -		return;
> -
>  	/*
>  	 * We can do the locking below because GHES defers error processing
>  	 * from NMI to IRQ context. Whenever that changes, we'd at least
> @@ -215,6 +213,11 @@ void ghes_edac_report_mem_error(int sev, struct cper=
_sec_mem_err
> *mem_err)
>  		return;
>=20
>  	spin_lock_irqsave(&ghes_lock, flags);
> +	pvt =3D ghes_pvt;
> +	if (!pvt) {
> +		spin_unlock_irqrestore(&ghes_lock, flags);
> +		return;
> +	}
>=20
>  	mci =3D pvt->mci;
>  	e =3D &mci->error_desc;
> @@ -348,7 +351,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
>  			p +=3D sprintf(p, "DIMM DMI handle: 0x%.4x ",
>  				     mem_err->mem_dev_handle);
>=20
> -		index =3D get_dimm_smbios_index(mem_err->mem_dev_handle);
> +		index =3D get_dimm_smbios_index(mem_err->mem_dev_handle, mci);
>  		if (index >=3D 0) {
>  			e->top_layer =3D index;
>  			e->enable_per_layer_report =3D true;
> @@ -457,8 +460,10 @@ static struct acpi_platform_list plat_list[] =3D {
>  int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  {
>  	bool fake =3D false;
> +	unsigned long flags;
>  	int rc, num_dimm =3D 0;
>  	struct mem_ctl_info *mci;
> +	struct ghes_edac_pvt *pvt;
>  	struct edac_mc_layer layers[1];
>  	struct ghes_edac_dimm_fill dimm_fill;
>  	int idx =3D -1;
> @@ -475,7 +480,13 @@ int ghes_edac_register(struct ghes *ghes, struct dev=
ice *dev)
>  	/*
>  	 * We have only one logical memory controller to which all DIMMs belong=
.
>  	 */
> -	if (atomic_inc_return(&ghes_init) > 1)
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	pvt =3D ghes_pvt;
> +	if (pvt)
> +		pvt->users++;

As written above, we should better use the mci's refcount here.

> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	if (pvt)
>  		return 0;
>=20
>  	/* Get the number of DIMMs */
> @@ -497,9 +508,10 @@ int ghes_edac_register(struct ghes *ghes, struct dev=
ice *dev)
>  		return -ENOMEM;
>  	}
>=20
> -	ghes_pvt	=3D mci->pvt_info;
> -	ghes_pvt->ghes	=3D ghes;
> -	ghes_pvt->mci	=3D mci;
> +	pvt		=3D mci->pvt_info;
> +	pvt->ghes	=3D ghes;
> +	pvt->mci	=3D mci;
> +	pvt->users	=3D 1;
>=20
>  	mci->pdev =3D dev;
>  	mci->mtype_cap =3D MEM_FLAG_EMPTY;
> @@ -543,21 +555,36 @@ int ghes_edac_register(struct ghes *ghes, struct de=
vice *dev)
>  		edac_mc_free(mci);
>  		return -ENODEV;
>  	}
> +
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	WARN_ON_ONCE(ghes_pvt);
> +	ghes_pvt =3D pvt;
> +	spin_unlock_irqrestore(&ghes_lock, flags);

This still is not safe as ghes_pvt could being setup by another
instance in between.

> +
>  	return 0;
>  }
>=20
>  void ghes_edac_unregister(struct ghes *ghes)
>  {
>  	struct mem_ctl_info *mci;
> +	bool do_free =3D false;
> +	unsigned long flags;
>=20
> -	if (!ghes_pvt)
> -		return;
> -
> -	if (atomic_dec_return(&ghes_init))
> -		return;
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	if (ghes_pvt) {
> +		ghes_pvt->users -=3D 1;
> +
> +		/* Are we the last user? */
> +		if (!ghes_pvt->users) {
> +			do_free =3D true;
> +			mci =3D ghes_pvt->mci;
> +			ghes_pvt =3D NULL;
> +		}
> +	}
> +	spin_unlock_irqrestore(&ghes_lock, flags);
>=20
> -	mci =3D ghes_pvt->mci;
> -	ghes_pvt =3D NULL;
> -	edac_mc_del_mc(mci->pdev);
> -	edac_mc_free(mci);
> +	if (do_free) {
> +		edac_mc_del_mc(mci->pdev);
> +		edac_mc_free(mci);
> +	}

This does not look straight forward here, it is exactly what a
device release function is for.

-Robert

>  }
> --=20
> 2.20.1
> --------------------------%<--------------------------
>=20
>=20
>=20
> Thanks,
>=20
> James
