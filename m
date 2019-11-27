Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276A010BDB7
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfK0Uyn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 15:54:43 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6840 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730862AbfK0Uyl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 15:54:41 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARKpI3j003192;
        Wed, 27 Nov 2019 12:54:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1d0LFJkeyE5NppHnagEy72vdwuyCl21k5W5s7dT9yAc=;
 b=X7zFzPXIaEdbvNjLBuznVHZKe9omNcT/uZqln8jhMwSmPqbd09xcwufCqqfQMiUv55xu
 CBZIisoahn0DFhEetuXFwyQIHFJ/CoOrhFu5ptNFXfTD37liZYZTQtAZmgNkuive2jIf
 u4HOoZpPST+0cyR8NcCxEaH2bu/H4w6nGOPKKwyqZhiN4tfGYCmv3vA8//gjHgSrG5mX
 JGpQ1HvOvzuDzoeCe0ZHiHYZYbBNvktR7Mb5vlrHKlw6Uvb+UrKtRQz1ZfCT8M3cQokZ
 Um7uAIP5dBuUtrvkbMBjzFKDurcgLaHMyARF7CaGv1FRtxBCy8/pVMOk8CKaBvfTK7uH nQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyay6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 12:54:14 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 12:54:13 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 12:54:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBGr89TWuPl6vlE+NqHqEC4cVvi/KJOGpbrbk13z/qLsVRiZovUeci3nPFpVsHM19D5vBtYhxoBPE5tHhnPsFaW6ckAuWbTyIqxkRqiEbKW9lvRyPquVk02X1CdsigFDFaMOjx7Qa1Lq6SRa+ff6cQDggnrTnJZ7KmgrN2t+sGmmRRek89SR/DhdpraXFJU1Dw5coGFz4QgrSYUM3o9TQURvy9VUfw+e33b5mmCv0kA+mTPnSkPP/98ZM9XiXaaujPqfGV3+Z1/6G2mVqWEb9IfnEXEfYYuXFQUmXVVmoTE18bq3Plir8uKXyeHnfoCBQeLSUVHvVEqklN3tWoPj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d0LFJkeyE5NppHnagEy72vdwuyCl21k5W5s7dT9yAc=;
 b=aiLCvcA0iFTdzQqPdWo5e1e3h+Iy7g0RetUwVJxAAFoQUnkVJMybgZ/8UF9f6a0QC4lPBiU2+IS0dF2HmLYnnLQOCOUPUwU8oqM+OMUBhbeVCT+iz7nIYqJOTxJURg4Cj4zLlrxdQWdAKQi2uQbgPxthFWpLOP01In1W8G1EAaKKcgSNq4PW6qQura5Op1Uk11log3rVDJOxPPfksEfi32cNagTVo73f8qcd0Rc1NMLFFGGiRjBdN8n+7z8n+LtsNK9ht0UFqGzU/o6pXZzmKA15hKSmwdEZ/V/86eI91tlZB0CLyGi1+5F6UTzl/0g2H5x8fkML5G+FJNQdhuZXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d0LFJkeyE5NppHnagEy72vdwuyCl21k5W5s7dT9yAc=;
 b=qwkVc1j+ucBNsD4ZMW5GD7vdicdu3DmssYvQoVlJKjxTroUBcm7Ecc/xQjQOi96jZ+T9LEzopf8tnT9Zh8SXdsGIslghXfqTyZNOvT3cyaA1pRRV1cpEcS9Hrqz7WGtSOrC9EyywTA25ys6cL7UrGoaIut7la9fh+WLqr8d6BZg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3246.namprd18.prod.outlook.com (10.255.238.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 27 Nov 2019 20:54:10 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 20:54:10 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     John Garry <john.garry@huawei.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Huangming (Mark)" <huangming23@huawei.com>
Subject: Re: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Topic: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
Thread-Index: AQHVpWTR2gZqHUZXukW6XQHUnJa5QA==
Date:   Wed, 27 Nov 2019 20:54:10 +0000
Message-ID: <20191127205400.cip7hdbhcdokofel@rric.localdomain>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
 <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
In-Reply-To: <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b518bce-3b06-4d0f-1d9b-08d7737bf36d
x-ms-traffictypediagnostic: MN2PR18MB3246:
x-microsoft-antispam-prvs: <MN2PR18MB3246C4B8C8FF569349A14933D9440@MN2PR18MB3246.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(66946007)(229853002)(6486002)(66556008)(66476007)(99286004)(66446008)(64756008)(5660300002)(71190400001)(14454004)(54906003)(7416002)(6916009)(25786009)(305945005)(256004)(71200400001)(7736002)(558084003)(478600001)(11346002)(1076003)(2906002)(81156014)(8936002)(4326008)(66066001)(81166006)(8676002)(6512007)(9686003)(76176011)(316002)(86362001)(6246003)(6436002)(26005)(102836004)(186003)(386003)(53546011)(446003)(6506007)(6116002)(3846002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3246;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVT2fP5rY8QbpoznHvfHph9kNG30SH4jzQcbaOrRlPM6FQZfS4OZ4XlRMYZ5U3FK8sO5CWFTEJ7HoDF3pxY94h8ESeOJvqgu+amElgG4gsaCzKlh9uJpMQiThCzlJTXsHgHhzfrjlXsnI/VypdEggYuarbiUFsLxUCvkpq7EFveNjjiq8u5dUAT/2qBlgLWWk1Qb9uaEuXvKZsxXA7BrmMGwnNHX65QSrtOjGnmlF5nPrBiLi9Uwq0LSreerL44vAAJ8sybYyVK1IpQ9vUuVzAGDhJyN4v2rU8Gpep7or8O0SupxdsSBdG56NO+q9NeZtfpJLwS8XloQZtb5AvWnjX9o49H8ksPZauzTFqYrl3ZqHaVqnfpYzIwLtcc5Lh2JagkbaYhehTfek0p0z/rp6o6eUyDlWSp1jCVfiAyIeZhSWqrrrFljh3hvyal0+1cx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2881E330720F714F9B52D725214E008E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b518bce-3b06-4d0f-1d9b-08d7737bf36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 20:54:10.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5OdxyTu+Sqh6Ae2mAjLvl+LFqhAIdW77zyIJyeH5Ehm/sYGBBRwGUIGLbIM+nB4jglCAtVU2mlGpUcP5Mz4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3246
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi John,

thank you for testing.

On 27.11.19 17:07:33, John Garry wrote:

> [snip]
>=20
> I have test enabled:
> +CONFIG_DEBUG_TEST_DRIVER_REMOVE=3Dy
> +CONFIG_KASAN=3Dy
> +CONFIG_DEBUG_KMEMLEAK=3Dy

Is this a regression (did it work before?), or a new test that you
newly run?

Thanks,

-Robert
