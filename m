Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0103A9EF8
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfIEJ5M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 05:57:12 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38224 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725290AbfIEJ5M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Sep 2019 05:57:12 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x859tpAE018195;
        Thu, 5 Sep 2019 02:56:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=UTDlhxfBr2FRYV4DdhoZowXYS0/D8i5V8jOhiXsuEHE=;
 b=gJ0WkdHsy/GW2BGLGXqxQWEpTNyLmgmXq2wQE4rgV+kA0RPc/bQXm7D1BANctyY1mPc3
 FD7SVR9aO7vGW3WsSw08+JB0zdSy3V8sdhS/rTby3RBuNr2xSbicorvTmdtK4XjxDole
 XuI9yjbp0cZtJoZqUHm+Ut2pGVuL4bmJ8xj55Zugv2yJuljHOit79aSQvnDQohkB3QzK
 AISX+8TFG7vNdBc5LDJvmeaD5XPxhsx6H/YO2Na6/muMc5T0hQ54sNvW7u1wN5Kelf3q
 xPSEkpTGY/rTBn7ORzZgR8Sj70LxtgiMIESQdBMBmis6qHQnr4m9lPfcWT8tWtLsMvlL cQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8pjtgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 02:56:55 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Sep
 2019 02:56:54 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Sep 2019 02:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHpj75B/CWMQrh7g5IK02G5DzLNDoCOk5nwUOfYK8EkKwEhseEggtGn5KFYT4OooUBRfnwg20JBjuj6hplpbznyBwlCy7n5vQLDdVxLa4DyyDa86qjUjmtFBtskMb5RRkZOVdvrUA6HPB85Yu5rXt/pIvz6kwDb4iWV7DxpgFIdmUaVNSXJebRPp+BgLzR2ltgrWcRMO8T1tl0EYcI8BRgNBdD18t6YoW6tNASy5OdXpMwt/SfFTROTkNgLlNSamUlguW8TZ6zN87kV3FgRRr4dtyGvCw3duZ03exlgpx0uzHMqiW9tTs6cuJXr7r2VGUIQxRYUYh9cmLKSEpTfVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTDlhxfBr2FRYV4DdhoZowXYS0/D8i5V8jOhiXsuEHE=;
 b=LWgMWUdeZ90kQkdEcHFlssMA62MNWKLSEMs/W8tqxr2trtTncUSpXI8Nl070ApaC0Yh8vrWc7xiChMJU8AME8p7PwWPtJuwkyERsQfzbH9EizICjh4R7j1aW/Jnui+RD9V3llJvGFAUnPhXIN9AMZJLca5dbFWL8meNUhvIOT91pIX7H129fXsvfQkduZuxw/VQUOV1LF+zkPwYHRF+LwH/ds/mi4yYT0tMEaQdunRp8cjwYaK66p9xUg+LgJYYJoG94VaBLbXJ7zr60MVcM5piBw2IGyIYlY9ST8k2a7tbZAT6Vs1CVvNrA0s8vR4pm/Ujhu9xaZho6SyQkmvIZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTDlhxfBr2FRYV4DdhoZowXYS0/D8i5V8jOhiXsuEHE=;
 b=GNwltWTxz4dwbmN3Duyqs54PlgydVNybqHKP1YBTrHsHJ/iEkiOIp2hoKrz6O+m8EcfjeV4zFay3wam6Vfocyde9kzqcuEu+50sk76C6jIRQbfdLoej+26d95v8dd0lMFZCDnsLWM832Fil/Eiv3BaJxlonSEnVJ1z66atweKGs=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3199.namprd18.prod.outlook.com (10.255.236.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 09:56:52 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 09:56:51 +0000
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
Subject: Re: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVY9A9KbbGxFDTYEGZB0MjKa34ew==
Date:   Thu, 5 Sep 2019 09:56:51 +0000
Message-ID: <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
References: <20190905083745.6899-1-hhhawa@amazon.com>
In-Reply-To: <20190905083745.6899-1-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0029.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce4ff040-1a23-4e27-a61b-08d731e7600b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3199;
x-ms-traffictypediagnostic: MN2PR18MB3199:
x-microsoft-antispam-prvs: <MN2PR18MB3199642E533EEF5458136B7DD9BB0@MN2PR18MB3199.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(51914003)(199004)(189003)(66556008)(64756008)(66446008)(81166006)(81156014)(8936002)(99286004)(66476007)(66946007)(2906002)(8676002)(486006)(6916009)(5660300002)(71190400001)(71200400001)(386003)(86362001)(1076003)(53546011)(6506007)(76176011)(102836004)(7416002)(4326008)(25786009)(52116002)(53936002)(478600001)(66066001)(6246003)(11346002)(26005)(6436002)(14454004)(446003)(14444005)(229853002)(476003)(54906003)(6512007)(9686003)(256004)(186003)(7736002)(3846002)(6486002)(6116002)(305945005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3199;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: isQkmRwuG85snua9lPUpf9w3cfA68ItWD4ymR/e9mNnWuZYEfgvjjbBVmiE6xtZGktd0/+NkIWNiYK6sBQDwaM+KWOqF6eWTtMzhkY3p5SnoSK3MnE9oXxu3udEbSkMOoxzaVnYmY94TivXVCPtu2gUmGL6aZ0t0509TFJmmcvY81dzbXkP82gp9TposFi69jrpXN6+9La8JKDNzRVsmP3fP3bo584TUMLHlM5nUy1YjxpZYp9he3C9fL4iUzhm9HJyeqBw9UREwBx21BUmD5wvYRI958E6nWCWFoQBAxNplLOMuf8+AJ5avZQu5cHsca07agkXctosY5rO5h4MSlFjhhZOHkLGD7iREgrJIQ66LpjtDkoDRed+uNSPqEv72fspQu9vEOVYM0NLzamcx3bhW2LwiS6ysgg/uK1uBBYI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3981BEE756BD904E93F3326D5C3B809C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4ff040-1a23-4e27-a61b-08d731e7600b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 09:56:51.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byEmWRuG1mrse1oTpJdlJFvmCBYJ3Krz5oelAdZ+lcx0WYiKDJPltNlnwAY62fPPVzg9HbiAItq0/81QB8qE4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3199
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_03:2019-09-04,2019-09-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hanna,

thanks for the update. See below.

On 05.09.19 09:37:45, Hanna Hawa wrote:
> Add an API for edac device to report multiple errors with same type.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/edac/edac_device.c | 66 +++++++++++++++++++++++++++++---------
>  drivers/edac/edac_device.h | 31 ++++++++++++++++--
>  2 files changed, 79 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9355c4..bf6a4fd9831b 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -555,12 +555,15 @@ static inline int edac_device_get_panic_on_ue(struc=
t edac_device_ctl_info
>  	return edac_dev->panic_on_ue;
>  }
> =20
> -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +static void __edac_device_handle_ce(struct edac_device_ctl_info *edac_de=
v,
> +			   u16 error_count, int inst_nr, int block_nr,

Just curious, why u16, some register mask size? Maybe just use unsigned int=
?

I think the variable can be shortened to 'count', the meaning should
still be clear.

> +			   const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block =3D NULL;
> =20
> +	WARN_ON(!error_count);

Should return in this case.

Better use WARN_ON_ONCE() to avoid flooding.

The check should be moved to edac_device_handle_ce_count().

> +
>  	if ((inst_nr >=3D edac_dev->nr_instances) || (inst_nr < 0)) {
>  		edac_device_printk(edac_dev, KERN_ERR,
>  				"INTERNAL ERROR: 'instance' out of range "
> @@ -582,27 +585,44 @@ void edac_device_handle_ce(struct edac_device_ctl_i=
nfo *edac_dev,
> =20
>  	if (instance->nr_blocks > 0) {
>  		block =3D instance->blocks + block_nr;
> -		block->counters.ce_count++;
> +		block->counters.ce_count +=3D error_count;
>  	}
> =20
>  	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ce_count++;
> -	edac_dev->counters.ce_count++;
> +	instance->counters.ce_count +=3D error_count;
> +	edac_dev->counters.ce_count +=3D error_count;
> =20
>  	if (edac_device_get_log_ce(edac_dev))
>  		edac_device_printk(edac_dev, KERN_WARNING,
> -				"CE: %s instance: %s block: %s '%s'\n",
> +				"CE: %s instance: %s block: %s count: %d '%s'\n",
>  				edac_dev->ctl_name, instance->name,
> -				block ? block->name : "N/A", msg);
> +				block ? block->name : "N/A", error_count, msg);
> +}
> +
> +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> +			   int inst_nr, int block_nr, const char *msg)
> +{
> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ce);

We could just export the __*() version of those functions and make
everything else inline in the header file? Though, better do this with
two patches to avoid an ABI breakage in case someone wants to backport
it. Let's see what others say here.

> =20
> -void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
> +				 u16 error_count, int inst_nr, int block_nr,
> +				 const char *msg)
> +{
> +	__edac_device_handle_ce(edac_dev, error_count, inst_nr, block_nr, msg);
> +}
> +EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
> +
> +static void __edac_device_handle_ue(struct edac_device_ctl_info *edac_de=
v,
> +			   u16 error_count, int inst_nr, int block_nr,
> +			   const char *msg)

All the above applies for this function too.

>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block =3D NULL;
> =20
> +	WARN_ON(!error_count);
> +
>  	if ((inst_nr >=3D edac_dev->nr_instances) || (inst_nr < 0)) {
>  		edac_device_printk(edac_dev, KERN_ERR,
>  				"INTERNAL ERROR: 'instance' out of range "
> @@ -624,22 +644,36 @@ void edac_device_handle_ue(struct edac_device_ctl_i=
nfo *edac_dev,
> =20
>  	if (instance->nr_blocks > 0) {
>  		block =3D instance->blocks + block_nr;
> -		block->counters.ue_count++;
> +		block->counters.ue_count +=3D error_count;
>  	}
> =20
>  	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ue_count++;
> -	edac_dev->counters.ue_count++;
> +	instance->counters.ue_count +=3D error_count;
> +	edac_dev->counters.ue_count +=3D error_count;
> =20
>  	if (edac_device_get_log_ue(edac_dev))
>  		edac_device_printk(edac_dev, KERN_EMERG,
> -				"UE: %s instance: %s block: %s '%s'\n",
> +				"UE: %s instance: %s block: %s count: %d '%s'\n",
>  				edac_dev->ctl_name, instance->name,
> -				block ? block->name : "N/A", msg);
> +				block ? block->name : "N/A", error_count, msg);
> =20
>  	if (edac_device_get_panic_on_ue(edac_dev))
> -		panic("EDAC %s: UE instance: %s block %s '%s'\n",
> +		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
>  			edac_dev->ctl_name, instance->name,
> -			block ? block->name : "N/A", msg);
> +			block ? block->name : "N/A", error_count, msg);
> +}
> +
> +void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> +			   int inst_nr, int block_nr, const char *msg)
> +{
> +	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue);
> +
> +void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
> +				 u16 error_count, int inst_nr, int block_nr,
> +				 const char *msg)
> +{
> +	__edac_device_handle_ue(edac_dev, error_count, inst_nr, block_nr, msg);
> +}
> +EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index 1aaba74ae411..c8dc83eda64f 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -287,7 +287,7 @@ extern struct edac_device_ctl_info *edac_device_del_d=
evice(struct device *dev);
> =20
>  /**
>   * edac_device_handle_ue():
> - *	perform a common output and handling of an 'edac_dev' UE event
> + *	perform a common output and handling of an 'edac_dev' single UE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
>   * @inst_nr: number of the instance where the UE error happened
> @@ -298,7 +298,7 @@ extern void edac_device_handle_ue(struct edac_device_=
ctl_info *edac_dev,
>  				int inst_nr, int block_nr, const char *msg);
>  /**
>   * edac_device_handle_ce():
> - *	perform a common output and handling of an 'edac_dev' CE event
> + *	perform a common output and handling of an 'edac_dev' single CE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
>   * @inst_nr: number of the instance where the CE error happened
> @@ -308,6 +308,33 @@ extern void edac_device_handle_ue(struct edac_device=
_ctl_info *edac_dev,
>  extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>  				int inst_nr, int block_nr, const char *msg);
> =20
> +/**
> + * edac_device_handle_ue_count():
> + *	perform a common output and handling of an 'edac_dev'
> + *
> + * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
> + * @inst_nr: number of the instance where the UE error happened
> + * @block_nr: number of the block where the UE error happened
> + * @msg: message to be printed
> + */
> +extern void edac_device_handle_ue_count(struct edac_device_ctl_info *eda=
c_dev,
> +					u16 error_count, int inst_nr,
> +					int block_nr, const char *msg);
> +/**
> + * edac_device_handle_ce_count():
> + *	perform a common output and handling of an 'edac_dev'
> + *
> + * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
> + * @inst_nr: number of the instance where the CE error happened
> + * @block_nr: number of the block where the CE error happened
> + * @msg: message to be printed
> + */
> +extern void edac_device_handle_ce_count(struct edac_device_ctl_info *eda=
c_dev,
> +					u16 error_count, int inst_nr,
> +					int block_nr, const char *msg);
> +

Looks otherwise good to me.

Thanks,

-Robert

>  /**
>   * edac_device_alloc_index: Allocate a unique device index number
>   *
> --=20
> 2.17.1
>=20
