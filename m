Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229FDD61CD
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfJNL6Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 07:58:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56166 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbfJNL6Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 07:58:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EBoVcN020200;
        Mon, 14 Oct 2019 04:58:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8SCCjot5Um+On6CZQ5zsM+VbwM/I0m7p/VDVHeU5z9w=;
 b=b7bRJ8O3SrlOmeCc85CNQZ+9j2IyQUZHIusW8PRXhbthOFaNuVy0uQUud3fFB4rbb4ZR
 ScxBdOLoSpgYbZErXr0KC6uRfrYG6ElDkacf5X/a3QjyWcpNez6AnoF2RGmALTDb8Ilm
 bC3oG2R1dKeWi4zqUGFwQukMkHrst5tmkO4YgcnoLTh47eu6hRVkzZ7pimhb1At88avc
 c7Lsj3jfspC3l4gYMBn+5J5aUgE8rZxgxIQuNcEZqiygegFy2dryPn/DBD1ZsJnpRNYJ
 u+fwXsJHCNDBEMRf6oPqy0IVZ2nNK2ER5AjNZ+6vhWE8NVEEmLqEA/bKjX9Y4yDfrFgB 9g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vkc6r6ae0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 04:58:06 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 14 Oct
 2019 04:58:05 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Oct 2019 04:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flt55s8oBnk0l0M9NiSbnu0nVfwMIwyDERxmv0lD1oG1YxKmrjG6m5lY/zM0j0EsevOhNlrRT0VP/53Fu7NGsE0rdVF2yMHraqf0YYzfoB7mZGbkRLUQyuzradJiUyz9DzDTddz8VsJihH3AfLaWo8YU7QXt+QFCGJfVpJHYEgbTPWPK+BFA7NtCUisRSTzuIowf98Ez0Po3DTTtKNzJ//Cvn+Ed29mpvDlIIL8KQ89yZSWSwxWUXRRYj/HoEg5UK+EXOXtd+bTTqrjBLrbE8/x6pUordGC1SmHtMTDfrfzAFuTfeVLZm1tq5Y/Kth5ZwBnK4U+2GUD3wKxAeGw0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SCCjot5Um+On6CZQ5zsM+VbwM/I0m7p/VDVHeU5z9w=;
 b=Ftu2Og6ccRnsumETd8KLNYw7s1rJ/4zzfbFY0wHgjiFkW8frx38WRbqJUAb/3H13TQNHjgrkd1ePLbi6IILObTlW/GqxuDU6E+LLma0KR0Dgz7/xS/VC3piSuusoXbCVZ3DAz4Us1x9IobbTrdc3CzWGrRNcmJled87agFG5hRaS88Z1mx0P3CFKYtyO3kUs94y0Fx83TIzjhJOcSiQUqI6ncEJUpioQdFoF6ooF+/ouWb58Ul5pgPppCn19tDaxW8aOQqnpjtY7TWRDVZxKyEhbWxpz/WQ+NCAHPNkAAbXuhWzchGQFoSUW9vsiKkpbP0ZKtmVS8rFKTrBAG42AcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SCCjot5Um+On6CZQ5zsM+VbwM/I0m7p/VDVHeU5z9w=;
 b=gP+nnwwJ4eIWh2GbTxGSkYSOgpNn4cMs1YCc+oV6yXi5iraCkdh8rlK8jfNYUW6pIcdH8JytvP2dsqvrVHL6xrCMlHqGpOlwtNHIvJnK9tidOLbn3XNhkhoWCPD6aJ9tqJCAi2eGSz5auWmqZMkCyf1svghCZ4o+DpbIgADthVU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3264.namprd18.prod.outlook.com (10.255.238.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 11:58:03 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 11:58:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/19] EDAC, mc: Create new function edac_inc_csrow()
Thread-Topic: [PATCH 14/19] EDAC, mc: Create new function edac_inc_csrow()
Thread-Index: AQHVf6jd4a7gKhx+NUm64guphBxEUKdVSRWAgATE1YA=
Date:   Mon, 14 Oct 2019 11:58:03 +0000
Message-ID: <20191014115757.fajnqzsn35qgqu7w@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-15-rrichter@marvell.com>
 <20191011080825.74932496@coco.lan>
In-Reply-To: <20191011080825.74932496@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0308.eurprd05.prod.outlook.com
 (2603:10a6:7:93::39) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8eadad6-96c8-42ab-a652-08d7509dc46f
x-ms-traffictypediagnostic: MN2PR18MB3264:
x-microsoft-antispam-prvs: <MN2PR18MB326411E91C77D2CBE3E3DEA6D9900@MN2PR18MB3264.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39850400004)(199004)(189003)(446003)(5660300002)(1076003)(305945005)(476003)(11346002)(6916009)(7736002)(102836004)(26005)(186003)(486006)(6116002)(3846002)(316002)(54906003)(9686003)(6512007)(229853002)(6436002)(6486002)(86362001)(2906002)(66066001)(6506007)(386003)(76176011)(99286004)(52116002)(4326008)(6246003)(25786009)(14454004)(478600001)(53546011)(66476007)(66946007)(66446008)(64756008)(66556008)(8936002)(81166006)(8676002)(81156014)(256004)(14444005)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3264;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRNJqFIbpw0HIUKJlcpjIr0iprdnYMePytLLfE84BuAmbmlzoD/1C5DYiMuMxT8pFQ1nwg/p37TRj2XE4Y/5vT/H5vSnj7vAbollOkorDe1xBoxKUn08f6nxLYJ+lGOFlwiI4paZ8EQdZEcKnnLmGxKOYynSeeDUaqT2FyPZcYVLr5DZatcRyROBBWC8Jjfs85SiDB0No3+YUjoWyn5rfY+7DMqInPL+9PL+/x6JIZoRL5qaDRz8vaKr7otlePLshy9Jgpks6GgKw4AqzbKDT0A2GUANGv6IVxz3td08T9C3pd+Xs2RKY1UlBKyOBiAwPmQzSRV3ZVdA5g4GpAyu/hgQzWCsn/XIJqbkSQ4yKFvcnCUK3Jnq9hgpniUdeSfpRKNlT/4rxkMVLfqOuQIncBHwcPltA+yUfnD1CTq45VA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D4B9BF5AFBA434AA489F5C45754CDC7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eadad6-96c8-42ab-a652-08d7509dc46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 11:58:03.3892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WT9mGXpna7LGPdUErC2Vbt26dXGfZINaXDuluVL1RIcvYCfD1n1pFr60jpoJFdTk0fAZtzDQsx06ON+injpbvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3264
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_07:2019-10-11,2019-10-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.10.19 08:08:25, Mauro Carvalho Chehab wrote:
> Em Thu, 10 Oct 2019 20:25:33 +0000
> Robert Richter <rrichter@marvell.com> escreveu:
>=20
> > Have a separate function to count errors in csrow/channel. This better
> > separates code and reduces the indentation level. No functional
> > changes.
>=20
> This one assumes patch 06/19, with I'm not sure if it is correct.

See also my answer there, the driver should still work as you expect
it even with patch #6 applied. This patch is important to isolate the
csrow handling that makes the code much better understandable and
readable. I hope there are no concerns to this patch.

Thank you for review.

-Robert

>=20
> >=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
> >  1 file changed, 25 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index 9e8c5716a8c0..3779204c0e21 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -1045,6 +1045,26 @@ static struct mem_ctl_info *error_desc_to_mci(st=
ruct edac_raw_error_desc *e)
> >  	return container_of(e, struct mem_ctl_info, error_desc);
> >  }
> > =20
> > +static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int=
 chan)
> > +{
> > +	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
> > +	u16 count =3D e->error_count;
> > +	enum hw_event_mc_err_type type =3D e->type;
> > +
> > +	if (row < 0)
> > +		return;
> > +
> > +	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> > +
> > +	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
> > +		mci->csrows[row]->ce_count +=3D count;
> > +		if (chan >=3D 0)
> > +			mci->csrows[row]->channels[chan]->ce_count +=3D count;
> > +	} else {
> > +		mci->csrows[row]->ue_count +=3D count;
> > +	}
> > +}
> > +
> >  void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
> >  			      struct dimm_info *dimm)
> >  {
> > @@ -1201,22 +1221,12 @@ void edac_mc_handle_error(const enum hw_event_m=
c_err_type type,
> >  			chan =3D -2;
> >  	}
> > =20
> > -	if (any_memory) {
> > +	if (any_memory)
> >  		strcpy(e->label, "any memory");
> > -	} else {
> > -		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> > -		if (p =3D=3D e->label)
> > -			strcpy(e->label, "unknown memory");
> > -		if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
> > -			if (row >=3D 0) {
> > -				mci->csrows[row]->ce_count +=3D error_count;
> > -				if (chan >=3D 0)
> > -					mci->csrows[row]->channels[chan]->ce_count +=3D error_count;
> > -			}
> > -		} else
> > -			if (row >=3D 0)
> > -				mci->csrows[row]->ue_count +=3D error_count;
> > -	}
> > +	else if (!*e->label)
> > +		strcpy(e->label, "unknown memory");
> > +
> > +	edac_inc_csrow(e, row, chan);
> > =20
> >  	/* Fill the RAM location data */
> >  	p =3D e->location;
>=20
>=20
>=20
> Thanks,
> Mauro
