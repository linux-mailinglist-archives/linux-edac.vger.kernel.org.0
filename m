Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0992330AE
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2019 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfFCNKh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jun 2019 09:10:37 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52480 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbfFCNKh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jun 2019 09:10:37 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53D9vcZ019660;
        Mon, 3 Jun 2019 06:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mMuYUTXxhkvSa7o3KsMxKIeQkGKVvB/3RaY4YQf4/vE=;
 b=LklHOXvWzRtyoLFcDuy7TATCtPPUPv42MBsIb2GdH5y+cLqHRuvBIuyDy1APvv5ywJ0d
 m3jRIyEqVSRKpSXH9jX+w7vj3zRuu/eD0tV/zCRBAeH+vV8GROAqMRuPCD3Mpf1+HT9r
 5sPQrostqppg7toYE4cXlpuCKlbDRMYgirwgW6LxllI2XwiQdKEzhewR/YXtY8QVQZQ2
 TLwnwdJmXiV0WqSurBPyVPqzJNtQnNOChTVMtQSoFlzBvInVx5ukCfFTbSH9czFfgF/X
 Q6ZuTzdcMMT4l8catNPOW5t5358k43ymUIlDVWYzZxfCFnC2+tvmWdBsdjDVVWPhNu39 tA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2survk876a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Jun 2019 06:10:21 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 3 Jun
 2019 06:10:19 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 3 Jun 2019 06:10:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMuYUTXxhkvSa7o3KsMxKIeQkGKVvB/3RaY4YQf4/vE=;
 b=dAenBoTR+sPZOfoY5a69WaVFe5Oox1qLoZNeoGPArBKEOR9d0J6hOB8np5/5gU2T02Wuk/vepciT+IOhvks3XIW35MeRda501NtdJd4o1d9i8mvuLxybd/pwhH8Brb+qR2eYPuddHv1M2QRsx4FhT/fhl7ILuBFJqRzi+wDKvYM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2927.namprd18.prod.outlook.com (20.179.22.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 13:10:15 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 13:10:15 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Topic: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVGg2utY7ow9FP/UmzxlJzP5JN7A==
Date:   Mon, 3 Jun 2019 13:10:13 +0000
Message-ID: <20190603131005.e23lovwyvii53vzo@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-12-rrichter@marvell.com>
 <37d47356-a40b-2739-10df-f5ab83fa2b36@arm.com>
In-Reply-To: <37d47356-a40b-2739-10df-f5ab83fa2b36@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0007.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.11.168.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68c86029-88a2-4cb9-064a-08d6e824cfbe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2927;
x-ms-traffictypediagnostic: MN2PR18MB2927:
x-microsoft-antispam-prvs: <MN2PR18MB2927AA5F189A6E3E3CC89D55D9140@MN2PR18MB2927.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(366004)(136003)(346002)(199004)(189003)(6116002)(3846002)(316002)(68736007)(7736002)(2906002)(73956011)(66946007)(64756008)(66446008)(305945005)(8676002)(476003)(11346002)(66476007)(66556008)(81166006)(81156014)(486006)(446003)(256004)(8936002)(14444005)(53936002)(52116002)(6246003)(76176011)(1076003)(186003)(102836004)(6916009)(4326008)(71190400001)(71200400001)(53546011)(14454004)(386003)(6506007)(66066001)(26005)(6486002)(25786009)(54906003)(6436002)(99286004)(5660300002)(6512007)(229853002)(9686003)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2927;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vx5D3G6PRGK1CF3kKRzjGvRuTtt7uun+K3UU4VQcl7dMu2c+vW3nvusbsdKcyvEtcQ0PPsYJoirt/Brce4PnJvRlHYiPgBQCP1OtxMPh8YGZqUsKno3fxB4vG9AxUiugisW8O5LpqIhWT6L+0o6m9Y3/anNTVpRDdWPQ6toBgTZIAKWw073zj72A4X+kF5kbFzBUzsDah2hEpBGdMvqSntBXtEbb3g+ZQ5Ey7PejrfgbjWtD3e1n4TiqFfc7g+TKMln3Lu3QnZ+nXr/CkZJ7pGTeVpZ9CV7ILRJiMA+uje9pUkJt0MnFKvUUh8R/J4Df/KOXjoEp/EFjs7GArC+SbyBHnf1Y0LEY4HCApi1pz0fHLw9M8iVZ2ptynJDrZTIeO3bWHGkolEEpr+zJc7YHpY5nQ+DY74YnmLDWaZuczw4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D6DA12C01431747AEA06792360A13F5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c86029-88a2-4cb9-064a-08d6e824cfbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 13:10:15.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2927
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29.05.19 16:12:38, James Morse wrote:
> Hi Robert,
>=20
> On 29/05/2019 09:44, Robert Richter wrote:
> > Almost duplicate code, remove it.
>=20
> almost?

The grain ... as noted below.

>=20
>=20
> > Note: there is a difference in the calculation of the grain_bits,
> > using the edac_mc's version here.
>=20
> But is it the right thing to do?
>=20
> Is this an off-by-one bug being papered over as some cleanup?
> If so could you post a separate fix that can be picked up for an rc.
>=20
> Do Marvell have firmware that populates this field?
>=20
> ...
>=20
> Unless the argument is no one cares about this...
>=20
> >From ghes_edac_report_mem_error():
> |	/* Error grain */
> |	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> |		e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
>=20
> Fishy, why would the kernel page-size be relevant here?

That looked broken to me too, I did not put to much effort in fixing
the grain yet. So I just took the edac_mc version first in the
assumption, that one is working.

It looks like the intention here is to limit the grain to the page
size. But right, the calculation is wrong here. I am also going to
reply to your patch you sent on this.

>=20
> If physical_addr_mask were the same as PAGE_MASK this wouldn't this alway=
s give ~0?
> (masking logic like this always does my head in)
>=20
> /me gives it ago:
> | {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
> | {1}[Hardware Error]:   physical_address_mask: 0xffffffffffff0000
> | {1}[Hardware Error]:   error_type: 6, master abort
> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbee=
f
> | grain:-1 syndrome:0x0 - status(0x0000000000000001): reserved)
>=20
> That 'grain:-1' is because the calculated e->grain was an unlikely 0xffff=
ffffffffffff.
> Patch incoming, if you could test it on your platform that'd be great.
>=20
> I don't think ghes_edac.c wants this '+1'.

The +1 looks odd to me also for the edac_mc driver, but I need to take
a closer look here as well as some logs suggest the grain is
calculated correctly.

I will do some further examination here and also respond to your
patch.

Thank you for review.

-Robert
