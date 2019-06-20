Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A694C7B6
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2019 08:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfFTG4B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Jun 2019 02:56:01 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30200 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfFTG4B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 20 Jun 2019 02:56:01 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5K6o7cB010947;
        Wed, 19 Jun 2019 23:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7JXRL2K5L9AYRYDK2dzB9z6mZyyDxfN6OcJNeAuqWc0=;
 b=rw4NjlwMJso0Y+8888rlEIKGgBGrba8Ob19Go9L13Gqdw3mUT7JtHqf4m8I0QD9k65Ek
 Qwtr3sSDiGTjL7FcUSsX8SprTMZj3NzmLlVLSrhnugJUE6XaTKcNhxce98nrlDLAybxO
 z0U2/TtRrrjpz7nHzhfTWqTIi+kpa2aPW90emvr7zHZCTXWL8V3wqq6dn+DKFLC/qGvB
 pxeIfzmZEo1g8j94QrozRY3pC2yMca/K4MbLkiodYqrehKLmwBpsqhhsZ2PaDm67veyG
 qSfbR30OJgOMyEPept/c/e5ydlnvIZw03YAwQBqw2AfwUlBWBuHyreIdJjIfDhajX0c5 NA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t7vrk1neb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Jun 2019 23:55:43 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 19 Jun
 2019 23:55:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 19 Jun 2019 23:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JXRL2K5L9AYRYDK2dzB9z6mZyyDxfN6OcJNeAuqWc0=;
 b=gSnWh8UqOLnbHT+vsG0Zoi/THfZfiYlC1R5wGtN5zP5gYGtPmPRFwvA6KzH/c1I3t06hg5pPAx71RsK7LfNKk2WrR666q8EmBkhnH42zVty4DsfcBNJaj8Wup2ogOoHGH2bkhIub9fdFx/kydY8V5rRJi312fAH73o4iyD+l3Ww=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2894.namprd18.prod.outlook.com (20.179.22.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 06:55:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 06:55:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH 12/21] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVJzUqmZqpUctEcEC0DRu/PJtCnQ==
Date:   Thu, 20 Jun 2019 06:55:37 +0000
Message-ID: <20190620065527.qqulgpk6k5wva4mj@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-13-rrichter@marvell.com>
 <92eda11f-dad9-bb2b-3a87-80b6c8d8e228@arm.com>
 <20190612184058.2plbdweri6bjmppr@rric.localdomain>
 <c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com>
In-Reply-To: <c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5537b901-991f-46be-9492-08d6f54c4c2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2894;
x-ms-traffictypediagnostic: MN2PR18MB2894:
x-microsoft-antispam-prvs: <MN2PR18MB28940020696E8F0B02157059D9E40@MN2PR18MB2894.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(73956011)(478600001)(6486002)(66556008)(64756008)(66446008)(66946007)(66476007)(7736002)(14454004)(54906003)(1076003)(5660300002)(86362001)(229853002)(102836004)(6436002)(14444005)(4326008)(256004)(66066001)(81166006)(8676002)(186003)(81156014)(486006)(305945005)(6246003)(26005)(8936002)(446003)(6916009)(53936002)(316002)(71200400001)(71190400001)(99286004)(6116002)(53546011)(6506007)(386003)(2906002)(52116002)(11346002)(68736007)(3846002)(76176011)(476003)(9686003)(25786009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2894;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6sen6QRzZD3JjlZxLRlfGuQctKjwzprgqheM7XnLxDeoMYA7iJ7hQUoMaxo/esWJmJvHCNSR4QV1lHlSQkY9DAdr5fJxbFB/Z/m7qGWTGhRBu243iPWMKZWDvlMHedCSFMi0k2eOY9fo3iMNHxBCIMTh3l2IM0cPc2hHks4g4YHWSxQ1i1S2cYExAkJ8A5mfWlJK4ecoy+wstsw5k9RB6U2wiZUef/H/wr4Ujw65iKJC+wRT5Vl933Kq6gdVITWR1eyJPt7nqen/jvbOTrc7P1U7SnmVoFrdnVBOPoZOUIlpj+FznCPxajaXuXcF+unD5iSd2VrZ0HYhnN9c/B+hp0t6FDBNfW2nuYvxU8URoakso5BV0k3QzofYbJAlUB2MrN47G0gLgxd0Zk9N3KbGnIDxe3GhZrnN+Fpa2p6v21Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88686D4A14A84447A87C3F7A393709FA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5537b901-991f-46be-9492-08d6f54c4c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 06:55:37.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2894
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_05:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 19.06.19 18:22:32, James Morse wrote:
> > In any case, this patch cleans up code as old API's counter code is
> > isolated and moved to common code. Making the counter's work for ghes
> > is actually a side-effect here. The cleanup is a prerequisit for
> > follow on patches.
>=20
> I'm all for removing/warning-its-broken it when ghes_edac is in use. But =
the convincing
> argument is debian ships a 'current' version of edac-utils that predates =
199747106934,
> (that made all this fake csrow stuff deprecated), and debian's popcon say=
s ~1000 people
> have it installed.

All arm64 distribution kernels that I have checked come with:

CONFIG_EDAC_SUPPORT=3Dy
CONFIG_EDAC=3Dy
CONFIG_EDAC_LEGACY_SYSFS=3Dy
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=3Dy
CONFIG_EDAC_LAYERSCAPE=3Dm
CONFIG_EDAC_THUNDERX=3Dm
CONFIG_EDAC_XGENE=3Dm

> If you want it fixed, please don't do it as a side effect of cleanup. Fix=
es need to be a
> small separate series that can be backported. (unless we're confident no-=
one uses it, in
> which case, why fix it?)

It is not that I am keen on fixing legacy edac sysfs. It just happens
while unifying the error handlers in ghes_edac and edac_mc. As I see
you are reluctant on just letting it go, let's just disable
EDAC_LEGACY_SYSFS for ARM64. Though, I don't agree with it as there
still could be some userland tools that use this interface that cannot
be used any longer after a transition from x86 to arm64. I leave that
decision up to you. Please just ACK a patch with the Kconfig change
which I will add to my v2 series.

Thanks,

-Robert
