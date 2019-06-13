Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6C44E1C
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFMVHy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 17:07:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43926 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbfFMVHy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 17:07:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DL1NJd013664;
        Thu, 13 Jun 2019 14:07:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=dEdvEBllmQeGshuniz8T1iXrWIbezDJQdVEsc8rkLqM=;
 b=r3udzmK8eZFiLtspW1tx+Ao8B5Mj+61jM1soqPoxHLE+GhfysoMpoXrm8P2Yd5lCnaNx
 T9Dmaz7GA9ReqWwmyvpoUkUE3kRBd41B8Vt3+hbNdTUo8cpe/KQZ/+v/NN9StGGWtwdV
 iRAwjK/B3BMvS9ywarh60ekQJjVSjY4tjfE/FYtjbbBM4h1ev3UdvxzTHFJ2VUvjsGlt
 OqglmQRCjYrbzuh0sJmQsDe57JUTiw7KDjbcNF0hyIxzAY9jEJ4eOK2PuTP8WVh61uJj
 F5AacI+cLTZDptjSmI+O1VTYq7/YZYpNE7zZD1MR/ngvIJCoATxK9Bhp9VTw3Wx9/esr 2g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t3j8231qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 14:07:42 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 13 Jun
 2019 14:07:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 14:07:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEdvEBllmQeGshuniz8T1iXrWIbezDJQdVEsc8rkLqM=;
 b=J3H1NjtCyABXtuVyYQL7M9KVBeiZWSGg54oz1d9xEi6BemC25tuA7+cRsuVw9HRojwGmct2UQOjhY4yK2bG3vnhMwuwkL3skkuTLv6HsAY+uuQwMrvEtuOCpJGUwWLvzZoj60TeQq8NC8F5+8xMrCtK4OE4VuCAh1jxOO+VxJU8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3168.namprd18.prod.outlook.com (10.255.236.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 21:07:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 21:07:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVIiwIYgDDjCA7xkGix+1gH3EzQg==
Date:   Thu, 13 Jun 2019 21:07:38 +0000
Message-ID: <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
In-Reply-To: <20190613191843.GG11598@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0082.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d0fc79-1894-4fe8-236d-08d6f0432a82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3168;
x-ms-traffictypediagnostic: MN2PR18MB3168:
x-microsoft-antispam-prvs: <MN2PR18MB31680534CB7752EB1A8ADC90D9EF0@MN2PR18MB3168.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(39860400002)(376002)(189003)(199004)(2906002)(81156014)(102836004)(316002)(54906003)(186003)(4326008)(478600001)(446003)(476003)(8676002)(11346002)(7736002)(8936002)(81166006)(6916009)(486006)(305945005)(6246003)(68736007)(1076003)(229853002)(26005)(99286004)(71200400001)(3846002)(71190400001)(64756008)(9686003)(66946007)(256004)(73956011)(6486002)(86362001)(6436002)(76176011)(6512007)(6506007)(66446008)(53546011)(25786009)(386003)(66556008)(14454004)(5660300002)(52116002)(53936002)(66476007)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3168;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PSdpSLoixpdPVPo2l+XT51NfhamM8nWBltyIPvbTFYTehujfU6GvTJuDcLTa/sh080sSDKJ7zZ401sgEk99Io7vorfjtjUN8hI+XKIKCzQtAXwU+JTW03QgOAZWJThx+eMxwpUJ7KgXLbx14XVOJj8Gennm51PXFAR7Y8gcNI4kiVQSOP/kXYgoYVHPcQnGuesWbdMrWuinzN2Pj0b3s+3ju2IrAipUmvhqGgCeviv8Cm97CJzKTyvnHhj8Uu3zdR2eZqwzWCbDxo/aflDk0J3fRKQSkGT3AS/44b0wGJbep63hhr3rqCr+ANnCljhugaIPTy2H0OikNlDy4/pCBYg026niDiv0NsWb0frIgUITCocdWv/mHDZCx3/+7qyrvibv2W4XVwT08XdXkkp6ESRCFn2qIr/UTQpsiPBocGs0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F110E6E6F2EC604F84CF7E2C927C6399@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d0fc79-1894-4fe8-236d-08d6f0432a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 21:07:39.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3168
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13.06.19 21:18:43, Borislav Petkov wrote:
> On Thu, Jun 13, 2019 at 06:06:22PM +0100, James Morse wrote:
> > edac_raw_mc_handle_error() prints it out,
>=20
> Of course it does, sorry for not seeing it. ;-\
>=20
> > We could replace edac_raw_mc_handle_error()'s use of e->grain with e->g=
rain_bits, which
> > would also make Robert's life easier when trying to merge those paths, =
but that's a more
> > invasive change.
> >=20
> > I did did it like this to make it the minimum change if it was going as=
 a fix. If we're
> > confident that no-one has-noticed/cared this can be papered over as par=
t of Robert's
> > series, otherwise it will conflict.
>=20
> Yeah, lemme take your patch as is and we can still improve on that whole
> flow once the dust of all that cleanup settles.

I don't think that makes sense as the code should be unified with
edac_mc. It diverges more as edac_mc calculates the grain_bits
different:

 grain_bits =3D fls_long(e->grain) + 1;

In ras_event.h the grain then is calculated different to edac_mc
again:

 1 << __entry->grain_bits

So, this patch looks correct but is contrary to edac_mc. I would like
to fix both and unify it.

-Robert
