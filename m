Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51170105B40
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKUUkL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 15:40:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:22430 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbfKUUkK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 15:40:10 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALKUufu029558;
        Thu, 21 Nov 2019 12:40:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=KS9xqu95gkUvS8DdJboEh6UekXP9i6GdVgGKxoYEk0s=;
 b=Nk2YuJrJFYyce6LgxBYhIOqzkYUE1Udwq7gOYUuT2SgO9bdE9pJxB98ztaL8sIA5AVsV
 XVZIOE651isscTUoY8NUnRgzxeSM8UL7OIevRTFUft+PXtMxBSI7RW9S+BAGSQvL7zKY
 awfwWIHep+VnkhevOUygV34gzZWlL7aUhVHs20POSzIQMZ4keWaiKR0Itrmf+7CTYMfh
 x7YXBWs/kF6OmL4gblb1MwZg4hiFeXxiBYSsGNckSRrT1lZeFsqdfjWGiEq2Nd9H6kCV
 mC6mxz4K78evBxZP8XfNe60NgdKfsFNfFREPKWgZ4mtklXSkYCbhURnGHTaCnxArChhe gg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wc842fp14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 12:39:59 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 12:39:58 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 12:39:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtUpCU56lTB0LuFuU2rWQI85iwFNCcrYGsxco/j4RO4nZeUjpn807xUi+x73445UmGGx0Ob2usKOJeAgiOEATOYjFmrFzmr8puPbz1ZfXn1R3q5h+b4AahEZbzsIu8sULxReFaAyQEuK2juWFwgFAFjUPDwTmKcYz2Lh/WVYaNUV4dbMHCGppQDc1PT2tkpl29NreOTQjLn38ZTpoPfoNYtVo1fiQ3Yj0pl8iq/msWO8gSnaKh8z6B951lwN7KGlio5/INf39sVWX1/jzEKRD1BiXcHRInD7A0Kh15+th+VYsO+xAOakTP+Wiabzd7Ecrh9QqgUxgPVvBzsQHvLE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS9xqu95gkUvS8DdJboEh6UekXP9i6GdVgGKxoYEk0s=;
 b=CGun7cUuxjopz8GbBGvH1dvAnlc/24lM8Zwv6sgPt8/xQQT+etu2gjtq29I/87y/9f71jkTgZnpfuOUNQKo1ku3jvDn/bN5AybqOaOcl1CawWZd6y0n9M4+i7yS/fSpw6FV3WrYRZDqDCM+tQsH85AhQytS8OucncwlHqiTKCBEx/8CS+yMBkysnmHgVNOE02KnYCHOKq9lJS94Ksul+PGsrRup6+41upMLmdQxiA+BMaLo4sGyKJG1UkBJa48uxRX8clDHpt8aq8KFEBxKOVupCvtVLyLJseHr2ruP5n8zp76AGcB8p2aZzLmfMyNFAd+L8UGNpipQF/ebQO/Xi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS9xqu95gkUvS8DdJboEh6UekXP9i6GdVgGKxoYEk0s=;
 b=SOU7xE/PdEeq0ajg409uND3eqX8GazzIUxJ58P2joUyRWEhtbpH7HucVsni1b6RLHeAeVmJrSO6BxzSNSzm9w9NG8IKnszgh+oyg/6n5aY0dcx9FFX4CB8qUziklQxK1DfaM0EBFjY1mocgFgBEj1pXdcxILi7eVrx/2SmxWiqk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3086.namprd18.prod.outlook.com (20.179.21.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Thu, 21 Nov 2019 20:39:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 20:39:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "emamd001@umn.edu" <emamd001@umn.edu>
Subject: Re: [PATCH] EDAC: Fix memory leak in i5100_init_one
Thread-Topic: [PATCH] EDAC: Fix memory leak in i5100_init_one
Thread-Index: AQHVoKvWVQZcsEzFFUKPL+Px290mVA==
Date:   Thu, 21 Nov 2019 20:39:57 +0000
Message-ID: <20191121203948.iean5mucaxiglr24@rric.localdomain>
References: <20191121194043.22378-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191121194043.22378-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:7:28::22) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a21e2264-5862-4d78-e96d-08d76ec2f899
x-ms-traffictypediagnostic: MN2PR18MB3086:
x-microsoft-antispam-prvs: <MN2PR18MB308667F974AE67FAE392A9FFD94E0@MN2PR18MB3086.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(52116002)(6512007)(66066001)(86362001)(102836004)(186003)(316002)(81156014)(6436002)(305945005)(1076003)(5660300002)(53546011)(2906002)(54906003)(386003)(6506007)(6916009)(76176011)(4326008)(229853002)(6486002)(71190400001)(71200400001)(81166006)(9686003)(3846002)(478600001)(256004)(14444005)(25786009)(6246003)(99286004)(26005)(8676002)(6116002)(446003)(7736002)(14454004)(66556008)(66446008)(64756008)(66476007)(8936002)(66946007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3086;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQ4K5yLUuB0oK9mbhpDRopVjTEtn21zJXORPyUR89/uGMKCVO+vANwjUtvWNYFaXGzQyQ1OY/wpTFfuEn5oZTp0A7JQUsvC5E8FV39DCvrmO7g+iozcbUNo9i/ZyN0YSi9YfliSxLLr+EFdN+Hnsp4xt/9CtJ1d8xn/vKAc9JaNsF/iHWP3ubwD6jjdNLNjnLiSR0yvpRwk1Vvat/7MN4bIxnWxmaGQjTfcSHgMDEx+oDamM4OJFNtlAPPVZy2REDvEWTvvBUeueKMLiub9RSDt5zd51Pnd0qBLsEfgSU4pUb1rOW3hPb4iYcSO2tkyvkiv6g0PJ6nj/VieDiy6IPfEuTY3TrHO6rqSUzdziOEWYzIeHELi4LI8Z4rRCCkZFHhUTGLWoLEXpVF2Q4pg2c4C5y7hNg8NumSwJwoGwcjC6e/H4kfDCxtFxClDVcUcD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F12C04ED1491F4DB2F622B56E4775F9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a21e2264-5862-4d78-e96d-08d76ec2f899
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 20:39:57.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLcYC4x0Hbx48ByatZVRg5ZDFeeO+44ldlBR3S/K3uKc8pqHt0n6hjJWQw7blSExvRy40rRpRBRkDzth6SxhBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3086
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_05:2019-11-21,2019-11-21 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 21.11.19 13:40:41, Navid Emamdoost wrote:
> In the implementation of i5100_init_one(), the allocated mci is not
> correctly released in cases of failure. The release via edac_mc_free()
> should be reached by label bail_einj and subsequents.
>=20
> Fixes: 52608ba20546 ("i5100_edac: probe for device 19 function 0")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/edac/i5100_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index 251f2b692785..710fabd5fba1 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -1149,12 +1149,12 @@ static int i5100_init_one(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
>  bail_scrub:
>  	priv->scrub_enable =3D 0;
>  	cancel_delayed_work_sync(&(priv->i5100_scrubbing));
> -	edac_mc_free(mci);
> =20
>  bail_disable_einj:
>  	pci_disable_device(einj);
> =20
>  bail_einj:
> +	edac_mc_free(mci);
>  	pci_dev_put(einj);

The whole error path looks broken:

bail_disable_einj: may *not* call pci_disable_device().

bail_einj: may not call pci_dev_put()

i5100_setup_debugfs() may fail.

etc.

All needs to be fixed. Please review the error path.

Thanks,

-Robert

> =20
>  bail_disable_ch1:
> --=20
> 2.17.1
>=20
