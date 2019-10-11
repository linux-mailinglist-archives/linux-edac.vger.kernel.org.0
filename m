Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB00D3F3E
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJKMIv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 08:08:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43688 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbfJKMIu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 08:08:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BC73p2006344;
        Fri, 11 Oct 2019 05:08:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=emGdxfcpEAXYFo5qHdsHFiF9Otcr90DyYL9eA/+4e8A=;
 b=a9g6GFv9quAYxCxXbao50ZH0ui1guUPl8jUPOcEpWudHu3TYVX6cu+3V2n5SAhwVdiXC
 lduRSRCkwNmOqEgkKVnxEf3ZKAK45YJia0DL8RLW8G3gNeKHtIXd89il/U2UKLNgRqkh
 wRcV2L2XzmQQXOzpGfmtTGwn/yJIHb2iniokJnzjILv1NYhe9mjo+Ay/dzGRQ4PHhCPG
 9M0AnNipL26zjqUF3srB+UFkTgrMNjVCjdFzrIvKN1rewxfN0QI0U8bIHZFh+YK/xRqg
 jHpL4JdOIRRY1bbT+j42PgFOuMhOYMkXal7t8ChfT/41QNRVj61h5DSW/ihcVi8J+aAG yQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxc1gpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 05:08:36 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 05:08:34 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Oct 2019 05:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClG8ZgmuMgWWsP+VSAk+c/U6M7zae46XGxMedeCQNAX5/r+HVyBkqJ8oY7rRpfmi9kyq16LeSVkAxtTRxu74/ZxQiocLMW+zGCQ+0H5+UgIdjNj8osg4VOD9mgwOpWwvg5UhWA3u1yXDfcz8xEPIANLIHnlD9SazWbw5r/pQmjMzQBXzRANwXeTi56lywlJzcaFl4GTNNDRdPGB/VYIILyVCMX3xFfbHq7KNfnVH+w8Xjew9eG7FHgDOWkGQAERcHMfFXbPVf5YOLExNUTce3gFjawRk/rdPygOmtGE8TwFy3G5WAFCZNx6O3ZmUgPsFoMbc53aLiZB5qZeUa5vjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emGdxfcpEAXYFo5qHdsHFiF9Otcr90DyYL9eA/+4e8A=;
 b=I32/6Lr7uyd5r2st28/VksHFCK2LJ3qIX2DwZjoZVisEHHVJBbk7ot2fRmziGixfWrqjUmPM4qGoneee6cEbn0ZDEfLwCAn5597ocMsTypLlh7+fj7hiGdM9+TN/8U6PKcRQMahcS6Kp3Nz3N2WWptsYHO+yjb8GVBx+b8eI+eVIDBFipvwdehDEK8drJO0/3wUgk1wRY8jPp5f5C3hhMmz8tGDxndy0izLVDmquXzZ2vdPS2xWe0kiH0UqICB4YBVhxmcuqg/Ci/zlPc+r8GO45hvM6dzZRWYpUpsmEvtvPOJnE4R148SJ/Qr0Mka8ELh6PTCAfD6jb1hwAgroJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emGdxfcpEAXYFo5qHdsHFiF9Otcr90DyYL9eA/+4e8A=;
 b=ejBW7w2vC+lzSDMq9qk7YnObi/NkahuWtWdV72XeaCjBM7yqkuR9IjQLTd5ii7WKP57VoJIOfldTgsH3p9FTY4Gahy8eWJgtV0DRfMQJA8diJGqXiLvTVNPt6ZLkrMPC6Iu/eZ3TMCPHLLCPtxqNuA/bgJt0iC/kV6/jaFNCK5A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2575.namprd18.prod.outlook.com (20.179.82.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 12:08:32 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 12:08:32 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Joe Perches <joe@perches.com>
CC:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Topic: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Index: AQHVgCyZht18D38PtkqLpdPEJ7gD+w==
Date:   Fri, 11 Oct 2019 12:08:32 +0000
Message-ID: <20191011120824.y52pbji6qx6rstjr@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-6-rrichter@marvell.com>
 <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
 <20191011071920.3fb8c45c@coco.lan>
 <414f6658c088b9ac96ec4dad1ef751610dd83ce3.camel@perches.com>
In-Reply-To: <414f6658c088b9ac96ec4dad1ef751610dd83ce3.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0214.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::14) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6e82d19-2d1f-4740-ce7e-08d74e43bc0b
x-ms-traffictypediagnostic: MN2PR18MB2575:
x-microsoft-antispam-prvs: <MN2PR18MB257540B90279772975AC82D1D9970@MN2PR18MB2575.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(446003)(486006)(102836004)(71200400001)(14454004)(53546011)(71190400001)(186003)(4001150100001)(6506007)(99286004)(52116002)(386003)(11346002)(316002)(54906003)(256004)(26005)(229853002)(25786009)(76176011)(476003)(478600001)(6486002)(6916009)(86362001)(3846002)(6116002)(6512007)(9686003)(81166006)(305945005)(6246003)(1076003)(66066001)(8936002)(81156014)(7736002)(2906002)(4326008)(5660300002)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2575;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRm4BAllWumQO9sySa2T6RWsw3hjsodTg3cyvQNNfX1jd8A6SgtuBuR7t9iM71dBKzUhl9v8OKI5WzUrGi6OxNw/NmgAfH70XoghLuC9CaGjBy94GEjjkLlKN1uqzzM5Bps9T6QNxNExtokT09lW1W2Us0ZtuYv9RFHkG51T2+5QZKlOjtYT66V6ZROvWyC39yVHesB0VvfaVp40jOR3dbDdb4hxUHgvr0Cx48pzUlkZtzW0bTFfxSZT3zwzCZyLXtVJymhkdG/ZeSl5otVTldsHIY0cKLQRtBuXMv5T3SjCy9uPw8nLG3YVOBjh2NWO9QcXlwoEk2tRHjdZ/uvLpALiMvz7DdMPSXwDmtFO14tuGHEzAAF3x2EzuigTAcPKpBOo+o5qsWdk5QOkrlpleYV/S9PZoy/z2lCWI+naFd8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7902E22C5E744C449A79A05537EAC24C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e82d19-2d1f-4740-ce7e-08d74e43bc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 12:08:32.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUBfcYJCGdkpvErcWGDBNFuFDf+VJCTkk6AdrxkT/Gk3URiRb3DLPD6hRT+xcbNx1xMd8ngWWa1drj5+qQ+pXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2575
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.10.19 03:50:23, Joe Perches wrote:
> On Fri, 2019-10-11 at 07:20 -0300, Mauro Carvalho Chehab wrote:
> > Em Thu, 10 Oct 2019 15:10:53 -0700
> > Joe Perches <joe@perches.com> escreveu:
> >=20
> > > On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> > > > Reduce the indentation level in edac_mc_handle_error() a bit by usi=
ng
> > > > continue. No functional changes. =20
> > >=20
> > > Seems fine, but trivially below:
> > >=20
> > > > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c =20
> > > []
> > > > @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_eve=
nt_mc_err_type type, =20
> > > []
> > > > +		strcpy(p, dimm->label);
> > > > +		p +=3D strlen(p);
> > > > +		*p =3D '\0'; =20
> > >=20
> > > This *p =3D '\0' is unnecessary as the strcpy already did that.
> >=20
> > True, but better to put it on a separate patch, as it makes
> > easier to review if you don't mix code de-indent with changes.
> >=20
> > Also, maybe there are other occurrences of this pattern.
>=20
> Maybe 80 or so uses of paired
>=20
> 	strcpy(foo, bar);
> 	strlen(foo)
>=20
> where another function like stpcpy, which doesn't exist
> in the kernel, could have been used.

Under drivers/edac/ I found this one place only.

So I could create a separate patch as a oneliner with that (trivial)
change?

Thanks,

-Robert
