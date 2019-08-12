Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4089D8A
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfHLMGY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 08:06:24 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57298 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbfHLMGY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 08:06:24 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7CC0dW0000630;
        Mon, 12 Aug 2019 05:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=g8UGPPQL+Z7HQib+zGHctZgqYyhbQkfxiIsZz5kk00k=;
 b=tMcBup0LoE5pBKBDTKRnAXspeLng8mBT2JBxXbr863YTeeVfiS5/gP4eORrl+DpcWGkn
 oGXbaszHoR9el1zq7N4pFl1C5xLfYspUuD3Zfr3Iwq75+r28Ldf4oyVpXNoX2b7SiXE7
 6h1ZaLWOUvzUzIZ9KYy8L5cM5ZPyHV6Z9X+q3KCDDYCU5tWHoR4WlQZCst9+/jVDEOME
 JGOzXjoDc/M/LMNg3DaUqRL7RzDcf/gD/IjOiHuQPT/pN1AroWOVTDhaFtlimONBfy+D
 cXhRf8vzb0zXGGG53M4r27OnyGbntK0FekhcIsVTTCi8+Mc+1nmZsl/TD1u714a0/jur ew== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u9u9qe8ht-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:06:14 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 12 Aug
 2019 05:05:27 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 12 Aug 2019 05:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnRWpxCuQnxAa1TAQEL6RtPqc3Iyl8JaSEtoHJGfxD6Sbu8LQdPnhOEFzZ8wfNsRHpLjwUN4Kgi595lcWXvqYy8rtueE1mOO0FmIwaFAyvmGjppa0uirtLaVya+yuub1cISQpIzLHKgHhgIN2FeKKozychKjisvzrSK03zKBTZqy6/uQlDRIXFXxJruGutlTaPsUdmPRPEvLWMa+aK2jwCxwoJX7hvFSYovbjNP3vAKXyk7zNMH/fwfFJhoLNBMYAoAIL5+11qRRbi6OrYv7lZ8F2MgbVnUfxh1ta9H2vqMozKNZeZgUvdYYkvhARstTB0z7N8Am2HsLKeibZibwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8UGPPQL+Z7HQib+zGHctZgqYyhbQkfxiIsZz5kk00k=;
 b=W7tzod/wDMHvMsCO7ktahabFMHJsPZq7+djrdrb5S92O7zgVZckTmV+FLIgDMAmnwzHmxreB+mN7+vI896ERshTCQaR2MxJV6QINBlhgWdYXi/NR1Dxy4vhr4hYDOiXhPpSE5wjOXXGSkHf7VvnPS7kc0zT2eQAnCm6qeb8F6KVvZKxQm1KTw9XGOucLuRMd6/VWUZqOGMgeXXMAkTST4qHRzO7X/qEugNtAGDRGPpfy27jFEui4rd9g+qsHkVYFAV66LYQLJPI0G7u9UwnqFVbSKh9GvRfNA5LnCR3dGFzbOrDF8b9OTECDwIVJae59pnpuLKlQyHoQ3QCCjwy2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8UGPPQL+Z7HQib+zGHctZgqYyhbQkfxiIsZz5kk00k=;
 b=tucfsSI5tVARqlaKfxal6o/Ot38O83bwg36ZLWPZYDe/zN2LFmgSovS4Sj8a6ixnKyE8iSzr9AYY6Zuy71X87r2k65kzcQIfcnwjxbtIyxMpLKl0eWW89VYIwLq4URsZxUL+HhPCcJl86Y8IjSLXp15ylIO6jNwunoiM6/Je9dM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 12:05:25 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 12:05:25 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVUQY528Xmn3pGVkWm7FH417vWZw==
Date:   Mon, 12 Aug 2019 12:05:25 +0000
Message-ID: <20190812120517.2kktugib244ujgvb@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-3-rrichter@marvell.com> <20190809131559.GF2152@zn.tnic>
 <20190812064147.5czmkj7e6hxgvje3@rric.localdomain>
 <20190812073221.GA23772@zn.tnic>
In-Reply-To: <20190812073221.GA23772@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90a105f3-fa89-42fe-f3e9-08d71f1d5bb2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-microsoft-antispam-prvs: <MN2PR18MB24800B203BDCB9DFAC82F244D9D30@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39850400004)(366004)(346002)(189003)(199004)(9686003)(6486002)(76176011)(66946007)(66476007)(25786009)(229853002)(6436002)(5660300002)(2906002)(6512007)(316002)(66556008)(6916009)(86362001)(64756008)(66446008)(6246003)(54906003)(52116002)(4326008)(53936002)(81166006)(11346002)(305945005)(6506007)(186003)(81156014)(8676002)(446003)(71200400001)(1076003)(102836004)(14454004)(476003)(26005)(7736002)(486006)(53546011)(386003)(8936002)(4744005)(71190400001)(3846002)(6116002)(99286004)(478600001)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aXrEFN+eA9o0P74qkqOx8qjz/GGkhSt0ghtJkePQW9UuiLOCYZ8hRoKW6llMwuouKd/N9XlwrMnvQS1o9OJWNDmmFnd76N+/AC3/xIF4GEkBLUH/QNcM4ayPz4GLwRRfMUlWz5orogS2OndrTTer0sk0EBbu+7e2qky3atWm8sXIr2yHumIyRlqv1FS0zRurVnVec11b9ZqiTOLN3DXohFo+7mG7/9f0XxHzv4gTfk49EhjWsYuRye5RAcaJIamy2VSmfruyZ3GnE+pq1iL4XUUVH04rp2J3/EFxXdKM1y/jFhmOhYLcl1xQPSmON5/5tPpStlBji7ZAppLtnbunPq5bmZUEIGbx8L64EBnT/Cj3U2DbWeYIBq9qdK/lxhg0E2pOPKnXat9aI3DGfxsMfP7zHd4TNb+LR/DiaYOXz9Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E74C6359FF15E942AA05DEB9CD815928@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a105f3-fa89-42fe-f3e9-08d71f1d5bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 12:05:25.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGu76aKDuK41VVsj2F5hu60dyeRP3EaTI35KHqgSsKMcYBdgp+6dfI094MXW2X57pQ5+9nsxZm3SQHCaNRQMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-12_05:2019-08-09,2019-08-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12.08.19 09:32:22, Borislav Petkov wrote:
> On Mon, Aug 12, 2019 at 06:42:00AM +0000, Robert Richter wrote:

> > With the grain_bits calculation the mask is rounded up to the next
> > power of 2 value.
>=20
> mask	  =3D 0xffffffffff00ff00

grain =3D ~mask + 1

> ~mask	  =3D 0x0000000000ff00ff
> ~mask + 1 =3D 0x0000000000ff0100

grain_bits =3D fls_long(e->grain - 1);
grain_bits =3D 24

grain =3D 1 << grain_bits
grain =3D 0x1000000

So for masks in the range from 0xffffffffff000000 to
0xffffffffff7fffff we have grain_bits set to 24, which corresponds to
a grain of 0x1000000. Looks good to me.

>=20
> Your "trick" of adding a 1 to get to the most significant bit simply
> doesn't work here. Thus:
>=20
> "I guess we can leave it like that for now until some "inventive"
> firmware actually does it."

Fine to me.

-Robert
