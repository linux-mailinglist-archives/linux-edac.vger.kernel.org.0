Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4800B8B34
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2019 08:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437426AbfITGmX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Sep 2019 02:42:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49672 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437403AbfITGmX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Sep 2019 02:42:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K6eoUc011977;
        Thu, 19 Sep 2019 23:42:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=B+zvqKx38jbpkiB6iH65mT/csKiQIoctEdj4BwINfKo=;
 b=ZPi0iS9h1sew8BMxg0VoX6+AleG+J3TsUEZd3s27BAqGgyUffSD89J54W0nYADhGBIJn
 0S5MO1+csckLh6r5Q8CtpIa/ZDX8YbpPiVOuqWMaW7IqvvFxOkhee+1E8W91KRMn7tXJ
 ZyaE77bMucidkwjSuhDqbG8Ufe6usYoh+PK0CUm4T3xOqKk0JqOgbLf5F5BukdULyTJn
 a9bqXzmu9CfdIzHDBv17rT8mMcyu9XFrOwURG4sA8/d6butx722kfAIdI9Ko10X6cHxn
 vQRhbnsvqJ3wVKQQyUFMkoqtn0ShS14PNRcF28QwKQKDEPGiOMXPe675c9u4ILqVWzQU Uw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v3vcfpy27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 23:42:09 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 19 Sep
 2019 23:42:07 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Sep 2019 23:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVht/ZTygTp9ixOdYXSmWxCb+wGudVKGFbHAWfy+z8fsSgzKAtsSEgJmqztvAEzB6mOhQ/lb7kb7LaWL2Pw4w9ntr1dMSmk0B41yiPiJsUsQF3nUB7zyEXG73UCrzXOD3QsoUPRt7rIzPTnB+TO9PDUJNZGaDwf1NPb58tqYIB0mJ9ej+mWwu7j9WDTXQdSJGbq1ki7Rvh7IE4HFq1N/MhRrDbhQ67fKYM61AJT1se3uDLrdgufBSuYcGZjz+MlZemr3L02MXKkvD2nUWiM7t9sj3Iw6S5dD/AqGBEi+hXbtVEfvEQ9H046OvNRnmx+HjBAX/F0+yxWfHIAzpMNWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+zvqKx38jbpkiB6iH65mT/csKiQIoctEdj4BwINfKo=;
 b=Q2yDyPQETLNGm7iyu8fJIwFqlSsOK/S9WJzQ/6WpwxmrYVfDP7UzDsgqTXOKMJCdEzD58c1JyvOun4EORtSUtwHbYflhVLdRVM+IEcwyewtf7KaxUokSAuTFGVdfSNSGilKT9hdgowxbPcJAglGqKiF86J3M6botSoFMJ3ZYaGbwy3g2Z+zM2NRxk15d4GdaJn5xOW3oyUX03fDbH6visMUsky8h7owYK6Fy5OOL7jFYeYEsBaSbAeBgTzUahi11uOlWCr7I1KClbWj9u7kn0TNL6+fOYkkhjwVkwwzQ+E8KBngnQlnXU34iGNaaZrSGrQr1G44BQpMLGNal7+4OVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+zvqKx38jbpkiB6iH65mT/csKiQIoctEdj4BwINfKo=;
 b=Ys3m/lxP2VyFuv44bpbjQfgMjSk1flByl2suwQbfIU5eYnIaIeqSsG0kCk+vsdC0KcY5ZdvZ3iK5jicoapZSyEvPVPtUPfG/ccA9bp6kcl3AV1y6DkwVP3sS3CZnppOlG2/yOWeN2fN50Ihd0y52fTTR4ic6WvGlNKyXL//0duE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2799.namprd18.prod.outlook.com (20.179.22.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 06:42:06 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 06:42:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v3 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH v3 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVb36EykX7q7YxkEG2nId0bF/CGQ==
Date:   Fri, 20 Sep 2019 06:42:05 +0000
Message-ID: <20190920064155.f3xeqzobiud5hvxf@rric.localdomain>
References: <20190919171713.8060-1-hhhawa@amazon.com>
 <20190919171713.8060-2-hhhawa@amazon.com>
In-Reply-To: <20190919171713.8060-2-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a487e78-7b85-430f-ee1f-08d73d95a6db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2799;
x-ms-traffictypediagnostic: MN2PR18MB2799:
x-microsoft-antispam-prvs: <MN2PR18MB2799C5A2B4E39831993CC191D9880@MN2PR18MB2799.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(6116002)(66066001)(7416002)(86362001)(3846002)(4326008)(99286004)(229853002)(8676002)(6916009)(81156014)(2906002)(54906003)(8936002)(81166006)(316002)(66476007)(66556008)(64756008)(66946007)(66446008)(5660300002)(71190400001)(71200400001)(11346002)(476003)(6246003)(446003)(6436002)(486006)(6486002)(1076003)(14454004)(478600001)(53546011)(6506007)(386003)(102836004)(52116002)(256004)(76176011)(186003)(7736002)(305945005)(9686003)(6512007)(25786009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2799;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y8f2lAqpbfKhICf9b9IyfaYvKYgw8exCm6McnRf7lsQXgEfS8XMTAdPNI8Ag81B9Bi/rKauZapfo2GEU3/244MMYg3fJPOiWNHMUG0taRm7rOTqMwy1oO1iPnXVgO7unvdLQBK7Ss+GwYxJpgz5OMoxwETfVxu4rckb6Cp4+6b5BKJHz21clyyOTOZNqzR2uErygxDZnc+03PYjiWTFPTmjblT6B8x7dULgm51qXmRWYWKt7cfsC9ex1z9/4RYJ7AM8s2KLA3JBZHURLxD9v0gufI7uKFOsYBrP6imRhc4opZMVoOhWHuumTNjoow1A2bDlXf1nOUS/JczY6X2tyqegWz6sXLZa77XkSz03sZyX4SJrq4Kxc+w9AezMdnneAhUBaQQ0kOefQofbPH41x/ghVfJ3mYWigtF1n9k1sg6E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4643F7B24759F747990E32FE51562174@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a487e78-7b85-430f-ee1f-08d73d95a6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 06:42:05.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEpZZYuKKAHmMD5uqHvqF5lmiyEwQ0LvSuqiVKbbsO/QqcEvZW4F2zYn8+NxcAMYkml8uHV4zjlvGYUJeYybQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2799
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 19.09.19 18:17:12, Hanna Hawa wrote:
> Add an API for EDAC device to report multiple errors with same type.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>

With the change below it looks good to me:

Acked-by: Robert Richter <rrichter@marvell.com>

Thanks,

-Robert

> ---
>  drivers/edac/edac_device.c | 62 ++++++++++++++++++++++++++------------
>  drivers/edac/edac_device.h | 40 ++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9355c4..866934f2bcb0 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -555,12 +555,16 @@ static inline int edac_device_get_panic_on_ue(struc=
t edac_device_ctl_info
>  	return edac_dev->panic_on_ue;
>  }
> =20
> -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> +			     unsigned int count, int inst_nr, int block_nr,
> +			     const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block =3D NULL;
> =20
> +	if (!count)
> +		return;
> +

Those checks should be moved to the *_count() variants of both
functions.

[...]

> +static inline void edac_device_handle_ce_count(struct edac_device_ctl_in=
fo *edac_dev,
> +					       unsigned int count, int inst_nr,
> +					       int block_nr, const char *msg)
> +{

	if (count)
		...

> +	__edac_device_handle_ce(edac_dev, count, inst_nr, block_nr, msg);
> +}
> +
> +static inline void edac_device_handle_ue_count(struct edac_device_ctl_in=
fo *edac_dev,
> +					       unsigned int count, int inst_nr,
> +					       int block_nr, const char *msg)
> +{

Here too.

> +	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
> +}
