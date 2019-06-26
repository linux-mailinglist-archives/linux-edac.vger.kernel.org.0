Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05320566AE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZK1x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 06:27:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47200 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbfFZK1x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 06:27:53 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QAQ44B019760;
        Wed, 26 Jun 2019 03:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=96DnexDK9F6TeDa9RT4B4oGRM+AfEWsL25iCzXnPAmE=;
 b=djHbZymm4hcJW31wI4cLmww/VbMyTzzcFSrdMTWBSA1QfZ0Zf6kEYKoXpSpJxQdKv6yp
 O0y3R/gc9F6Ou182Dj94VGRAyBQa+ie/oJdHFob1tIDP0tuOBQoZGJT7lGxiptcz3FGB
 3Tqk2QXFScqv2nVWHA8MMNUhgL57JDTUxGXV7ZwI0jFxbTeqVGE6KvApTbbSSy8h0YSs
 LcIYPWolqn3f2MelJnhC3kwZNKb8Ogzyxj4cqHNc1MmfteL5/QENdEQPtEyb1X7KzLYN
 VfufC4g/ifXH0JVKBHWNyCnD+r3K86pRDAI60Zfhja0VmwnlaQc9t6AIkm9FmtPdtHfO kg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tc5ht0am8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 03:27:29 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 26 Jun
 2019 03:27:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 26 Jun 2019 03:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96DnexDK9F6TeDa9RT4B4oGRM+AfEWsL25iCzXnPAmE=;
 b=mP4F+W66rrvRL3pyMRN4t9kr51r2/qbuqcjgiU5DX16s7pypMmoUcrkYymDsyokz8kcYLfeS8AmDUPOWV//6QFbbJMdOPHZCEJVMlp6F5tMnJPAk7C7KiP7TTkrjeQc3oN+jYeuWWv/eYnJWHHE9hVd6lZNU3jyJ2noz6e7vab0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 10:27:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 10:27:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVLAm+IqeVzIbdu0GMskes1AJasw==
Date:   Wed, 26 Jun 2019 10:27:23 +0000
Message-ID: <20190626102714.j6kvgx67dsytnktd@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-13-rrichter@marvell.com>
 <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
 <20190612184058.2plbdweri6bjmppr@rric.localdomain>
 <c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com>
 <20190620065527.qqulgpk6k5wva4mj@rric.localdomain>
 <043a14f2-3d08-bc81-3a7e-b275179ec1c0@arm.com>
In-Reply-To: <043a14f2-3d08-bc81-3a7e-b275179ec1c0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0049.eurprd09.prod.outlook.com
 (2603:10a6:3:45::17) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 649bc70a-0dc5-42bd-6984-08d6fa20e054
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2719;
x-ms-traffictypediagnostic: MN2PR18MB2719:
x-microsoft-antispam-prvs: <MN2PR18MB271982F8E64111005BC24E55D9E20@MN2PR18MB2719.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(4326008)(229853002)(2906002)(64756008)(1076003)(66446008)(54906003)(486006)(476003)(186003)(53936002)(5660300002)(14454004)(9686003)(25786009)(6512007)(73956011)(66476007)(66556008)(66946007)(6246003)(52116002)(6506007)(99286004)(53546011)(8936002)(86362001)(7736002)(76176011)(102836004)(6436002)(305945005)(68736007)(81166006)(81156014)(66066001)(6916009)(26005)(446003)(3846002)(6116002)(11346002)(478600001)(6486002)(14444005)(8676002)(386003)(316002)(71200400001)(71190400001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2719;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: daxD60iAMHRZtXUp5YnKNcAEV7FL/8VTYtRxPwOuFpskj4mV9Xfz0hhousRgjbGipO/jP6Bf/9vwvRrxJCMSiHd4A6R0uBCjv+9cb4RTg7fX5HFx1oLf9P49dwHuIQuyrPutvWLtMM/Ygy2amh1nMFs3SISCvCZsQYGODAMmY7DD3GPzPHG0VzuQeSJ4V68+IyhS6KNbliaX9/to5Kd4g3P+A2c1UKfia1gbCJut4Nvnl4kWFcQIwegE8D5ZWjgF80LcvZ69WEo+ABA9L5LAcnPH7NMBCr5+w+jlsKYWhLeD40Spc5+OECWBEsVBodW+Hm8p/r88XKSjmJuT9NxjGx3ECKYF/TEEBrrBJebtFrCyok9Htfe4gg8kuBWCA4soX1HhDMJNOG0+/LepSA5/9SeFOlEq8k02N+S6ctf/rkE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <415CCF16E9D514458BDAECE9BD45193B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 649bc70a-0dc5-42bd-6984-08d6fa20e054
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 10:27:23.1778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2719
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_06:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26.06.19 10:33:28, James Morse wrote:
> On 20/06/2019 07:55, Robert Richter wrote:

> > It is not that I am keen on fixing legacy edac sysfs. It just happens
> > while unifying the error handlers in ghes_edac and edac_mc. As I see
> > you are reluctant on just letting it go, let's just disable
> > EDAC_LEGACY_SYSFS for ARM64.
>=20
> That would break other drivers where those legacy counters expose valid v=
alues.
>=20
> You're painting me as some kind of stubborn villan here. You're right my =
initial reaction
> was 'what for?'. Adding new support for legacy counters that have never w=
orked with
> ghes_edac looks like the wrong thing to do.
>=20
> But unfortunately edac-utils is still using this legacy interface.

I am sorry for mis-understanding you here. I haven't seen your
motivation for this which is now clear to me.

> If we're going to fix it, could we fix it properly? (separate series that=
 can be
> backported to stable).

I see your point here. This is also the reason why I (try to) put
fixes at the beginning of a series to allow backports to stable (or
distros). Clearly, this must be better separated here.

> > Though, I don't agree with it as there
> > still could be some userland tools that use this interface that cannot
> > be used any longer after a transition from x86 to arm64.
>=20
> I don't think this is the right thing to do. ghes_edac's behaviour should=
 not change
> between architectures.
>=20
>=20
> Where we aren't agreeing is how we fix bugs:
>=20
> Its either broken, and no-one cares, we should remove it.
> Or, we should fix it and those fixes should go to stable.
>=20
> We can't mix fixes and features in a patch series, as the fixes then can'=
t easily be
> backported. If its ever in doubt, the patches should still be as separate=
 fixes so the
> maintainer can decide.

I will better separate fix here and update in the next v3.

Thanks and sorry again,

-Robert
