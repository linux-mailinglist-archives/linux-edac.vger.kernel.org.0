Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCAA6261
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICHZK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 03:25:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58782 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfICHZJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 03:25:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x837KmGe026204;
        Tue, 3 Sep 2019 00:24:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=sWrPAKzBIXHRFhlW5jGDG1z0ggAoso++r/pqeEBfrjk=;
 b=GmE8A+tTc1BLMSC2bJKkeaqI/8Svwxz5A2hwQBUzHqPueteRMzG50kEVJ95AeDraMaxH
 MVsSZHDtZI+5/op3DC1C4uVeln2lK1EsxVIMmLiJD3cPjjdNmNlC/15vVaj3mYFMdmld
 TPW9eNRkbrhZkO+2lVds1nwcba++8GlNh8uMnDGMnIq/n6iZu3zUPKiKkn4a8RfaTIU2
 QdLkFPdUURhRtGSouRrExkra4rMfvDFmDcni3PoTTCGxe8cx22WlYRFw9xb5PPPMYl6C
 SMEPukJEJF9NwQs9gi2tykviG9yWQuSDOAYAvp2KvuIvLehiFk4pwwcJBxux/AT3mr4V Tg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm8jfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 00:24:41 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 00:24:39 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.58) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 00:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwSF7Y2eQu7FnOmEjOUK9XMpZVEgIVI5I7v0DaenpRH32Qd7egHx27LQuJNpNZqhjUsd7PueUZkOENi8Ejv8XQB9Pu2BiuHfi8zr40t1TlsZbZZivrL+mbeU7HsZAlnvranhkoj8WIZ7Zca5yRLJOkkcAnol6GaNbIoErqwampEO6WRuurHKQQTM4zyzMAqYLUbnqc3+75J/9tgfwoae9rG/c7zHHxMJSR3Hp0vRSPsREhITP4i33anG/myeK177lJg1JtrToVdHLfpB8zTSitRDkstOq/rtkSLRCEgmxck3dCMRZ0wvu1vrQ+GzSNgxX7coDrWYz4Hs5XNtqd1Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWrPAKzBIXHRFhlW5jGDG1z0ggAoso++r/pqeEBfrjk=;
 b=iR2xUPSpJWva8zpowFUx04e/STZSEU78sd7YXZvRlx2++t1U17sEjn/O8MYzL9iXggM2BkCW+taFOutJr3EJnqgThP2kPNJ7B1+Nb0yVh8wDFcK/UIIxeEp99uUb04aN3uDZDqkulQmvmB0vWoeNepLPWiVd4x7CIzQ/Ip8hDArtNagbpzhgrp1n6GEu+QRSrpnK8A2CRKoZypnv8e369z5dS4soO4dvyfCzyZo17pxN2S3I0swkb0pZKwf6UWDsztdNJlbDpOxXOx1dO2OO68Ba948K9JC1OD0kE0g9dP+ztt9Q9kfIxedOkH0KMBbIkiXx8W8Bggjtg6NQ57Ejcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWrPAKzBIXHRFhlW5jGDG1z0ggAoso++r/pqeEBfrjk=;
 b=hRxQNI6egaJVzHtgwlgKFX32LfRjC7261g+dMKZ6rCooIa57+tpdb5TmU5G+Vj5InGxlUz5lbra+lfW+mDi8pHnE7S8xwIymPEOWVlENpbr9Zd5Vyh3PUkDXVwjAZF/DxnVWVrxa51jiqC8TRjgmDXbPSiZVlgiflzotKIYCdpA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2671.namprd18.prod.outlook.com (20.179.84.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Tue, 3 Sep 2019 07:24:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 07:24:37 +0000
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
Subject: Re: [PATCH v3 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
Thread-Topic: [PATCH v3 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
Thread-Index: AQHVYiikjHh0cNrh/UmCkhYftSiSCQ==
Date:   Tue, 3 Sep 2019 07:24:37 +0000
Message-ID: <20190903072427.ptmde6hda5uyauhf@rric.localdomain>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
In-Reply-To: <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b54aca5-1042-423a-450b-08d7303fc6ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2671;
x-ms-traffictypediagnostic: MN2PR18MB2671:
x-microsoft-antispam-prvs: <MN2PR18MB26710E8F1062F3DC971E52FCD9B90@MN2PR18MB2671.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(47630400002)(189003)(199004)(6506007)(7416002)(6246003)(102836004)(186003)(11346002)(26005)(478600001)(71200400001)(71190400001)(305945005)(256004)(66446008)(14444005)(476003)(9686003)(64756008)(6512007)(7736002)(6436002)(66946007)(4326008)(446003)(386003)(53546011)(76176011)(25786009)(66476007)(486006)(14454004)(53936002)(316002)(6486002)(66556008)(99286004)(1076003)(229853002)(54906003)(3846002)(6116002)(2906002)(5660300002)(81166006)(81156014)(8676002)(86362001)(8936002)(6916009)(66066001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2671;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vtg0WEJUVS3kx39oz4gggeI/ghGWEYEODrp32tDC0TJlwXm2lTeSxNfepsMOap8Y+iwWv2iY5NBc5h8Zy+CgDP+drPm8XAUsFQ0Zkdsi3EUKgMyNfc9ZW4Z/ELfA6uO7+efBrji62ESGz2uk7MPtAiRodshy6aBpbBtqIR82PyduAsLxEjYOiAIe3mJLctZpjumkK8VHjFZ69jMXoIsAQHRyluEvhVEPNl3sDCNgmAnipeg3ClfPUDzLN6aPaA84wVU96JUg7Q3BICu8QsjPR1IV99CGzI4EDHiHlFCgPfy8SO5Olij/M9LOpQLhwkE7jG44FKKpKXp7daMYGN8SitwxuxTJgi3M7GJSnCrLGrPVwDcq4maaZ0r9gGk7IQUuse3GBRmG7d037V+rSZBwnjMouz9sgf3tvJJwqLNfrRU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B46B4A6D16D864F9B87EBC3ECDCB3DC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b54aca5-1042-423a-450b-08d7303fc6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 07:24:37.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uw6mBrOu800wW9obrnEwusR/GAJ6WRmEol2WmEfpjUjWvk9zOgBmt/LHVo8+PXBeUW7utK4TdbBLQGsaniMDYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2671
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15.07.19 16:24:07, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
> report L1 errors.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  MAINTAINERS               |   6 ++
>  drivers/edac/Kconfig      |   8 +++
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/al_l1_edac.c | 156 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 171 insertions(+)
>  create mode 100644 drivers/edac/al_l1_edac.c

> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
> new file mode 100644
> index 0000000..70510ea
> --- /dev/null
> +++ b/drivers/edac/al_l1_edac.c

[...]

> +static void al_l1_edac_cpumerrsr(void *arg)

Could this being named to something meaningful, such as
*_read_status() or so?

> +{
> +	struct edac_device_ctl_info *edac_dev =3D arg;
> +	int cpu, i;
> +	u32 ramid, repeat, other, fatal;
> +	u64 val =3D read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
> +	char msg[AL_L1_EDAC_MSG_MAX];
> +	int space, count;
> +	char *p;
> +
> +	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
> +		return;

[...]

> +static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	on_each_cpu(al_l1_edac_cpumerrsr, edac_dev, 1);
> +}
> +
> +static int al_l1_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	edac_dev =3D edac_device_alloc_ctl_info(0, (char *)dev_name(dev), 1, "L=
",

This type cast looks broken. dev_name() is a constant string already.

Other drivers do not use the dynamically generated dev_name() string
here, instead a fix string such as mod_name or ctl_name could be used.
edac_device_alloc_ctl_info() later generates a unique instance name
derived from name + index.

Regarding the type, this seems to be an API issue of edac_device_
alloc_ctl_info() that should actually use const char* in its
interface. So if needed (from what I wrote above it is not) the type
in the argument list needs to be changed instead.

> +					      1, 1, NULL, 0,
> +					      edac_device_alloc_index());
> +	if (IS_ERR(edac_dev))
> +		return -ENOMEM;

Use the original error code instead.

> +
> +	edac_dev->edac_check =3D al_l1_edac_check;
> +	edac_dev->dev =3D dev;
> +	edac_dev->mod_name =3D DRV_NAME;
> +	edac_dev->dev_name =3D dev_name(dev);
> +	edac_dev->ctl_name =3D "L1 cache";

Should not contain spaces and maybe a bit more specific.

> +	platform_set_drvdata(pdev, edac_dev);
> +
> +	ret =3D edac_device_add_device(edac_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add L1 edac device\n");

Move this printk below to the error path and maybe print the error
code. You do not cover the -ENOMEM failure.

-Robert

> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return ret;
> +}
