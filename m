Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF99C56652
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZKMN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 06:12:13 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12106 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfFZKMM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 06:12:12 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QAAUwj026047;
        Wed, 26 Jun 2019 03:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=YU3jEC3revccOEMX97igRP30XXNp1hoKtOmoWJr+cRo=;
 b=twieobuK1kJkrLEQaqIIOtcbLw1Fz7UNuJ6wEsDiO8w8SSlyv0yYxMLEhhPc/izPLuBl
 DeEidhCIFGGqIs3TO7Y8HTGhItKChHLXBNFr1Aq+GFF40ybcG6ks4DCSWcr1fcJxT3Op
 TjTXkDSxO8e71L1HurNq6B9t+dn9D9A8HgFCYRb5cWqmqqCtCsDN+VcydBq5qFPegJIa
 uS0D4ehw/xV+UynKJm1XGFK9fcaGotu+yVEUc32QUtO7zNOu7c3oyAP1RRyt+VmRxb9c
 8P/kwiQxtgebxXN4+x5DIdKMEHITQJ/TmqI9716k0MRvffht/yaRYCAjs6n4B7czTWf1 Mw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tc3s6rp47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 03:12:00 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 26 Jun
 2019 03:11:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 26 Jun 2019 03:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU3jEC3revccOEMX97igRP30XXNp1hoKtOmoWJr+cRo=;
 b=FOin/gDc7+KCVktKYvI8j2k9hqjSgHAUZkCfDuQuVj3ET4NPuvouU0Byn+ym7p6UnTKT5RwgcpJpTtFT94gHN7gZjQBqK6MRnpjt2bDIAFO/u1Vo1T7Wbd9m/f8KvfM1NvrXHNoh8d2+OtqVQbCUXkL6Oov0wIuUbffTePpeaOw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2462.namprd18.prod.outlook.com (20.179.80.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 10:11:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 10:11:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 24/24] EDAC, ghes: Disable legacy API for ARM64
Thread-Topic: [PATCH v2 24/24] EDAC, ghes: Disable legacy API for ARM64
Thread-Index: AQHVLAeVmqlsv0iEmUOCnB6z9FfTpQ==
Date:   Wed, 26 Jun 2019 10:11:56 +0000
Message-ID: <20190626101149.sfhh2nepvqkejoin@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-25-rrichter@marvell.com>
 <a4a99baf-757a-90f2-6172-c1e6814e5e1c@arm.com>
In-Reply-To: <a4a99baf-757a-90f2-6172-c1e6814e5e1c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4318e36-175c-478d-cbf6-08d6fa1eb836
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2462;
x-ms-traffictypediagnostic: MN2PR18MB2462:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB2462D3A3A6E86ADE7D4D5D5DD9E20@MN2PR18MB2462.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(446003)(6306002)(6246003)(316002)(4326008)(11346002)(71190400001)(14444005)(966005)(26005)(186003)(71200400001)(256004)(6506007)(6916009)(81166006)(8936002)(81156014)(52116002)(99286004)(8676002)(76176011)(102836004)(54906003)(476003)(14454004)(486006)(68736007)(2906002)(6486002)(66066001)(6116002)(3846002)(478600001)(1076003)(53546011)(86362001)(386003)(25786009)(229853002)(6436002)(66446008)(66476007)(66556008)(4744005)(66946007)(64756008)(73956011)(5660300002)(7736002)(9686003)(53936002)(305945005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2462;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VHBrABFoRri3ZakkktEmWSFBMhs9Z+yyJXNG8Uh5qt4TK/mR622g9rL2/81nTJnNjaCl3DxtV4BwoboAIkf4V4hZ+azj7Cq2ZaC+p5bVNx+ng9K7aUTeqkQerjFHfk8IaSQazjWDyhyBPkIsTFTkLOi2djZVnMuB/VtDSn64e/ibykD03BKvlk9Ki0idUN8QdWx38Kg5rjytNbbwmxKlyNKKu0sys9jGPf4wU8GAp2oPN9XHExJhRscZztCy2QCtoW0yEIQFt8Tnmxj45p45i+0OKOCe4owYuSAP1Q/LdRTgtlvpFB0MlMZ60LR4Cawtg5xIoZK7TFpX50odsjJsAY9ZU327NRsXt+6zGELraANbYuOHa7rmcL24qxOsMSKgby7IGWGPThonBfP9E1ERhyZ3v1jDVA1vuj5FR+0agTY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9706EA759A6DAD4D86A526BBAE8C23F4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d4318e36-175c-478d-cbf6-08d6fa1eb836
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 10:11:56.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2462
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_05:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26.06.19 10:33:39, James Morse wrote:
> On 24/06/2019 16:09, Robert Richter wrote:
> > James Morse: "I'm all for removing/warning-its-broken it when
> > ghes_edac is in use."
>=20
> Thanks for taking that out of context. The very next word was 'but':
> http://lore.kernel.org/r/c08290d8-3690-efa9-3bc7-37f8b1fdbfd4@arm.com
>=20
> followed by details of the user-space that is still using this.
>=20
>=20
> > Let's just disable legacy API for the ghes driver on arm64. Though, I
> > don't agree with it as there still could be some userland tools that
>=20
> Not could. Are. Someone went and found them for you.
>=20
>=20
> > use this interface that cannot be used any longer after a transition
> > from x86 to arm64.

Ok, thanks for clarifying.

-Robert
