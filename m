Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D0942E64
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfFLSNd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 14:13:33 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37948 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfFLSNd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 14:13:33 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CI7nat016372;
        Wed, 12 Jun 2019 11:13:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tiVs2wKAz6zr2LspFolfMg9NNAGYJ0+uTUd0IVEXaec=;
 b=O2rUqEQ0N/JewVeOkyMIvfidr3KyaDq9ceVfI0s9IgxDJNo8jieUOZggTWOpdWv0W67B
 VuA4ZeDDsGddu70snuvf4G4O1QX+71X9EYBdmOKfb0A2d7RtRS2ZbHYc//fL40UfDDss
 9SG+k2UkonAmteER3awTexD95aeKBJP3WK0pma4TjF6z85mVwlFJ2I10GyVeXsEfecU/
 l0FS6lsNM4cVaSVXXF90Ak/q4MSAb4O2YBGOMIu9mYC5POPVl0nNcrDc8r6gB6C1ds5U
 S6/zekcmwid/Pk3WEE/ljvgoC/CmOmeKWIeHt1JRK24P6eL4zExzyaK1kmBAd2T909qR Iw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t34ngrfqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 11:13:22 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 11:13:21 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 11:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiVs2wKAz6zr2LspFolfMg9NNAGYJ0+uTUd0IVEXaec=;
 b=u3meptCwnOQM8cdtd5k0qB+2EYDneibM7QOQp16g2+n+FjxGC5KJZjg/1lk4MELBtINl/rFsPyAMRSWeQKsz0hgaFjPjzyo2WzJirNBW+zHe6tcW95qJlihdvlRRJJGLlC1NlVdMww+Iyqonh1bmT1CxCC4T7Pd0R5m0vLWWWwc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3120.namprd18.prod.outlook.com (10.255.86.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Wed, 12 Jun 2019 18:13:16 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 18:13:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/21] EDAC, ghes: Remove pvt->detail_location string
Thread-Topic: [PATCH 10/21] EDAC, ghes: Remove pvt->detail_location string
Thread-Index: AQHVIUqBClS7eZ01n0uWYz4frFwiGQ==
Date:   Wed, 12 Jun 2019 18:13:16 +0000
Message-ID: <20190612181309.l36jlynvqe7xaqmi@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-11-rrichter@marvell.com>
 <7017c91e-8923-c8d2-26ca-875328ab855a@arm.com>
In-Reply-To: <7017c91e-8923-c8d2-26ca-875328ab855a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0060.eurprd04.prod.outlook.com
 (2603:10a6:3:19::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930f6eda-d846-4198-85fb-08d6ef61a3fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3120;
x-ms-traffictypediagnostic: MN2PR18MB3120:
x-microsoft-antispam-prvs: <MN2PR18MB3120DAB93298E23E688C05E6D9EC0@MN2PR18MB3120.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(8936002)(11346002)(81156014)(446003)(81166006)(8676002)(486006)(476003)(99286004)(86362001)(6436002)(52116002)(68736007)(9686003)(6512007)(229853002)(71200400001)(71190400001)(6506007)(386003)(53546011)(256004)(102836004)(54906003)(316002)(76176011)(478600001)(4326008)(25786009)(66066001)(73956011)(5660300002)(66946007)(1076003)(66476007)(64756008)(66446008)(66556008)(14454004)(6116002)(3846002)(26005)(6486002)(305945005)(2906002)(186003)(53936002)(7736002)(6246003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3120;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /WEHW714XwHr/A+RbG3CyPwjrsxTXiwE8FDoyAjoP+EF99r9xFotopUVf7OVVcYPTqTRtZFjdLfEcQAYtuUj2UYxj2LCpQWrhyUcAedl8gxNN4XJUETPytki3At+8owLIHJD74pQ025WeB+W04kOa1u5Ftj/9gGkq3158TrG3hbKbvbukl2cg8iuwH/3XpdYYXadKsmhHZ8yw9yGX13F0fT2xuRodhUN3jwKidGwnNtlfvckD5XCKl2Yaad6U2cUj2cU9CCGwVSrEkw2fR0C9Whb3EMiHLiF7cUVImYK4oCpjOsFk/k6Dss1ODeCg/Yf1eGh7SmNPvP4nVAFn0jlQ1ITlesupu7p7Urfya7FRJfDtbXTrnoi3XcA+l7Mey/zazSsQs5zDLpK8YZK4b7S5jgN0thrZ38XM20bCuMAS4g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F1BF1CC4996C84D8FB92A698ED69D01@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 930f6eda-d846-4198-85fb-08d6ef61a3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 18:13:16.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3120
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_11:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29.05.19 16:13:20, James Morse wrote:
> Hi Robert,
>=20
> On 29/05/2019 09:44, Robert Richter wrote:
> > The detail_location[] string in struct ghes_edac_pvt is complete
> > useless and data is just copied around. Put everything into
> > e->other_detail from the beginning.
>=20
> We still print all that complete-useless detail_location stuff... so this=
 commit message
> had me confused about what you're doing here. I think you meant the space=
 for the string,
> instead of the value!

No, this patch does not remove the driver details nor it changes the
data representation. It changes how that data is prepared internally.
The patch removes the (useless) intermediate buffer detail_location[]
and writes everything directly into other_detail[] buffer.

>=20
> | detail_location[] is used to collect two location strings so they can b=
e passed as one
> | to trace_mc_event(). Instead of having an extra copy step, assemble the=
 location string
> | in other_detail[] from the beginning.
>=20
>=20
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index 39702bac5eaf..c18f16bc9e4d 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -23,8 +23,7 @@ struct ghes_edac_pvt {
> >  	struct mem_ctl_info *mci;
> > =20
> >  	/* Buffers for the error handling routine */
> > -	char detail_location[240];
> > -	char other_detail[160];
> > +	char other_detail[400];
> >  	char msg[80];
> >  };
> > =20
> > @@ -225,13 +224,14 @@ void ghes_edac_report_mem_error(int sev, struct c=
per_sec_mem_err *mem_err)
> >  	memset(e, 0, sizeof (*e));
> >  	e->error_count =3D 1;
> >  	strcpy(e->label, "unknown label");
> > -	e->msg =3D pvt->msg;
> > -	e->other_detail =3D pvt->other_detail;
> >  	e->top_layer =3D -1;
> >  	e->mid_layer =3D -1;
> >  	e->low_layer =3D -1;
> > -	*pvt->other_detail =3D '\0';
> > +	e->msg =3D pvt->msg;
> > +	e->other_detail =3D pvt->other_detail;
> > +
> >  	*pvt->msg =3D '\0';
> > +	*pvt->other_detail =3D '\0';
>=20
> ... so no change? Could you drop this hunk?

No actual change here, but I found it useful to reorder things here
for comparization with the similar code block in
edac_mc_handle_error().


>=20
> Regardless,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for review.

-Robert

>=20
>=20
> Thanks,
>=20
> James
