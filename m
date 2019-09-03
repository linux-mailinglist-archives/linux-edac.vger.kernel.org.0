Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5EDA626A
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfICH1a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 03:27:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62990 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbfICH1a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 03:27:30 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x837OKit022768;
        Tue, 3 Sep 2019 00:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Efk2J5MgOPmcY3/DVh3N65stgIi+/twqJ4GYsjYV5Jg=;
 b=KkFpUOcRMUnrt/ngZgaNpgqxhZ5xdkDfEALF/6gPPVFpCeakeR/DkjkR4p6uZY4E2Qxq
 A1ltPkP44xogoBT91+BTMKrlhxzIPXFle2ppSEk55lMuMe5PTpqEvyhklUMTv9+ZgpcZ
 9QFUuTh6sM5J0SyBMPZKZZW6wkE7bbGPVIItXvd29w5B25snGGASLHqM4SuSKMsLdyyK
 /4VmzbYx5EFxyTYHX6YiSAS58YqJxjk6540ZSFXbJyjUQns75lwPf5JzYqvw6zkOl8AK
 b33EpvAhyD9c5oQ2SiUxquDfgO/gBwHJUDKRM3G8uiXewNlILBj02/qb1+6fckJ6Mdt/ TQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p96ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 00:27:10 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 00:27:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 00:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+EiHUxCxY6W6jtD4ri6x4/zd9zloHRR1oqEK7EfRfynyKDVb2makzry+szVy+ueC2lz5wLtWRVYhiAaG+w81NJgkHLc3DSoDw072S5p2AiWzAcOzddpy7vMh4xG1vSJcmr2RyiUJaC0lgqtCht225TXiJROUogkGkyAbYc0XizUPMtDdGsfHsxKesKwsFNQ2p94xl42nlb4kLr7DUJ45fwG4hVYK91lkaEOnBYAweysMExBVfz6AGWnrPwr+9eq44WsYC+02N1lip2aa1MrH5LcYQpMx6DrxwLuQDapbI58KR2lRZ4zQ/FBaXDmiOirJseBJSeqr45lvjjm6dU5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efk2J5MgOPmcY3/DVh3N65stgIi+/twqJ4GYsjYV5Jg=;
 b=DyF9eMEB3NuIt0Lyro26wWjFXcGoCrGvokIgUmtHJEa7gAffc4ahkp2s1ToUsdwcTiTwzNO3qi/6jMjvBDCB/0SsSa4hHtuMX+fKqqtKr00OSejNSn4AZCE95p2vzsaI6ECLphGI+9MZzU1gt8Wwpl2Kid4ZwNCIbwz+uYOrpOPkwGFlctRCipLSSwdE7I+Q5SSiKfGHvvr8K5//eJNAVtX8do654MvR1GT+uMeWfp6MsPABaCjNZpdsyvJyBsv68rFATJEpTSci2Wj+mzC6JMwKwcNufd+siqIxjVNK8u/30ZdMMSCVu9kTQ4EsojzUGl/udMOdNcPQdNdVH/D33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efk2J5MgOPmcY3/DVh3N65stgIi+/twqJ4GYsjYV5Jg=;
 b=pqeYtlD+wDTvjxkR33bnLjFtVT1oQUypbnUgp73vJU+Vt4SG5tCrRt5j3ZfiuTQ6cgXeLjRmNleQW5kpaT71d1rdwTAp7wU20TBt9my0rlSPxdXe8Fz9nvs/XHL0nmYgQeBn3pR6QhsEKEQS+b4dSKF7CxnIrs81qcsVgiVRSWc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3168.namprd18.prod.outlook.com (10.255.236.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 07:27:06 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 07:27:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Topic: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
Thread-Index: AQHVYij8nGN4+uu+F0WgF+K1LGYI/g==
Date:   Tue, 3 Sep 2019 07:27:06 +0000
Message-ID: <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
In-Reply-To: <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0179.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::27) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24387d2d-d7e8-4781-0a36-08d730401f57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3168;
x-ms-traffictypediagnostic: MN2PR18MB3168:
x-microsoft-antispam-prvs: <MN2PR18MB3168DFE3F625187F0A0E4D95D9B90@MN2PR18MB3168.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(47630400002)(189003)(199004)(316002)(54906003)(66066001)(76176011)(52116002)(6246003)(3846002)(6116002)(1076003)(4744005)(11346002)(25786009)(476003)(6436002)(53936002)(4326008)(5660300002)(81156014)(7416002)(6512007)(9686003)(71200400001)(71190400001)(486006)(446003)(86362001)(8676002)(478600001)(6486002)(66946007)(66446008)(64756008)(66556008)(66476007)(99286004)(6916009)(229853002)(26005)(6506007)(386003)(186003)(256004)(53546011)(14444005)(305945005)(7736002)(8936002)(81166006)(14454004)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3168;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rOEEkeKENLz3+dkFgA9C7kvT3qMewZeGoNurtwaT3LUZIWY7OzApKWFwrX0hfzzlNQ8yi2uaSdDmDvKIIFoAzSBom5k6N38X6zbNp8zD2oEP0xmETIl5Ng6gt2LMjrXuMMmgA+LhUIa6oKM8YhuJFApv3pVYJiC8XoAOeQ1uFyON4w4IKAJNp8Gw/juf0ueeBktY8FcTQNoUsqzOg46SWDZ/8tSf1XLOCanol2EIQV0P3RWgFyA3oZdYtwNrEcT+/aWylzq4irMFGE+dQ7sRK6P8T0S9MXfzvDrVztSO4PZW7CpwUniPX7A3Xjte3QPu/4g3N3T4esEsQzRCF+Urt5AgEfuqsCNSUUlNQEj2jlZVFDZZZwBms5k/hIMF6aTu+m7DBdKnKfAS9nux5rToVaxHf+ZzeADu2jLRc3y6Q3Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3759893DBDA27647BD9141AB7D7966BA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24387d2d-d7e8-4781-0a36-08d730401f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 07:27:06.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAM0e5WQnxz0GZzJ//PbJzqrLLGu7Q8l4GexOaQO4iH8UAJw0uCYB4HXy8JJi9S97hIWsSqF9LxcNmNHov9s0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3168
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15.07.19 16:24:09, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> report L2 errors.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  MAINTAINERS               |   6 ++
>  drivers/edac/Kconfig      |   8 ++
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/al_l2_edac.c | 187 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 drivers/edac/al_l2_edac.c

From a brief look at it, it seems some of my comments from 2/4 apply
here too. Please look through it.

-Robert
