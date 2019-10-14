Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319A2D6106
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfJNLMt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 07:12:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61708 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731767AbfJNLMt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 07:12:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9EBAAe3014674;
        Mon, 14 Oct 2019 04:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=FjJFi/lV4hcCh/WkDmsRb/8C20q1g6PN9wZmshHmPCY=;
 b=NLZ1CpsjWbYY9pZaAMRSnPfNWjoOgITRt/65RR58IINOFz5Fa9ETvuBS7FVNQzVo5RF3
 RJf3IQPejdNmkXpCiG6JTIU2K7anTBAv+YD/DMJPQpSF6gAdsr6b+Yd2wxGyKOlS3LEj
 gKtjY9pP+HOF6vBhZcsSpacRBgnymos4EEuuaAOVe604BegeAJxtHecK0f32C+d7qxz6
 prHC1CW8ebvyCljBDUfjMqieC4Y7+SeUwGmBg8zahh7YgMySxkjtgLCayl6Gwwn3NTEu
 wMIUu8O9+1NWCT+M6gJcSUO+s4hevWBeS8c9hr15Rby6vNRnUQ4m9tWXfMRc11xmQVZx 9Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebnwg53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 04:12:26 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 14 Oct
 2019 04:12:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Oct 2019 04:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYtUAwbsYwHMMkPm2yB5PvCufeU7Yt2CB5NHViiNNEMsKtutnt3zzrERfi3ut2jIQYff9TSa4261voSmwypJHEaDplsmqFDWJiSxa2eEiZpyjmBrlO6eLTdSEbBaigT8LXVyOC7EDRGdIDFBJ0U2MAV4+Lm377PgEWC1+r5e1XEk0k1TbVdVpb77hRiQ83clYyCo6OGjKlkn8pa/QF77M9Kxpe95rD+smsjwq3ZXE/FkM3CVQ0DUTgITm8eErm7G7PQxXsjAkfCHNEikYmobHYhHSX7uVHcYE7o0PoXBohnIBikNdA0dsEBxalnz/Ny9PeHt1l1bRnWpzuBUmwaAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjJFi/lV4hcCh/WkDmsRb/8C20q1g6PN9wZmshHmPCY=;
 b=QVBG98EnPo/TN3o8S0VXpjalsQzpWHcbJ2wYEby9kzDA1J0/rGNiIiSd5EDLCTJw7qGYm9nqJNwIv/hk8vlLIkMyzd4KFNxbOO7xNaxRE9/fipMGL2KXM6U4cEk/55X1QQn6Ifdvnvw52Bmx8H5OHYWB+KHyEyTXCVgmLiJZVMj0NGu3GpNcUdXcLQlxejXWj2a0fGuz5YH+iVuHE+YSdnUi0aUfYmBJb70lQgKqEFDwkZQkHwjfCo12/Jjl7qZKZfzy90teJ/VJjgHGrs/vgx59IYTZw6DvvB+TvbJ8oAcdj0BDO7b4w3llDCRIsMDCTm0VHGujV8en6g+sqQDD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjJFi/lV4hcCh/WkDmsRb/8C20q1g6PN9wZmshHmPCY=;
 b=D6X2k2k5Ierowwv3ceyATpuz0t5vbkuWUkjLg8jtKOa+dCaqF0UI552NvT0oI2FpyeZiAzjmDEE26q2tSje7FWRCAi/bgWqdW8vLRLDyC+t3xKQgOK39nDz+RTk7lCj1ED59dBcN8ho5fs2642oJA3J5PMDVL1NubyCxBySnB3E=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2399.namprd18.prod.outlook.com (20.179.82.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 11:12:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.023; Mon, 14 Oct 2019
 11:12:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/19] EDAC, mc: Remove per layer counters
Thread-Topic: [PATCH 06/19] EDAC, mc: Remove per layer counters
Thread-Index: AQHVf6jU3Hq1HIO940WaZOfHTRxydKdVQUmAgAS/3YA=
Date:   Mon, 14 Oct 2019 11:12:23 +0000
Message-ID: <20191014111215.f5wyed33ilppfopg@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-7-rrichter@marvell.com>
 <20191011074031.699396df@coco.lan>
In-Reply-To: <20191011074031.699396df@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:7:67::22) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 613c4445-5726-4e54-1dd3-08d750976328
x-ms-traffictypediagnostic: MN2PR18MB2399:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MN2PR18MB2399851D8ED78929D6817C5BD9900@MN2PR18MB2399.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(305945005)(7736002)(6436002)(446003)(6246003)(2906002)(966005)(229853002)(478600001)(3846002)(6512007)(9686003)(6116002)(6306002)(8936002)(86362001)(486006)(81156014)(8676002)(81166006)(11346002)(71190400001)(71200400001)(256004)(476003)(1076003)(66476007)(66556008)(64756008)(66446008)(52116002)(102836004)(99286004)(5660300002)(54906003)(66946007)(316002)(25786009)(66066001)(14454004)(76176011)(6916009)(186003)(386003)(26005)(6506007)(53546011)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2399;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cRyHqW+wF/ksVaaFgYw1UKtlNYZDRpJFBG/oIwqjJ6NMphjEM93oOMIhc+4QD1DdapwKhz7V2j4Mq7o4iELi7Faifj2XOYp9AlhXo0boW+JqaOEAGoezdkvhzxO66KUcdoDPRXrug2B4YcjCQ2wtwvx1qOnmJEXoL3ph49kvtmtjm3pC4pCt0pUKvIbbzC2FP0FO6Qh/KcpJ3fHh4TWM4YTyCQrNVFDamURmUaWDOAtC2G32ekhL5ZD6YeXjC/WNRWc6Vghy/ICxzBQZSxZVZ92eKvAgK3S/0SeL0PwC4ksknuW5VHlWJ5xuORmtj5smoD7EUcCMF0gOBy84F8ZoA8AsdSY9uZYj/nTeGQImPdxHgkEymwCp/GA8Sw7KwXCOjYyBp0WGHz0KLNmdWudRce1MJhtvxDH2X8LOmVlY1mVQCrqQFTbfLqsbgBqVhey1XHg7OWcl4+svdNjEnWwD8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <264E08D05C6B3E47972EEB2C28D8F64E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 613c4445-5726-4e54-1dd3-08d750976328
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 11:12:23.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvvTQ64qc+izlGOsf4srgY9VqltlFdKkLeSGm4gwdKYEHHGqOigU18lukB9uzDC0g5Ny7GlQz1Szq0u7KGonmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2399
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_07:2019-10-11,2019-10-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.10.19 07:40:31, Mauro Carvalho Chehab wrote:
> Em Thu, 10 Oct 2019 20:25:16 +0000
> Robert Richter <rrichter@marvell.com> escreveu:
>=20
> > Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
> > turns out that only the leaves in the memory hierarchy are consumed
> > (in sysfs), but not the intermediate layers, e.g.:
> >=20
> >  count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
> >=20
> > These unused counters only add complexity, remove them. The error
> > counter values are directly stored in struct dimm_info now.
>=20
> Hmm... not sure if this patch is correct. I remember that there are some
> border cases on some drivers (maybe the 3-layer drivers used together
> with RDIMM memory controllers?) where some errors are not associated
> to an specific dimm, but, instead, are related to a problem at the memory
> bus.
>=20
> Also, depending on how the memory controllers are organized[1], the ECC
> logic groups memory on DIMM pairs. So, when an error occur, it may be
> either at DIMM1 or DIMM2.
>=20
> [1] On Intel, this happens with pre-Nehalem memory controllers.
>=20
> Due to that, storing errors at the dimm struct sounds wrong, as the
> error may affect multiple DIMMs or even the entire layer.

That was my first thought too, but the counter values are not used at
all. The only exception is to provide *per-dimm* counters here:

 {ce,ue}_per_layer[n_layers-1][dimm->idx].=20

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/edac/edac_mc_sysfs.c?id=3D4f5cafb5cb8471e54afdc9054d973535614f7675#n5=
67
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/edac/edac_mc_sysfs.c?id=3D4f5cafb5cb8471e54afdc9054d973535614f7675#n5=
84

The case you mentioned above is if the mc only sends parts of the
error location (with a top, mid or low layer missing). The dimm cannot
be identified then. In this case edac_mc_handle_error() tries to find
a unique row (+ channel infomation if available and lists all possible
dimm labels in e->label. See:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/edac/edac_mc.c?id=3D4f5cafb5cb8471e54afdc9054d973535614f7675#n1153

Thus, we see a counter increment for row (and also channel if it can
be identified), but this is counted in mci->csrows array only that is
not removed by this patch.

That said, the {ue,ce}_per_layer[] arrays can be removed by keeping
the same driver functionality, esp. the case you mentioned above.

-Robert
