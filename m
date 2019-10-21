Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCADEA12
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfJUKw6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 06:52:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23332 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfJUKw6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 06:52:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LAo5s4000452;
        Mon, 21 Oct 2019 03:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=D6zRwaIWOfpFdmdgmbd1D3/JQd10lIpWEPLfrHYX/R0=;
 b=gwmP0kXbxigPuh9et6+9xwHKt9RGIRpFHWuDdoSK4C8yYhJXcnXfB8rPr/1sNZ3iQ9Bn
 ZElwYEWKJYvv2AFLC/IHR5b0WJ5X7yx/TvwmBdg5yfPZNTmYe1+NENe0kWXNslwrkJuD
 tnUAfx2mwHLWrBPm5BWl2gZi1yMyOEvYmC0QrLqmdT5brupanJv/cqD6WpWyRXGXd63N
 5G6qfM1KC9NN7cv8F0x70npX+J7YuC0QEOE3zSdHluLqngJtH5gzinFAZK6VYJsaz0rB
 DEeJpP7XebEe36jL0yXj9kDxPZeQuCX1gf6SP5IddrE6SnimpkQsfu3eZnd4PCig9K8S kQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vqyuqed80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 03:52:36 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 21 Oct
 2019 03:52:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 21 Oct 2019 03:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNcldWr0aIROEO4gRqjCdYwCrx8/9kgEtSVk+eAEflnmrh4GkrQpon+4n9BLGtA5NuvmLv7UhOkhO3X9Z2GAVvB0LTcSYMd0cK/D/gt3Ojww1Imo4mCLbbmP/XsaTtSt3T8Qq1NCYmTgN84cl2Oip5Y+dtW4NQXMdpPvQ0ZR7XTEqGjw9nIT/oanPbOwfoLNRfVd3DroAas2QU4foTwGVL5HYwN12Lkskh95eHJCWAfbNiJT9wFSNfLRIbDSgMEIPDgoDNRiheSYDmP8POut3nkZDUlXkptH/q/o+g0CK2XjU4qv5pC4E8snsjLHbtYG5GEsDs7fuOPbWdljVG1joQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6zRwaIWOfpFdmdgmbd1D3/JQd10lIpWEPLfrHYX/R0=;
 b=h4fCVxu2ZbbLZH7ZtB0pHS8GVyc6+9AUXPQMi823bfMXNbd3aXgYigLysskBgcjB7ezR1FUHq3cF5f+XG/ifqQVniOb8Ok5gDm7nvHRQrbkaCnycWTP4IvN3hEMn8qktmN8bayRHMAlriv4w7onnuTTHJcD2iG+XIG8y+by73nZmVvuUYOBikH1FMVAfJqFCv3WStpSe/wSGuTEcA50wnqHmEkNC79d0FsGgDr5XPSQbhOb1TYLTWSLliC4tev3XQmSKfw8Vcjs4H5YtF6KCUAshR6Q4RTG6H6cFcLa8X16Af4qwlM8fwCCWjK5jhgQdbqVLJmZ3Pqd8exOA4jNMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6zRwaIWOfpFdmdgmbd1D3/JQd10lIpWEPLfrHYX/R0=;
 b=F9B/b4D4fQvWGyKu0bruaBUO//YgvQAMv/J81ZTpYE+Ksu4fvE86X0WQ0WgD6Ju5leCYyVeIYzbhjubYLaDAuURcu9wkAPS/CXLMrb0ddolpSaAytie+ALUSgdtU7i/+yJGw95ixQJyo2W5y2B4kINFNji5W3txfW3fv0EHvuh0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3263.namprd18.prod.outlook.com (10.255.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 21 Oct 2019 10:52:33 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 10:52:33 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Thread-Topic: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Thread-Index: AQHVh/2kcl9QI6RLykC/ZJa4RsgERQ==
Date:   Mon, 21 Oct 2019 10:52:33 +0000
Message-ID: <20191021105226.qt22i4bdvtu2uwh3@rric.localdomain>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
 <20191014175319.GH4715@zn.tnic> <20191016151751.GH1138@zn.tnic>
 <d8899938-72c2-909d-1528-2e763820bd75@arm.com>
 <20191016185041.GM1138@zn.tnic> <20191021073757.GA7014@zn.tnic>
In-Reply-To: <20191021073757.GA7014@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0071.eurprd07.prod.outlook.com
 (2603:10a6:3:64::15) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e72c146c-aef2-4a9e-4760-08d75614c6f6
x-ms-traffictypediagnostic: MN2PR18MB3263:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB32635DED05229421A32831B9D9690@MN2PR18MB3263.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(52314003)(189003)(199004)(25786009)(14454004)(71200400001)(8936002)(86362001)(1076003)(71190400001)(54906003)(6246003)(66446008)(66476007)(66946007)(66556008)(76176011)(7736002)(186003)(486006)(26005)(64756008)(305945005)(476003)(446003)(11346002)(53546011)(6506007)(386003)(6486002)(6916009)(66066001)(102836004)(229853002)(966005)(256004)(14444005)(8676002)(5660300002)(316002)(478600001)(99286004)(2906002)(6116002)(6306002)(81166006)(9686003)(6512007)(81156014)(52116002)(4326008)(6436002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3263;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t2mZk4BVzWAdX94875d/2fFQ/R/0bicauud5A3Umks0qFXmfS8sMIRSY9xwhIezvbUF128/a2JgL29hs3lvA0KEXzn/CwXp7YR8dwqgaSol+MKymgptjg/xuJXeLxLf32+LGT9fvEXjoQDnHb5b3RqOpMlIEp/NZfZ7N3oE8uKaYWP76OME/U+xusHQ2Vzi3xzx8yB/lPOZMGrBqLAxcxBBqihRbPLn4JengIeRfb2WkMT2VKnV/VhgNKKIZJrYZPd7zyyF6W6wWPxNus3dh4+ZI3QCs8hf9z7twfsnLX7zj83t+qQJ5/pzncb/eUFY2fAPylNXhOgYHTDIr1fbUrDB11hPvWYqTvG5vwQlkdo55s+YMWCe6OjDrC0jTAdVDF5J66SamtLY92FIlLSFCUvyUEr856hGOnYPsGEV0j5yy85oieZ6J1Y9Me92WqNujkBa9JdvA64SdZkLIYbAQAU5NxHTCFBQWxI9pDxQtxk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90FDB8317C9312418C92AA22EFA36D75@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e72c146c-aef2-4a9e-4760-08d75614c6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 10:52:33.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHDVsq0fJlyjQbZyERZlWrvIBNFEFCAE6BPC12A7PupqvqwY+S8mLpup8KNKissmtrpfayZQ6g6EAaQvpYxXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3263
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_03:2019-10-21,2019-10-21 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 21.10.19 09:37:58, Borislav Petkov wrote:
> On Wed, Oct 16, 2019 at 08:50:41PM +0200, Borislav Petkov wrote:
> > Yeah, before we do this, lemme try to simplify the situation more. And
> > yeah, we don't need the mutex - we can use the spinlock only. But let's
> > get rid of the need to access the pvt in the IRQ handler. Yeah, we need
> > the *mci pointer but one can't have it all :)
> >=20
> > Anyway, here's what I have, it is only build-tested. I wanna give it a
> > stern look tomorrow, on a clear head again:
>=20
> And now I went and redid your patch ontop and thus completely got rid of
> ghes_pvt in favor of having one global ghes_mci pointer.

please do not do that. While we have atm only one ghes instance
including a single mci, we will need in the future multiple mci
instances to reflect the memory layout in sysfs. I sent already a
patch for this and am going to resent an updated version, see:

 https://lore.kernel.org/patchwork/patch/1093472/

> We access it only under the lock and we publish it in
> ghes_edac_register() only in the success case. Can't get any simpler
> than that.
>=20
> Thoughts?

So, could we just keep all data in struct ghes_edac_pvt instead of
global data?

> I think it is a lot cleaner and straight-forward this way. Lemme know if
> you wanna run it on your setup and I'll push the two patches somewhere.

Could we please properly repost patches for review? James last one got
lost as an answer in this mail thread, but contains fundamental
changes of data structures and locking (while the both initially
posted patches contained reasonable oneliners).

I will start reviewing James' last patch now.

Thanks,

-Robert
