Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F932EFF87
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKEOSC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 09:18:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24210 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbfKEOSC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Nov 2019 09:18:02 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5EH1Hh023266;
        Tue, 5 Nov 2019 06:17:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Mui7xLJp8M5WnOYt3eiAVnVXe2m3yRvHDSpZz6twFos=;
 b=qJpb4zaGwa+B/fm6xjLggoyNUcOfiq6XZQvqfjrmkLD1UzlkmBTV35xDlFV/vHeMKcLW
 JEHmBrW2LcR85w+9UihEcDu5j1ZJMxUXm62Q2+vgZeo2UQkI0+5d5/uOTm67PyhoQ7Lz
 jERdtPjUYZbsnIkXR/PJXrqYRc7DkJbZzP3Wgy456PjNU9bxJx51Yy4SRBgjQ2JCX6un
 42nReubiKLvQ8dF+sQIcZFPhqjo2kPNSyk/np9A/9HzCUXO3uvatqKpVeQm5wUDVZYIg
 BLiTK59k6x/1wl6uUrq1jomAp87YTwxFUZJCXFilxL7Cx55WSb37sSF3bl/WYFeiVACL gg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amtjcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 06:17:46 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 06:17:44 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 06:17:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ5EkRnABN9rH6MmDTwWb5T2trVqyGkyUv805ptEXc1x0f5z4/A3F/EGDd024m5g8Vlpt4z6glUTxctwIs2RNWjl0PwpA0zK5QvB5JK3/9ETNxrDzLx53cXT5OCoQSTN16yYuWbgPieXWdUzurp62g+UfGW9+p8rxteOHDZbZJbxbcuWwCDcTBvW8bzcafR51Rc2JaiSZEaZ5v5EiI1UBegUi8dTEJ3KXANrM9Z19WunYhPAoW/6w2+hm5nY60stdGaSMNfnAq5MkWeq3bCo/YY3IJMElBf6mmazS76QD/rrSlBwDuHdNJvG8Xo7zxmwR/IrjAqOeIX75pt+8sHJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mui7xLJp8M5WnOYt3eiAVnVXe2m3yRvHDSpZz6twFos=;
 b=Oe/8Zj4CX+1UdicQuJIv5iPN56uUnt+BfgqP+UCcRWvUPw8n9KBMVAwx0380iXGXvZpVl/8A0u3MEN99TVyeqzPJHy8aDJbLLE2eMNvpMFpNl4DJtGJPNnq1FSMWtTlPpQlzLInPlvV18tDZ8KNWmKXy1Gac4987He7+vtG5f2fuy0llKy2HPh8qXULpNR6/HwwhEpyF5O818jako04IOLW0EC+zQpdAZBJEYngfgs7g/A547JxG+JDeYaCRGA07t8JbrOB95VWqhr0+Rz1DNdnjZPV9RNP9FxgBiBE1UVPDcElj+c58l0ny1YQvCh85wyVtvn3DrOf+WDnk/NPShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mui7xLJp8M5WnOYt3eiAVnVXe2m3yRvHDSpZz6twFos=;
 b=q0oFIjIYCw20LfnR+k4ALqfO4a2by23lmaxonmGN0gP7+gfQ27VObFxqCG2Uo7Dzwn3h0kpZx8Ji4i7c+T4aZSEkJ7EVZcv69GJ77tzqRbT4I1QSVVE2jTFj4PTzAHqKk9naHXfaFaloSLFw4nY/dheElvN5ufrDAccxOPehVmo=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2765.namprd18.prod.outlook.com (20.179.22.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 14:17:42 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 14:17:42 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Thread-Topic: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Thread-Index: AQHVk+PJuJh4Edfnxk+7GO+UiAR1Og==
Date:   Tue, 5 Nov 2019 14:17:42 +0000
Message-ID: <20191105141734.ubw5qegth3hdahls@rric.localdomain>
References: <20191025211226.2444-1-rrichter@marvell.com>
 <20191105110511.GA28418@zn.tnic>
In-Reply-To: <20191105110511.GA28418@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0031.eurprd09.prod.outlook.com
 (2603:10a6:7:15::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c9cdc58-bc4a-409b-3ba6-08d761faebcc
x-ms-traffictypediagnostic: MN2PR18MB2765:
x-microsoft-antispam-prvs: <MN2PR18MB2765BE73F262DE473ECB56BFD97E0@MN2PR18MB2765.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(66556008)(6436002)(54906003)(316002)(186003)(26005)(6916009)(81166006)(81156014)(11346002)(9686003)(6512007)(1076003)(25786009)(6246003)(4326008)(99286004)(446003)(66066001)(478600001)(14454004)(476003)(66946007)(64756008)(7736002)(66476007)(86362001)(66446008)(52116002)(102836004)(486006)(8676002)(76176011)(256004)(8936002)(71200400001)(53546011)(6506007)(305945005)(6486002)(386003)(5660300002)(6116002)(3846002)(229853002)(14444005)(2906002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2765;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkOu8/6gFoQOVMeuq0+opqm1ho9YSMQRtuWx4ro7zFZdUp0UH6yQKWwSvBrEGQk9xU1xs5A++50A6QszoWS077axNQZnAZBNcf2BrHCHMPd5yndS2e1Vr2ci+rTkcPvMRAxvSknV5lmQ109hFNsitKKWnbAKAl+bUvXfyQYRanU2i9Psy3BN+vGHEBLua8/PxvwcI26yd3EnwNWFpSCZJ9mhHymNwnlYagJjltTxA5s1SQbxGIkcn70rFJ3B80bD+bK5sfYx3N8h3swEH6SbKM8p9LviHKrBZJEsvov1al34Rb+SkGEmqNyZQzy/BxL5I5dPZ6Mguj4gCshnELc6X3P+T1TUF2mQKBjNE6EfT9VchnLD0neGZnfWhgMj6gV4YSzy82s7JNW+29usnlkq5QO0Lrb99wRyPcxsIH9iIvdHVWfVhcVAVrtc5QTHAlFy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13F13CAC170B174BA9169A87D71BCD64@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9cdc58-bc4a-409b-3ba6-08d761faebcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:17:42.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8LE3tJxilJlM91exAzrJQUu7PQCgo5HxJwZso1RayqWxCaTvMGAKRXWSs8YEkcB4Hu07RppVgjEwFYL2hNTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2765
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_05:2019-11-05,2019-11-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 05.11.19 12:05:11, Borislav Petkov wrote:
> On Fri, Oct 25, 2019 at 09:13:14PM +0000, Robert Richter wrote:
> > The ghes registration and refcount is broken in several ways:
> >=20
> >  * ghes_edac_register() returns with success for a 2nd instance even
> >    if a first instance is still running.
>=20
> How?
>=20
> There's
>=20
>         if (atomic_inc_return(&ghes_init) > 1)
>                 return 0;
>=20
> there. How would a second instance bypass this?
>=20
> >  * The refcount was increased even if a registration failed. This
> >    leads to stale counters preventing the device from being released.
>=20
> That I see - the return path should dec ghes_init.

Here the bypass:

1) Entering ghes_edac_register(), instance #1

2) ghes_init atomicly set to 1, instance #1

3) Entering ghes_edac_register(), instance #2

4) ghes_init atomicly set to 2, instance #2

5) Leaving ghes_edac_register() with success, instance #2, note: First
   instance not yet done.

6) Leaving ghes_edac_register() with error, instance #1.

There are the following issues with this now:

1) Refcount is 2, though it should be zero as init failed with an
   error.

ghes_edac_register(), instance #2 returned already with success even
though:

2) ghes initialization was not yet done, and

3) ghes initialization is going to fail.

>=20
> >  * The ghes refcount may not be decremented properly on
> >    unregistration. Always decrement the refcount once
> >    ghes_edac_unregister() is called to keep the refcount sane.
>=20
> Right.
>=20
> >  * The ghes_pvt pointer is handed to the irq handler before
> >    registration finished.
> >=20
> >  * The mci structure could be freed while the irq handler is running.
> >=20
> > Fix this by adding a mutex to ghes_edac_register(). This mutex
> > serializes instances to register and unregister. The refcount is only
> > increased if the registration succeeded. This makes sure the refcount
> > is in a consistent state after registering or unregistering a device.
> > Note: A spinlock cannot be used here as the code section may sleep.
> >=20
> > The ghes_pvt is protected by ghes_lock now.
>=20
> This better be documented in the driver with a comment above the
> ghes_pvt thing.

Ok, will add a comment there.

>=20
> I'm assuming the support for multiple instances is going ontop of this?
> If so, ghes_pvt needs to be an array or so. Also, if you do that, I
> think you should use mc_devices - see edac_mc_find() et al - instead of
> growing a special one just for this driver.

Right, there will be a parent device created for each instance. But an
array is not required as this also can be part of the private data.
Only some sort of list head is needed to collect them all.

>=20
> > This ensures the pointer
> > is not updated before registration was finished or while the irq
> > handler is running. It is unset before unregistering the device
> > including necessary (implicit) memory barriers making the changes
> > visible to other cpus. Thus, the device can not be used anymore by an
> > interrupt.
> >=20
> > A refcount is needed. There can be multiple GHES structures being
> > defined (see ACPI 6.3 specification, 18.3.2.7 Generic Hardware Error
> > Source, "Some platforms may describe multiple Generic Hardware Error
> > Source structures with different notification types, ...").
> >=20
> > Another approach to use the mci's device refcount (get_device()) and
> > have a release function does not work here. A release function will be
> > called only for device_release() with the last put_device() call. The
> > device must be deleted *before* that with device_del(). This is only
> > possible by maintaining an own refcount.
> >=20
> > Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory contro=
ller")
> > Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove=
 path")
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/ghes_edac.c | 78 ++++++++++++++++++++++++++++------------
> >  1 file changed, 56 insertions(+), 22 deletions(-)
>=20
> ...
>=20
> > @@ -457,10 +461,12 @@ static struct acpi_platform_list plat_list[] =3D =
{
> >  int ghes_edac_register(struct ghes *ghes, struct device *dev)
> >  {
> >  	bool fake =3D false;
> > -	int rc, num_dimm =3D 0;
> > +	int rc =3D 0, num_dimm =3D 0;
> >  	struct mem_ctl_info *mci;
> > +	struct ghes_edac_pvt *pvt;
> >  	struct edac_mc_layer layers[1];
> >  	struct ghes_edac_dimm_fill dimm_fill;
> > +	unsigned long flags;
> >  	int idx =3D -1;
> > =20
> >  	if (IS_ENABLED(CONFIG_X86)) {
> > @@ -472,11 +478,14 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
> >  		idx =3D 0;
> >  	}
> > =20
> > +	/* finish another registration/unregistration instance first */
> > +	mutex_lock(&ghes_reg_mutex);
> > +
> >  	/*
> >  	 * We have only one logical memory controller to which all DIMMs belo=
ng.
> >  	 */
> > -	if (atomic_inc_return(&ghes_init) > 1)
> > -		return 0;
> > +	if (atomic_inc_not_zero(&ghes_init))
>=20
> That should probably be called ghes_instances now to make it obvious
> what it is.

I already thought of renaming this to ghes_refcount.

>=20
> Also, you can make it a normal variable now since it is being modified
> under the mutex only.

I would rather avoid an own implementation of reference counting and
also better switch from atomic_* to refcount_* which also provides
range checks. There is no benefit doing this our own.

Any objections here for the renaming and using the refcount API?

>=20
> > +		goto unlock;
> > =20
> >  	/* Get the number of DIMMs */
> >  	dmi_walk(ghes_edac_count_dimms, &num_dimm);
> > @@ -494,12 +503,13 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
> >  	mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct gh=
es_edac_pvt));
> >  	if (!mci) {
> >  		pr_info("Can't allocate memory for EDAC data\n");
> > -		return -ENOMEM;
> > +		rc =3D -ENOMEM;
> > +		goto unlock;
> >  	}
> > =20
> > -	ghes_pvt	=3D mci->pvt_info;
> > -	ghes_pvt->ghes	=3D ghes;
> > -	ghes_pvt->mci	=3D mci;
> > +	pvt		=3D mci->pvt_info;
> > +	pvt->ghes	=3D ghes;
> > +	pvt->mci	=3D mci;
> > =20
> >  	mci->pdev =3D dev;
> >  	mci->mtype_cap =3D MEM_FLAG_EMPTY;
> > @@ -541,23 +551,47 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
> >  	if (rc < 0) {
> >  		pr_info("Can't register at EDAC core\n");
> >  		edac_mc_free(mci);
> > -		return -ENODEV;
> > +		rc =3D -ENODEV;
>=20
> This needs to "goto unlock".

Umm, correct.

>=20
> >  	}
> > -	return 0;
> > +
> > +	spin_lock_irqsave(&ghes_lock, flags);
> > +	ghes_pvt =3D pvt;
> > +	spin_unlock_irqrestore(&ghes_lock, flags);
> > +
> > +	/* only increment on success */
> > +	atomic_inc(&ghes_init);
> > +
> > +unlock:
> > +	mutex_unlock(&ghes_reg_mutex);
> > +
> > +	return rc;
> >  }

Will, repost. Thanks for review.

-Robert
