Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7086C6BC19
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2019 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfGQMGn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jul 2019 08:06:43 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51838 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfGQMGm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Jul 2019 08:06:42 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6HC5jtw023309;
        Wed, 17 Jul 2019 05:06:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=r2c/Q2xh6fn0lKqEAP2Z4ukWyze7ud+LTcH1OXwPQQA=;
 b=l0dCo4rR2j1dZDlUedZeZurdC8j1rHt1lxEdM5SlGrWBbTHhz4le362a0xePNkOV0SuC
 YsKCdKZBRFmFttOghyD1UoErIZGateku9Eo1B9Sm3k3IH1XV419Qyj9WQYwI6T/9H1iV
 XvB6e+b3Or24H9G6fZAo2j9v+XB3dPxpXhO8/fEayptChIwDRsCZxCLLBWQpF3ikxjVB
 EVTgCXnNUea9kgYuwLhmTl8Noz6ZStL0TDM2M3djJzW/AIyr8RdNlweFwRddwy71B+1/
 mgiUzlWxxFNHDvCi9Dp4eYEdEx87sMfz5c4xfr3vn3AgUNNccLeRQ4+8QJ4mS4QZDqcM YQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ts07vg2mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 05:06:13 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 17 Jul
 2019 05:06:11 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 17 Jul 2019 05:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng8qnU4A02Z4iLs5mzqNaeDOvDOTggtuGfGvP3BUG/oTCPWWeqjAt0rkGWgLPAXLZqL9G9c8qiNONuxJlrhJWWdziQ5GZhK/RSjV6TdCDRgmk538V0EYRyFcwqZ/NDmUrOdcmAIqn7/V5PPa+jpep0V9pplX5wk6S9cI8XAWl/KsT8uLjCzUmHWwytTHNzTTRcg3qfkTex8qK4XAsf4H3gJgTMRZ3U7xv8E3p9KI0C4pMz9DORtTDGtqJ3Y4NWS5wYFLVVXcBOdqKQ64aogDCY4QGWGRHv4JG0gqNLMlb4cA+hfT5AiuqB0iqyvxx5GhvefQ3sS1LFf2gVtI+R3IpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2c/Q2xh6fn0lKqEAP2Z4ukWyze7ud+LTcH1OXwPQQA=;
 b=gaaue60foiuBtKy3ckiTRjNJbncK8/xMiP0P0rAXtXMAIMU1LdIRDCp77fwVshV7nJwQfEa3m1skR3QUi0pMYIl2r1aOHuOgOuWYsfwLEQGt2k8iWk19sGe0caLp0WyncRE1zwRuK4Z24mt1LrUDnwiojQ2B2vNG8nWySGsJPHeJcplfQ6KsRP65LQViUBIhVFBwyyYSQrdY27/l+nkDQg3YfhKAOI2FPtd3gRhrfGUExixjjn76ER3PydDqkTgaIt61mq9HkwpbnbB3jxw62aQk5V4f1I/h8LY6vOmjG/SBUge9GjRzoByFw/i1Ag/YTjraI5YtVNWxWjZd30GLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2c/Q2xh6fn0lKqEAP2Z4ukWyze7ud+LTcH1OXwPQQA=;
 b=qc+7gJXsCgVPi7yaXupZKZZxTaJvxHOx1PPBreYOrIUFA2zi4yrFGj+ZXnUYinI4G/wApC32jcGYlQFoSa9MkptsT3yhcWsGdofkNfXDet5yjaWbQy9TvN8Ez5WnGl3rWVKY8CdTHdMdDOLX37dpyeEDXUNAfDtT+pIO0UvLWF4=
Received: from SN1PR18MB2350.namprd18.prod.outlook.com (52.132.200.27) by
 SN1PR18MB2254.namprd18.prod.outlook.com (52.132.199.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Wed, 17 Jul 2019 12:06:04 +0000
Received: from SN1PR18MB2350.namprd18.prod.outlook.com
 ([fe80::9156:b54:bb13:575c]) by SN1PR18MB2350.namprd18.prod.outlook.com
 ([fe80::9156:b54:bb13:575c%7]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 12:06:04 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        "ckadabi@codeaurora.org" <ckadabi@codeaurora.org>,
        "vnkgutta@codeaurora.org" <vnkgutta@codeaurora.org>,
        "jglauber@cavium.com" <jglauber@cavium.com>,
        "khuong@os.amperecomputing.com" <khuong@os.amperecomputing.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
Thread-Topic: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
Thread-Index: AQHVPJgCAa56dedsv0iAMRqef9bjGA==
Date:   Wed, 17 Jul 2019 12:06:04 +0000
Message-ID: <20190717120553.GA10626@hc>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
In-Reply-To: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0063.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::40) To SN1PR18MB2350.namprd18.prod.outlook.com
 (2603:10b6:802:30::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.67.134.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fad783a4-5e83-4700-45f4-08d70aaf23e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN1PR18MB2254;
x-ms-traffictypediagnostic: SN1PR18MB2254:
x-microsoft-antispam-prvs: <SN1PR18MB2254D1A95ACEA5BF2FADA139D8C90@SN1PR18MB2254.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(71200400001)(68736007)(386003)(76176011)(52116002)(81156014)(71190400001)(6512007)(9686003)(8936002)(186003)(33716001)(99286004)(6506007)(33656002)(53936002)(7416002)(26005)(6486002)(81166006)(53946003)(316002)(102836004)(25786009)(478600001)(6436002)(7736002)(476003)(446003)(66556008)(11346002)(66476007)(4326008)(86362001)(14444005)(486006)(54906003)(66946007)(305945005)(2906002)(66446008)(5660300002)(14454004)(66066001)(6116002)(30864003)(3846002)(6916009)(8676002)(1076003)(256004)(64756008)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR18MB2254;H:SN1PR18MB2350.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nw4qReU+NYnr0kb2YYetrr+XwzG/IB4b2M9OotRNV12PM8ipl3RyGbybdMt8WdQbsystWkuVzXtbEyBXBe25xfkcv3pRwrcMBgz/PwvoQNwmn+Da4kKKMz0plLqPmkKlEGgRIbsWSvYiQ9EQJ3q2ca9rMPxXp/6x1jHBs5uCSlGLAiHLI0aHjrumYc0mzV7nSbLeFXSvyXNbXZCqOG9nKG+9mDWrvwaV2o/5Tqx5sOhYu/eT+TV8lFhOs/MRlOhrKdHufJgx36/EriZfPxy8vTeuZ1x8++6HZ+7P1kXqzYJ1mCDZHXo4RJsUf1Rl5TBq6xK1lmUKeBFZnf2rotvKMJx+iS6c52OIfm+cRHPFyOuu//PtKKTjk8UyRm5nEJSDgH184vkuvxd2aC1qhgQaF8jxS6FmsrS8fIw8APPUz48=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F395EBDBA9C11C4EBC8A7D31A9849637@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fad783a4-5e83-4700-45f4-08d70aaf23e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 12:06:04.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jglauber@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2254
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-17_04:2019-07-17,2019-07-17 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 15, 2019 at 01:53:07PM +0300, Hanna Hawa wrote:
> Add a counter parameter in order to avoid losing errors count for edac
> device, the error count reports the number of errors reported by an edac
> device similar to the way MC_EDAC do.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/edac/altera_edac.c      | 20 ++++++++++++--------
>  drivers/edac/amd8111_edac.c     |  6 +++---
>  drivers/edac/cpc925_edac.c      |  4 ++--
>  drivers/edac/edac_device.c      | 18 ++++++++++--------
>  drivers/edac/edac_device.h      |  8 ++++++--
>  drivers/edac/highbank_l2_edac.c |  4 ++--
>  drivers/edac/mpc85xx_edac.c     |  4 ++--
>  drivers/edac/mv64x60_edac.c     |  4 ++--
>  drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
>  drivers/edac/octeon_edac-pc.c   |  6 +++---
>  drivers/edac/qcom_edac.c        |  8 ++++----
>  drivers/edac/thunderx_edac.c    | 10 +++++-----
>  drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
>  13 files changed, 74 insertions(+), 64 deletions(-)

Hi Hanna,

I'm probably missing something but this patch looks like while it adds
the error_count parameter the passed values all seem to be 1. So is the
new parameter used otherwise, maybe in another patch?

thanks,
Jan

> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8816f74..747dd43 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -616,12 +616,12 @@ static irqreturn_t altr_edac_device_handler(int irq=
, void *dev_id)
>  	if (irq =3D=3D drvdata->sb_irq) {
>  		if (priv->ce_clear_mask)
>  			writel(priv->ce_clear_mask, drvdata->base);
> -		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
> +		edac_device_handle_ce(dci, 1, 0, 0, drvdata->edac_dev_name);
>  		ret_value =3D IRQ_HANDLED;
>  	} else if (irq =3D=3D drvdata->db_irq) {
>  		if (priv->ue_clear_mask)
>  			writel(priv->ue_clear_mask, drvdata->base);
> -		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
> +		edac_device_handle_ue(dci, 1, 0, 0, drvdata->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>  		ret_value =3D IRQ_HANDLED;
>  	} else {
> @@ -919,13 +919,15 @@ static irqreturn_t __maybe_unused altr_edac_a10_ecc=
_irq(int irq, void *dev_id)
>  	if (irq =3D=3D dci->sb_irq) {
>  		writel(ALTR_A10_ECC_SERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
> =20
>  		return IRQ_HANDLED;
>  	} else if (irq =3D=3D dci->db_irq) {
>  		writel(ALTR_A10_ECC_DERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  		if (dci->data->panic)
>  			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> =20
> @@ -1308,14 +1310,16 @@ static irqreturn_t altr_edac_a10_l2_irq(int irq, =
void *dev_id)
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
> -		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
> =20
>  		return IRQ_HANDLED;
>  	} else if (irq =3D=3D dci->db_irq) {
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
> -		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> =20
>  		return IRQ_HANDLED;
> @@ -1652,12 +1656,12 @@ static irqreturn_t altr_edac_a10_ecc_irq_portb(in=
t irq, void *dev_id)
>  	if (irq =3D=3D ad->sb_irq) {
>  		writel(priv->ce_clear_mask,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ce(ad->edac_dev, 0, 0, ad->edac_dev_name);
> +		edac_device_handle_ce(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
>  		return IRQ_HANDLED;
>  	} else if (irq =3D=3D ad->db_irq) {
>  		writel(priv->ue_clear_mask,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ue(ad->edac_dev, 0, 0, ad->edac_dev_name);
> +		edac_device_handle_ue(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
>  		return IRQ_HANDLED;
>  	}
> =20
> diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
> index b5786cf..e595fab 100644
> --- a/drivers/edac/amd8111_edac.c
> +++ b/drivers/edac/amd8111_edac.c
> @@ -303,7 +303,7 @@ static void amd8111_lpc_bridge_check(struct edac_devi=
ce_ctl_info *edac_dev)
>  		val8 |=3D IO_CTRL_1_CLEAR_MASK;
>  		edac_pci_write_byte(dev, REG_IO_CTRL_1, val8);
> =20
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  	}
> =20
>  	if (at_compat_reg_broken =3D=3D 0) {
> @@ -315,8 +315,8 @@ static void amd8111_lpc_bridge_check(struct edac_devi=
ce_ctl_info *edac_dev)
>  			out8 |=3D AT_COMPAT_CLRIOCHK;
>  		if (out8 > 0) {
>  			__do_outb(out8, REG_AT_COMPAT);
> -			edac_device_handle_ue(edac_dev, 0, 0,
> -						edac_dev->ctl_name);
> +			edac_device_handle_ue(edac_dev, 1, 0, 0,
> +					      edac_dev->ctl_name);
>  		}
>  	}
>  }
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index 3c0881a..eb74865 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -682,7 +682,7 @@ static void cpc925_cpu_check(struct edac_device_ctl_i=
nfo *edac_dev)
>  	cpc925_printk(KERN_INFO, "APIMASK		0x%08x\n", apimask);
>  	cpc925_printk(KERN_INFO, "APIEXCP		0x%08x\n", apiexcp);
> =20
> -	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  /******************** HT Link err device****************************/
> @@ -756,7 +756,7 @@ static void cpc925_htlink_check(struct edac_device_ct=
l_info *edac_dev)
>  		__raw_writel(HT_LINKERR_DETECTED,
>  				dev_info->vbase + REG_LINKERR_OFFSET);
> =20
> -	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static struct cpc925_dev_info cpc925_devs[] =3D {
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9..d1de296 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -556,7 +556,8 @@ static inline int edac_device_get_panic_on_ue(struct =
edac_device_ctl_info
>  }
> =20
>  void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +			   u16 error_count, int inst_nr, int block_nr,
> +			   const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block =3D NULL;
> @@ -582,12 +583,12 @@ void edac_device_handle_ce(struct edac_device_ctl_i=
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
> @@ -598,7 +599,8 @@ void edac_device_handle_ce(struct edac_device_ctl_inf=
o *edac_dev,
>  EXPORT_SYMBOL_GPL(edac_device_handle_ce);
> =20
>  void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +			   u16 error_count, int inst_nr, int block_nr,
> +			   const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block =3D NULL;
> @@ -624,12 +626,12 @@ void edac_device_handle_ue(struct edac_device_ctl_i=
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
> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index 1aaba74..cf1a1da 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -290,23 +290,27 @@ extern struct edac_device_ctl_info *edac_device_del=
_device(struct device *dev);
>   *	perform a common output and handling of an 'edac_dev' UE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
>   * @inst_nr: number of the instance where the UE error happened
>   * @block_nr: number of the block where the UE error happened
>   * @msg: message to be printed
>   */
>  extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> +				  u16 error_count, int inst_nr, int block_nr,
> +				  const char *msg);
>  /**
>   * edac_device_handle_ce():
>   *	perform a common output and handling of an 'edac_dev' CE event
>   *
>   * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @error_count: number of errors of the same type
>   * @inst_nr: number of the instance where the CE error happened
>   * @block_nr: number of the block where the CE error happened
>   * @msg: message to be printed
>   */
>  extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> +				  u16 error_count, int inst_nr, int block_nr,
> +				  const char *msg);
> =20
>  /**
>   * edac_device_alloc_index: Allocate a unique device index number
> diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_e=
dac.c
> index cd9a2bb..65f016a 100644
> --- a/drivers/edac/highbank_l2_edac.c
> +++ b/drivers/edac/highbank_l2_edac.c
> @@ -39,11 +39,11 @@ static irqreturn_t highbank_l2_err_handler(int irq, v=
oid *dev_id)
> =20
>  	if (irq =3D=3D drvdata->sb_irq) {
>  		writel(1, drvdata->base + SR_CLR_SB_ECC_INTR);
> -		edac_device_handle_ce(dci, 0, 0, dci->ctl_name);
> +		edac_device_handle_ce(dci, 1, 0, 0, dci->ctl_name);
>  	}
>  	if (irq =3D=3D drvdata->db_irq) {
>  		writel(1, drvdata->base + SR_CLR_DB_ECC_INTR);
> -		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
> +		edac_device_handle_ue(dci, 1, 0, 0, dci->ctl_name);
>  	}
> =20
>  	return IRQ_HANDLED;
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 67f7bc3..0618a06 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -464,10 +464,10 @@ static void mpc85xx_l2_check(struct edac_device_ctl=
_info *edac_dev)
>  	out_be32(pdata->l2_vbase + MPC85XX_L2_ERRDET, err_detect);
> =20
>  	if (err_detect & L2_EDE_CE_MASK)
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
> =20
>  	if (err_detect & L2_EDE_UE_MASK)
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static irqreturn_t mpc85xx_l2_isr(int irq, void *dev_id)
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
> index 3c68bb5..005b012 100644
> --- a/drivers/edac/mv64x60_edac.c
> +++ b/drivers/edac/mv64x60_edac.c
> @@ -251,7 +251,7 @@ static void mv64x60_sram_check(struct edac_device_ctl=
_info *edac_dev)
>  	       readl(pdata->sram_vbase + MV64X60_SRAM_ERR_PARITY));
>  	writel(0, pdata->sram_vbase + MV64X60_SRAM_ERR_CAUSE);
> =20
> -	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static irqreturn_t mv64x60_sram_isr(int irq, void *dev_id)
> @@ -417,7 +417,7 @@ static void mv64x60_cpu_check(struct edac_device_ctl_=
info *edac_dev)
>  	       readl(pdata->cpu_vbase[1] + MV64x60_CPU_ERR_PARITY));
>  	writel(0, pdata->cpu_vbase[1] + MV64x60_CPU_ERR_CAUSE);
> =20
> -	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static irqreturn_t mv64x60_cpu_isr(int irq, void *dev_id)
> diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2=
c.c
> index c33059e..8e58531 100644
> --- a/drivers/edac/octeon_edac-l2c.c
> +++ b/drivers/edac/octeon_edac-l2c.c
> @@ -28,12 +28,12 @@ static void octeon_l2c_poll_oct1(struct edac_device_c=
tl_info *l2c)
>  	l2t_err_reset.u64 =3D 0;
>  	l2t_err.u64 =3D cvmx_read_csr(CVMX_L2T_ERR);
>  	if (l2t_err.s.sec_err) {
> -		edac_device_handle_ce(l2c, 0, 0,
> +		edac_device_handle_ce(l2c, 1, 0, 0,
>  				      "Tag Single bit error (corrected)");
>  		l2t_err_reset.s.sec_err =3D 1;
>  	}
>  	if (l2t_err.s.ded_err) {
> -		edac_device_handle_ue(l2c, 0, 0,
> +		edac_device_handle_ue(l2c, 1, 0, 0,
>  				      "Tag Double bit error (detected)");
>  		l2t_err_reset.s.ded_err =3D 1;
>  	}
> @@ -43,12 +43,12 @@ static void octeon_l2c_poll_oct1(struct edac_device_c=
tl_info *l2c)
>  	l2d_err_reset.u64 =3D 0;
>  	l2d_err.u64 =3D cvmx_read_csr(CVMX_L2D_ERR);
>  	if (l2d_err.s.sec_err) {
> -		edac_device_handle_ce(l2c, 0, 1,
> +		edac_device_handle_ce(l2c, 1, 0, 1,
>  				      "Data Single bit error (corrected)");
>  		l2d_err_reset.s.sec_err =3D 1;
>  	}
>  	if (l2d_err.s.ded_err) {
> -		edac_device_handle_ue(l2c, 0, 1,
> +		edac_device_handle_ue(l2c, 1, 0, 1,
>  				      "Data Double bit error (detected)");
>  		l2d_err_reset.s.ded_err =3D 1;
>  	}
> @@ -76,25 +76,25 @@ static void _octeon_l2c_poll_oct2(struct edac_device_=
ctl_info *l2c, int tad)
>  		snprintf(buf2, sizeof(buf2),
>  			 "L2D Double bit error (detected):%s", buf1);
>  		err_tdtx_reset.s.dbe =3D 1;
> -		edac_device_handle_ue(l2c, tad, 1, buf2);
> +		edac_device_handle_ue(l2c, 1, tad, 1, buf2);
>  	}
>  	if (err_tdtx.s.sbe) {
>  		snprintf(buf2, sizeof(buf2),
>  			 "L2D Single bit error (corrected):%s", buf1);
>  		err_tdtx_reset.s.sbe =3D 1;
> -		edac_device_handle_ce(l2c, tad, 1, buf2);
> +		edac_device_handle_ce(l2c, 1, tad, 1, buf2);
>  	}
>  	if (err_tdtx.s.vdbe) {
>  		snprintf(buf2, sizeof(buf2),
>  			 "VBF Double bit error (detected):%s", buf1);
>  		err_tdtx_reset.s.vdbe =3D 1;
> -		edac_device_handle_ue(l2c, tad, 1, buf2);
> +		edac_device_handle_ue(l2c, 1, tad, 1, buf2);
>  	}
>  	if (err_tdtx.s.vsbe) {
>  		snprintf(buf2, sizeof(buf2),
>  			 "VBF Single bit error (corrected):%s", buf1);
>  		err_tdtx_reset.s.vsbe =3D 1;
> -		edac_device_handle_ce(l2c, tad, 1, buf2);
> +		edac_device_handle_ce(l2c, 1, tad, 1, buf2);
>  	}
>  	if (err_tdtx_reset.u64)
>  		cvmx_write_csr(CVMX_L2C_ERR_TDTX(tad), err_tdtx_reset.u64);
> @@ -111,13 +111,13 @@ static void _octeon_l2c_poll_oct2(struct edac_devic=
e_ctl_info *l2c, int tad)
>  		snprintf(buf2, sizeof(buf2),
>  			 "Tag Double bit error (detected):%s", buf1);
>  		err_ttgx_reset.s.dbe =3D 1;
> -		edac_device_handle_ue(l2c, tad, 0, buf2);
> +		edac_device_handle_ue(l2c, 1, tad, 0, buf2);
>  	}
>  	if (err_ttgx.s.sbe) {
>  		snprintf(buf2, sizeof(buf2),
>  			 "Tag Single bit error (corrected):%s", buf1);
>  		err_ttgx_reset.s.sbe =3D 1;
> -		edac_device_handle_ce(l2c, tad, 0, buf2);
> +		edac_device_handle_ce(l2c, 1, tad, 0, buf2);
>  	}
>  	if (err_ttgx_reset.u64)
>  		cvmx_write_csr(CVMX_L2C_ERR_TTGX(tad), err_ttgx_reset.u64);
> diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.=
c
> index 754eced..efd0bbc 100644
> --- a/drivers/edac/octeon_edac-pc.c
> +++ b/drivers/edac/octeon_edac-pc.c
> @@ -59,7 +59,7 @@ static int  co_cache_error_event(struct notifier_block =
*this,
>  				   (unsigned long long)icache_err, core, cpu,
>  				   read_c0_errorepc());
>  		write_octeon_c0_icacheerr(0);
> -		edac_device_handle_ce(p->ed, cpu, 1, "icache");
> +		edac_device_handle_ce(p->ed, 1, cpu, 1, "icache");
>  	}
>  	if (dcache_err & 1) {
>  		edac_device_printk(p->ed, KERN_ERR,
> @@ -67,9 +67,9 @@ static int  co_cache_error_event(struct notifier_block =
*this,
>  				   (unsigned long long)dcache_err, core, cpu,
>  				   read_c0_errorepc());
>  		if (event)
> -			edac_device_handle_ue(p->ed, cpu, 0, "dcache");
> +			edac_device_handle_ue(p->ed, 1, cpu, 0, "dcache");
>  		else
> -			edac_device_handle_ce(p->ed, cpu, 0, "dcache");
> +			edac_device_handle_ce(p->ed, 1, cpu, 0, "dcache");
> =20
>  		/* Clear the error indication */
>  		if (OCTEON_IS_OCTEON2())
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 97a27e4..8730eed 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -261,19 +261,19 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl,=
 int err_type, u32 bank)
> =20
>  	switch (err_type) {
>  	case LLCC_DRAM_CE:
> -		edac_device_handle_ce(edev_ctl, 0, bank,
> +		edac_device_handle_ce(edev_ctl, 1, 0, bank,
>  				      "LLCC Data RAM correctable Error");
>  		break;
>  	case LLCC_DRAM_UE:
> -		edac_device_handle_ue(edev_ctl, 0, bank,
> +		edac_device_handle_ue(edev_ctl, 1, 0, bank,
>  				      "LLCC Data RAM uncorrectable Error");
>  		break;
>  	case LLCC_TRAM_CE:
> -		edac_device_handle_ce(edev_ctl, 0, bank,
> +		edac_device_handle_ce(edev_ctl, 1, 0, bank,
>  				      "LLCC Tag RAM correctable Error");
>  		break;
>  	case LLCC_TRAM_UE:
> -		edac_device_handle_ue(edev_ctl, 0, bank,
> +		edac_device_handle_ue(edev_ctl, 1, 0, bank,
>  				      "LLCC Tag RAM uncorrectable Error");
>  		break;
>  	default:
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 34be60f..35a186f 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1151,7 +1151,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(in=
t irq, void *irq_id)
>  			}
> =20
>  		if (ctx->reg_com_int & OCX_COM_INT_CE)
> -			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
> +			edac_device_handle_ce(ocx->edac_dev, 1, 0, 0, msg);
> =20
>  		ocx->com_ring_tail++;
>  	}
> @@ -1220,9 +1220,9 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(in=
t irq, void *irq_id)
>  		strncat(msg, other, OCX_MESSAGE_SIZE);
> =20
>  		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
> -			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
> +			edac_device_handle_ue(ocx->edac_dev, 1, 0, 0, msg);
>  		else if (ctx->reg_com_link_int & OCX_COM_LINK_INT_CE)
> -			edac_device_handle_ce(ocx->edac_dev, 0, 0, msg);
> +			edac_device_handle_ce(ocx->edac_dev, 1, 0, 0, msg);
> =20
>  		ocx->link_ring_tail++;
>  	}
> @@ -1899,9 +1899,9 @@ static irqreturn_t thunderx_l2c_threaded_isr(int ir=
q, void *irq_id)
>  		strncat(msg, other, L2C_MESSAGE_SIZE);
> =20
>  		if (ctx->reg_int & mask_ue)
> -			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
> +			edac_device_handle_ue(l2c->edac_dev, 1, 0, 0, msg);
>  		else if (ctx->reg_int & mask_ce)
> -			edac_device_handle_ce(l2c->edac_dev, 0, 0, msg);
> +			edac_device_handle_ce(l2c->edac_dev, 1, 0, 0, msg);
> =20
>  		l2c->ring_tail++;
>  	}
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index e8b81d7..d31a8bb 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -574,7 +574,7 @@ static void xgene_edac_pmd_l1_check(struct edac_devic=
e_ctl_info *edac_dev,
> =20
>  	if (val & (MEMERR_CPU_ICFESR_CERR_MASK |
>  		   MEMERR_CPU_ICFESR_MULTCERR_MASK))
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
> =20
>  chk_lsu:
>  	val =3D readl(pg_f + MEMERR_CPU_LSUESR_PAGE_OFFSET);
> @@ -618,7 +618,7 @@ static void xgene_edac_pmd_l1_check(struct edac_devic=
e_ctl_info *edac_dev,
> =20
>  	if (val & (MEMERR_CPU_LSUESR_CERR_MASK |
>  		   MEMERR_CPU_LSUESR_MULTCERR_MASK))
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
> =20
>  chk_mmu:
>  	val =3D readl(pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
> @@ -665,7 +665,7 @@ static void xgene_edac_pmd_l1_check(struct edac_devic=
e_ctl_info *edac_dev,
>  	/* Clear any HW errors */
>  	writel(val, pg_f + MEMERR_CPU_MMUESR_PAGE_OFFSET);
> =20
> -	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static void xgene_edac_pmd_l2_check(struct edac_device_ctl_info *edac_de=
v)
> @@ -724,10 +724,10 @@ static void xgene_edac_pmd_l2_check(struct edac_dev=
ice_ctl_info *edac_dev)
> =20
>  	if (val & (MEMERR_L2C_L2ESR_ERR_MASK |
>  		   MEMERR_L2C_L2ESR_MULTICERR_MASK))
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  	if (val & (MEMERR_L2C_L2ESR_UCERR_MASK |
>  		   MEMERR_L2C_L2ESR_MULTUCERR_MASK))
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
> =20
>  chk_l2c:
>  	/* Check if any memory request timed out on L2 cache */
> @@ -1113,13 +1113,13 @@ static void xgene_edac_l3_check(struct edac_devic=
e_ctl_info *edac_dev)
> =20
>  	if (ctx->version <=3D 1 &&
>  	    xgene_edac_l3_promote_to_uc_err(l3cesr, l3celr)) {
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  		return;
>  	}
>  	if (l3cesr & L3C_ESR_CERR_MASK)
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  	if (l3cesr & L3C_ESR_UCERR_MASK)
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
> @@ -1449,7 +1449,7 @@ static void xgene_edac_iob_gic_report(struct edac_d=
evice_ctl_info *edac_dev)
>  		writel(err_addr_hi, ctx->dev_csr + GLBL_MSEC_ERRH);
>  	}
>  	if (reg & (SEC_ERR_MASK | MSEC_ERR_MASK))
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
> =20
>  	if (reg & DED_ERR_MASK) {
>  		err_addr_lo =3D readl(ctx->dev_csr + GLBL_DED_ERRL);
> @@ -1470,7 +1470,7 @@ static void xgene_edac_iob_gic_report(struct edac_d=
evice_ctl_info *edac_dev)
>  		writel(err_addr_hi, ctx->dev_csr + GLBL_MDED_ERRH);
>  	}
>  	if (reg & (DED_ERR_MASK | MDED_ERR_MASK))
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
> =20
>  static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
> @@ -1675,7 +1675,7 @@ static void xgene_edac_soc_check(struct edac_device=
_ctl_info *edac_dev)
>  	if (pcp_lp_stat & CSW_SWITCH_TRACE_ERR_MASK) {
>  		dev_info(edac_dev->dev,
>  			 "CSW switch trace correctable memory parity error\n");
> -		edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  	}
> =20
>  	if (!reg)
> @@ -1685,14 +1685,14 @@ static void xgene_edac_soc_check(struct edac_devi=
ce_ctl_info *edac_dev)
>  	if (!soc_mem_err) {
>  		dev_err(edac_dev->dev, "SoC memory parity error 0x%08X\n",
>  			reg);
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  		return;
>  	}
>  	for (i =3D 0; i < 31; i++) {
>  		if (reg & (1 << i)) {
>  			dev_err(edac_dev->dev, "%s memory parity error\n",
>  				soc_mem_err[i]);
> -			edac_device_handle_ue(edac_dev, 0, 0,
> +			edac_device_handle_ue(edac_dev, 1, 0, 0,
>  					      edac_dev->ctl_name);
>  		}
>  	}
> --=20
> 2.7.4
