Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067BB454C4
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfFNGc7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 02:32:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37058 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfFNGc6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 02:32:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E6KM24029000;
        Thu, 13 Jun 2019 23:32:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ZPkGyef64mIinplWDTVx6IsmydpbuIza7O1RzGvOwjc=;
 b=t3FZRhePvhhjcJoLVRm1aHtqGn2e69F/lIHXAY0DAMSCCSjjxtwNruPBE1mDWGgoyzaT
 0L7qd85/WryY+MncmglGY28iAE99eVn/po8jK4F8GLQy0PjX0+qdGsACyhonFVT9L/HS
 54dMl9/gvQVURy/15WWxk/0HqJrt7rgKsPdf8k9K9+C4YJTgkGyLweMxVGrEo/XHbgA+
 U5a7mVMl7P/Nhmp+FvuwvvtQg+dIcLBfcgnY9v3V9G5n9rEZMs5rIN0XpxCdGwONEXBR
 goyCzdzmhJCOXjre7JA8ZHfZLqJUZjPrJe+qg1v90m0cCS8gbXFv3UqRT796SX/cciS/ tA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvpvrf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 23:32:46 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 13 Jun
 2019 23:32:44 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 23:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPkGyef64mIinplWDTVx6IsmydpbuIza7O1RzGvOwjc=;
 b=iXT/a2+NfjpQ4GUokuKtPhjNO54WlxSb1zUU8NadyrHobGuPHOvUbVWYO8CO7yBPsXVZbE89UAOvDIKoObkS0UW7UUVPFJ42nJ3v+fP6jgdRNbtoKMZ+v1SJ/d3fHeDiw9FnsV8zH6QmcBH/QgK6NPaTd/QPTxDAobage4HGmpU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 06:32:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 06:32:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVIiwIYgDDjCA7xkGix+1gH3EzQqaasYqA
Date:   Fri, 14 Jun 2019 06:32:39 +0000
Message-ID: <20190614063231.rsb7ftl6uevmccky@rric.localdomain>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
In-Reply-To: <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5f157ea-4d14-4e61-2855-08d6f09218c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB34370297AEA3D92123548B5AD9EE0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(52116002)(6246003)(86362001)(76176011)(68736007)(6486002)(14454004)(6436002)(71200400001)(316002)(7736002)(71190400001)(2906002)(6916009)(53546011)(386003)(478600001)(6506007)(966005)(25786009)(8936002)(4326008)(8676002)(53936002)(305945005)(81156014)(81166006)(186003)(486006)(6116002)(102836004)(99286004)(256004)(5660300002)(66066001)(73956011)(66946007)(3846002)(476003)(64756008)(229853002)(26005)(446003)(66556008)(9686003)(6306002)(11346002)(54906003)(6512007)(66446008)(66476007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4D3oupNiwgz1lnCKoQB1V0/KtoNrtMiySkuq+EpWfGC1SCrDDxG4M/FOH15A6suSFDmr1EwGxldA9TtPwFrD3ivRJ8TGd4LDznqwfKcvPbRzEBPnGpqroXnlhurmo+UmiyhcizBvOPTc/a/SUPsIHP9MYfoWWm+yKlBARuvuTGGxwOuLXbK6gTHwDySQAr3fHVNeL0PEUFkbKLvi3j7AJLl0awCI0JYyQ7CVpEybfLTivmVu0ByzVXrWcwYtycaKLmuitCOXGI/W9eYibG3W2XB0y7lLQLAnf2ef7MObjZY8pulCKd7d1J7Swjoqjefu+5gna4YLhkg/G7SEGZhUsDEZNrVJQ4rBVPWuDuDzBPsS+abX+Q0xRthVZ65F++zaTOV85we3xDJ+m66gxwXzmI+xee7zgKirfCJ41jcXHPQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B98BE6B186129E4C906D536627ADE5B1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f157ea-4d14-4e61-2855-08d6f09218c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 06:32:39.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3437
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_04:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13.06.19 23:07:31, Robert Richter wrote:
> On 13.06.19 21:18:43, Borislav Petkov wrote:
> > On Thu, Jun 13, 2019 at 06:06:22PM +0100, James Morse wrote:
> > > edac_raw_mc_handle_error() prints it out,
> >=20
> > Of course it does, sorry for not seeing it. ;-\
> >=20
> > > We could replace edac_raw_mc_handle_error()'s use of e->grain with e-=
>grain_bits, which
> > > would also make Robert's life easier when trying to merge those paths=
, but that's a more
> > > invasive change.
> > >=20
> > > I did did it like this to make it the minimum change if it was going =
as a fix. If we're
> > > confident that no-one has-noticed/cared this can be papered over as p=
art of Robert's
> > > series, otherwise it will conflict.
> >=20
> > Yeah, lemme take your patch as is and we can still improve on that whol=
e
> > flow once the dust of all that cleanup settles.
>=20
> I don't think that makes sense as the code should be unified with
> edac_mc. It diverges more as edac_mc calculates the grain_bits
> different:
>=20
>  grain_bits =3D fls_long(e->grain) + 1;
>=20
> In ras_event.h the grain then is calculated different to edac_mc
> again:
>=20
>  1 << __entry->grain_bits
>=20
> So, this patch looks correct but is contrary to edac_mc. I would like
> to fix both and unify it.

See here:

 https://lore.kernel.org/patchwork/patch/1080289/#1284056

-Robert
